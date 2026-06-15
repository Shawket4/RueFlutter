import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/delivery_order.dart';
import '../providers/auth_notifier.dart';
import '../providers/delivery_orders_notifier.dart';
import '../providers/shift_notifier.dart';
import '../repositories/delivery_order_repository.dart';
import '../utils/haptics.dart';
import '../utils/sounds.dart';
import '../../shared/widgets/new_order_banner.dart';
import 'connectivity_service.dart';
import 'new_order_detector.dart';
import 'notification_service.dart';

/// App-wide realtime engine for the delivery queue.
///
/// Primary path = SSE (`GET /delivery-orders/stream`): the server pushes
/// `created`/`updated` events. Fallback = a 30s poll that runs ONLY while SSE is
/// disconnected, so the two never double-fetch. Both funnel through the same
/// detection point ([_ingest]/[_reconcileFromList]) and the same alert
/// ([_fireNewOrderAlert]), and a seen-id set dedups so an order alerts exactly
/// once across SSE + poll + reconnect overlap.
///
/// The service is driven by [DeliveryRealtimeHost] (mounted on the order screen)
/// which calls [apply] whenever the connect gate changes, plus [pause]/[reevaluate]
/// from the app-lifecycle observer in `main.dart`.
class DeliveryRealtimeService {
  DeliveryRealtimeService(this._ref);
  final Ref _ref;

  CancelToken? _cancel;
  StreamSubscription<String>? _sub;
  Timer? _poll;
  Timer? _backoff;
  int _attempt = 0;
  bool _connected = false;
  bool _connecting = false;
  bool _disposed = false;

  String? _branchId;
  final NewOrderDetector _detector = NewOrderDetector();
  final math.Random _rng = math.Random();

  static const _pollInterval = Duration(seconds: 30);

  // ── Gate ───────────────────────────────────────────────────────────────────

  /// Apply the current connect gate. Connect when online + authenticated + a
  /// shift is open + a branch is known; otherwise tear down. On a branch change
  /// (logout→login) or a session end (shift close / sign out) the queue + dedup
  /// are reset so the next session starts clean.
  void apply({
    required bool online,
    required bool authed,
    required bool shiftOpen,
    String? branchId,
  }) {
    if (_disposed) return;
    final active = online && authed && shiftOpen && branchId != null;

    if (branchId != _branchId) {
      _teardown();
      _resetDedup();
      _branchId = branchId;
    }

    if (!active) {
      _teardown();
      // Session ended → clear the queue + dedup. A pure offline blip (shift
      // still open) keeps the painted list so it's there when we reconnect.
      if (!shiftOpen || !authed) {
        _resetDedup();
        _ref.read(deliveryOrdersProvider.notifier).clear();
      }
      return;
    }

    if (!_connected && !_connecting) _connect();
  }

  /// Re-derive the gate from live provider state (used on app resume).
  void reevaluate() {
    final auth = _ref.read(authProvider);
    apply(
      online: ConnectivityService.instance.isOnline,
      authed: auth.user != null && !auth.isOfflineSession,
      shiftOpen: _ref.read(shiftProvider).shift != null,
      branchId: auth.user?.branchId ?? auth.branch?.id,
    );
  }

  /// App backgrounded — drop the socket; [reevaluate] re-connects on resume.
  void pause() => _teardown();

  bool _gateActive() {
    final auth = _ref.read(authProvider);
    return ConnectivityService.instance.isOnline &&
        auth.user != null &&
        !auth.isOfflineSession &&
        _ref.read(shiftProvider).shift != null &&
        _branchId != null;
  }

  // ── Connect / stream ────────────────────────────────────────────────────────

  Future<void> _connect() async {
    final branchId = _branchId;
    if (branchId == null || _connecting || _connected) return;
    _connecting = true;
    _backoff?.cancel();
    _backoff = null;

    final repo = _ref.read(deliveryOrderRepositoryProvider);

    // The stream is updates-only: seed the list with a REST GET first, then mark
    // existing received orders as seen so they don't re-alert.
    try {
      await _ref
          .read(deliveryOrdersProvider.notifier)
          .loadForBranch(branchId, force: true);
    } catch (_) {/* the stream + poll will keep retrying */}
    if (_disposed || _branchId != branchId) {
      _connecting = false;
      return;
    }
    _reconcileFromList();

    final cancel = CancelToken();
    _cancel = cancel;
    try {
      final body = await repo.openStream(branchId: branchId, cancelToken: cancel);
      if (_disposed || _branchId != branchId) {
        cancel.cancel();
        _connecting = false;
        return;
      }
      _connected = true;
      _connecting = false;
      _attempt = 0;
      _stopPoll(); // SSE is primary; the poll is only a fallback

      final parser = SseFrameParser();
      _sub = body.stream
          .cast<List<int>>()
          .transform(utf8.decoder)
          .transform(const LineSplitter())
          .listen(
        (line) {
          final frame = parser.addLine(line);
          if (frame != null) _dispatch(frame.event, frame.data);
        },
        onError: (_) => _onClosed(branchId),
        onDone: () => _onClosed(branchId),
        cancelOnError: true,
      );
    } catch (e) {
      _cancel = null;
      _connected = false;
      _connecting = false;
      final code = e is DioException ? e.response?.statusCode : null;
      // 401 → the DioClient interceptor already routes to logout.
      // 403/404 → deterministic refusal (perm revoked / branch gone): retrying
      // won't help, so stop rather than hammer the server. The gate changing
      // (re-auth / branch switch) will trigger a fresh connect.
      if (code == 401 || code == 403 || code == 404) {
        if (kDebugMode) {
          debugPrint('delivery stream refused ($code) — not retrying');
        }
        _teardown();
        return;
      }
      _scheduleReconnect(branchId); // network / 5xx / transient
    }
  }

  void _onClosed(String branchId) {
    if (_branchId != branchId) return; // stale callback after a branch change
    _connected = false;
    _sub?.cancel();
    _sub = null;
    _cancel = null;
    _scheduleReconnect(branchId);
  }

  void _scheduleReconnect(String branchId) {
    if (_disposed || _branchId != branchId) return;
    _startPoll(); // fallback covers the gap until SSE is back
    _backoff?.cancel();
    final base = (1 << _attempt).clamp(1, 30);
    // Full jitter (0..base seconds) so many devices don't reconnect in lockstep
    // after a backend restart.
    final delayMs = (base * 1000 * _rng.nextDouble()).round() + 250;
    _attempt = (_attempt + 1).clamp(0, 5);
    _backoff = Timer(Duration(milliseconds: delayMs), () {
      if (_disposed || _branchId != branchId) return;
      if (_gateActive()) _connect();
    });
  }

  // ── Event handling + new-order detection ────────────────────────────────────

  void _dispatch(String? type, String data) {
    try {
      final json = jsonDecode(data);
      if (json is! Map<String, dynamic>) return;
      _onEvent(type ?? 'updated', DeliveryOrder.fromJson(json));
    } catch (e) {
      // One malformed frame must never kill the stream loop.
      if (kDebugMode) debugPrint('delivery SSE parse error: $e');
    }
  }

  void _onEvent(String type, DeliveryOrder order) {
    if (order.branchId != _branchId) return; // safety: ignore stray branches
    _ref.read(deliveryOrdersProvider.notifier).applyServerOrder(order);
    if (_detector.isNewFromEvent(order)) _fireNewOrderAlert(order);
  }

  /// Reconcile against the freshly-loaded list (the GET/poll path). The first
  /// reconcile seeds silently; later ones alert on any newly-seen received order.
  void _reconcileFromList() {
    final wasSeed = !_detector.seeded;
    final fresh =
        _detector.reconcile(_ref.read(deliveryOrdersProvider).orders);
    if (wasSeed) {
      // First authenticated load → contextual moment to ask for notif perms.
      NotificationService.instance.requestPermissions();
    }
    for (final o in fresh) {
      _fireNewOrderAlert(o);
    }
  }

  /// THE single place all four new-order effects fire, so SSE + poll share it.
  void _fireNewOrderAlert(DeliveryOrder order) {
    NotificationService.instance.showNewOrder(order);
    _ref.read(newOrderBannerProvider.notifier).show(order);
    Sounds.newOrder();
    Haptics.success();
  }

  // ── Poll fallback (only while SSE is disconnected) ──────────────────────────

  void _startPoll() {
    _poll ??= Timer.periodic(_pollInterval, (_) => _pollOnce());
  }

  void _stopPoll() {
    _poll?.cancel();
    _poll = null;
  }

  Future<void> _pollOnce() async {
    if (_connected) return; // SSE healthy → no poll
    final branchId = _branchId;
    if (branchId == null || !_gateActive()) return;
    try {
      await _ref
          .read(deliveryOrdersProvider.notifier)
          .loadForBranch(branchId, force: true);
      _reconcileFromList();
    } catch (_) {/* the next tick retries */}
  }

  // ── Teardown ────────────────────────────────────────────────────────────────

  void _teardown() {
    _backoff?.cancel();
    _backoff = null;
    _sub?.cancel();
    _sub = null;
    _cancel?.cancel();
    _cancel = null;
    _stopPoll();
    _connected = false;
    _connecting = false;
    _attempt = 0;
  }

  void _resetDedup() {
    _detector.reset();
    _ref.read(newOrderBannerProvider.notifier).dismiss();
  }

  void dispose() {
    _disposed = true;
    _teardown();
  }
}

/// App-wide (kept-alive) realtime service. Survives navigation between screens
/// so alerts fire even when the teller is on the order screen, not the queue.
final deliveryRealtimeProvider = Provider<DeliveryRealtimeService>((ref) {
  final svc = DeliveryRealtimeService(ref);
  ref.onDispose(svc.dispose);
  return svc;
});

/// Stateful Server-Sent Events frame parser. Feed it text lines (already split
/// on `\n`); it returns a completed `(event, data)` frame on the blank line that
/// terminates an event, or null otherwise. Handles `:`-comment keep-alives and
/// multi-line `data:` fields. Pure + dependency-free so it's unit-testable.
class SseFrameParser {
  String? _event;
  final StringBuffer _data = StringBuffer();

  ({String event, String data})? addLine(String line) {
    if (line.isEmpty) {
      if (_data.isEmpty) {
        _event = null;
        return null;
      }
      final frame = (event: _event ?? 'message', data: _data.toString());
      _event = null;
      _data.clear();
      return frame;
    }
    if (line.startsWith(':')) return null; // comment / keep-alive
    if (line.startsWith('event:')) {
      _event = line.substring(6).trim();
    } else if (line.startsWith('data:')) {
      final chunk = line.substring(5);
      _data.write(chunk.startsWith(' ') ? chunk.substring(1) : chunk);
    }
    return null;
  }
}
