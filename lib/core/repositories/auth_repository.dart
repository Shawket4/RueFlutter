import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api/auth_api.dart';
import '../api/branch_api.dart';
import '../api/client.dart';
import '../models/branch.dart';
import '../models/user.dart';
import '../storage/storage_service.dart';

/// Setup-flow failure with a user-presentable message.
class DeviceSetupError implements Exception {
  final String message;
  const DeviceSetupError(this.message);
  @override
  String toString() => message;
}

class AuthRepository {
  final AuthApi        _api;
  final BranchApi      _branchApi;
  final StorageService _storage;
  AuthRepository(this._api, this._branchApi, this._storage);

  String? get storedToken => _storage.token;

  /// Restore session from disk. Returns null if invalid / no token.
  Future<({String token, User user})?> restoreSession() async {
    final token = _storage.token;
    if (token == null) return null;
    setAuthToken(token);
    try {
      final user = await _api.me();
      await _storage.saveUser(user.toJson());
      return (token: token, user: user);
    } catch (e) {
      if (isNetworkError(e)) {
        final cached = _storage.loadUser();
        if (cached != null) {
          return (token: token, user: User.fromJson(cached));
        }
      }
      // 401 or no cache → clear
      await _storage.clearAuth();
      setAuthToken(null);
      return null;
    }
  }

  /// Step 1 of device setup: manager logs in, fetches the branch list, then
  /// the manager token is discarded — the device only ever holds teller PIN
  /// sessions during normal operation.
  Future<List<Branch>> setupDevice({
    required String email,
    required String password,
  }) async {
    final data = await _api.loginWithEmailPassword(
        email: email, password: password);
    final token = data['token'] as String;
    // GET /branches requires the org as a query parameter — take it from the
    // manager's own user object in the login response.
    final user = User.fromJson(data['user'] as Map<String, dynamic>);
    final orgId = user.orgId;
    if (orgId == null) {
      throw const DeviceSetupError(
          'This account has no organization — sign in with an organization '
          'manager account.');
    }
    setAuthToken(token);
    try {
      return await _branchApi.list(orgId: orgId);
    } finally {
      // Always discard the manager token, success or failure. It was never
      // persisted, so clearing the in-memory Dio token is enough.
      setAuthToken(null);
    }
  }

  /// Step 2 of device setup: persist the chosen branch as device config.
  Future<void> confirmDeviceBranch(Branch branch) async {
    await _storage.saveDeviceConfig(
      orgId:      branch.orgId,
      branchId:   branch.id,
      branchName: branch.name,
    );
  }

  Future<({String token, User user})> login(
      {required String name, required String pin}) async {
    final branchId = _storage.deviceBranchId;
    if (branchId == null) {
      // The router gates on device config, so this is a should-never-happen
      // guard rather than a user-facing path.
      throw StateError('Device not configured — complete setup first');
    }
    final data =
        await _api.loginWithPin(name: name, pin: pin, branchId: branchId);
    final token = data['token'] as String;
    final user  = User.fromJson(data['user'] as Map<String, dynamic>);
    setAuthToken(token);
    await _storage.saveToken(token);
    await _storage.saveUser(user.toJson());

    // Remember enough to let this teller back in while offline: a salted
    // hash of the PIN (never the PIN) plus a user snapshot that survives
    // logout. The backend has no token-refresh endpoint, so this is the only
    // way an expired session can keep selling through an outage.
    await _storage.saveOfflineUnlock(name, _saltedHash(name, pin));
    await _storage.saveOfflineUser(name, user.toJson());
    return (token: token, user: user);
  }

  /// Validates [pin] against the locally stored salted hash and returns the
  /// stored user snapshot — WITHOUT a token. Returns null when this teller
  /// has never logged in on this device or the PIN is wrong.
  User? verifyOfflineUnlock({required String name, required String pin}) {
    final stored = _storage.offlineUnlockHash(name);
    if (stored == null) return null;
    final sep = stored.indexOf(':');
    if (sep <= 0) return null;
    final salt = stored.substring(0, sep);
    if (_hash(salt, name, pin) != stored.substring(sep + 1)) return null;
    final cached = _storage.loadOfflineUser(name);
    if (cached == null) return null;
    return User.fromJson(cached);
  }

  Future<void> logout() async {
    setAuthToken(null);
    await _storage.clearAuth();
  }

  // ── PIN hashing ────────────────────────────────────────────────────────────

  String _saltedHash(String name, String pin) {
    final rng = Random.secure();
    final salt =
        List.generate(16, (_) => rng.nextInt(256).toRadixString(16).padLeft(2, '0'))
            .join();
    return '$salt:${_hash(salt, name, pin)}';
  }

  String _hash(String salt, String name, String pin) =>
      sha256.convert(utf8.encode('$salt|${name.trim().toLowerCase()}|$pin')).toString();
}

final authRepositoryProvider = Provider<AuthRepository>((ref) => AuthRepository(
  ref.watch(authApiProvider),
  ref.watch(branchApiProvider),
  ref.watch(storageServiceProvider),
));
