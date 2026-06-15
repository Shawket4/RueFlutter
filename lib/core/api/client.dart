import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/api_config.dart';
import '../services/connectivity_service.dart';
import '../utils/time_utils.dart';

String? _currentToken;
void setAuthToken(String? token) => _currentToken = token;
String? get currentToken => _currentToken;

/// Set by AuthNotifier so the Dio layer can trigger logout on 401.
void Function()? onUnauthorizedCallback;

/// Set by AuthNotifier so the Dio layer can revalidate the session on a 403.
/// A genuinely-dead token can surface as Forbidden, so we probe `/auth/me` once
/// to tell an expired session (→ logout) apart from a true permission denial
/// (→ leave the session intact and surface a specific message).
void Function()? onForbiddenCallback;

class DioClient {
  late final Dio _dio;

  DioClient() {
    _dio = Dio(BaseOptions(
      baseUrl:        kApiBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      sendTimeout:    const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      headers: const {'Content-Type': 'application/json'},
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        if (_currentToken != null) {
          options.headers['Authorization'] = 'Bearer $_currentToken';
        }
        handler.next(options);
      },
      onResponse: (response, handler) {
        TimeUtils.updateFromHeaders(response.headers.map);
        ConnectivityService.instance.reportSuccess();
        handler.next(response);
      },
      onError: (err, handler) {
        final status = err.response?.statusCode;
        if (status == 401) {
          onUnauthorizedCallback?.call();
        } else if (status == 403) {
          // A 403 may be a dead session masquerading as Forbidden — let auth
          // probe /auth/me once and decide whether to log out or treat it as a
          // real permission denial.
          onForbiddenCallback?.call();
        }
        // Only count network-layer failures (not server 4xx/5xx) as offline signal.
        if (_isNetworkLevelError(err)) {
          ConnectivityService.instance.reportNetworkFailure();
        }
        handler.next(err);
      },
    ));
  }

  Dio get dio => _dio;
}

final dioClientProvider = Provider<DioClient>((ref) => DioClient());

String friendlyError(Object e) {
  if (e is DioException) {
    // ── Timeout / connectivity ──────────────────────────────────────────
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout       ||
        e.type == DioExceptionType.receiveTimeout) {
      return 'Request timed out — check your connection';
    }
    if (e.type == DioExceptionType.connectionError) {
      return 'No internet connection';
    }

    // ── Extract message from response body first ─────────────────────────
    final body = e.response?.data;
    final serverMsg = _extractServerMessage(body);

    final code = e.response?.statusCode;
    if (code == 401) return 'Session expired — please sign in again';
    // Prefer the server's specific reason (e.g. "Permission denied: read
    // delivery_settings") over the generic line, so a real denial reads clearly.
    if (code == 403) return serverMsg ?? 'You do not have permission to do that';
    if (code == 404) return serverMsg ?? 'Not found';
    if (code == 409) return serverMsg ?? 'A conflict occurred — resource already exists';
    if (code == 422) return serverMsg ?? 'Invalid data — please check your input';
    if (code != null && code >= 500) return serverMsg ?? 'Server error — please try again';
    if (serverMsg != null) return serverMsg;
  }
  return 'Something went wrong — please try again';
}

/// Pulls the most useful human-readable string out of a server JSON body.
String? _extractServerMessage(dynamic body) {
  if (body is String && body.isNotEmpty) return body;
  if (body is! Map) return null;

  // Common single-message keys
  for (final key in ['message', 'error', 'detail', 'msg']) {
    final v = body[key];
    if (v is String && v.isNotEmpty) return v;
  }

  // Laravel / Express-style validation errors map
  final errors = body['errors'];
  if (errors is Map && errors.isNotEmpty) {
    final msgs = <String>[];
    for (final entry in errors.entries) {
      final v = entry.value;
      if (v is List) {
        msgs.add('${entry.key}: ${v.join(', ')}');
      } else if (v is String) {
        msgs.add('${entry.key}: $v');
      }
    }
    if (msgs.isNotEmpty) return msgs.join('\n');
  }

  return null;
}

/// True when the error is an HTTP 401 — the token was rejected (expired or
/// invalid), as opposed to a transport failure. Used to tell a dead session
/// apart from a flaky connection so we never proceed as "authenticated" on a
/// token the server has already refused.
bool isUnauthorizedError(Object e) =>
    e is DioException && e.response?.statusCode == 401;

bool isNetworkError(Object e) {
  if (e is DioException) {
    if (e.type == DioExceptionType.connectionError    ||
        e.type == DioExceptionType.connectionTimeout  ||
        e.type == DioExceptionType.sendTimeout        ||
        e.type == DioExceptionType.receiveTimeout) {
      return true;
    }
    if (e.type == DioExceptionType.unknown && e.error is SocketException) {
      return true;
    }
  }
  return false;
}

/// Identical to [isNetworkError] but kept private for the interceptor so we
/// don't count 4xx/5xx server responses as "no internet".
bool _isNetworkLevelError(DioException e) => isNetworkError(e);
