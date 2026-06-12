import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../db/kv_store.dart';
import '../utils/app_log.dart';

/// Holds the JWT in platform secure storage (Keychain / Keystore / DPAPI)
/// instead of the plaintext sqflite kv table.
///
/// Reads are synchronous via an in-memory mirror hydrated once in [init] so
/// the existing `StorageService.token` getter keeps its signature.
class SecureTokenStore {
  static const _key = 'auth_token';

  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  String? _cached;

  /// Call once from main() before runApp. [migrateFrom] performs a one-time
  /// move of any legacy plaintext token out of the kv table.
  Future<void> init({KvStore? migrateFrom}) async {
    try {
      _cached = await _storage.read(key: _key);
    } catch (e) {
      // Secure storage unavailable (e.g. locked keychain) — run tokenless;
      // the user will be asked to sign in.
      AppLog.warn('auth', 'Secure storage read failed: $e');
      _cached = null;
    }
    if (_cached == null && migrateFrom != null) {
      final legacy = migrateFrom.getString(_key);
      if (legacy != null) {
        await write(legacy);
        await migrateFrom.remove(_key);
      }
    }
  }

  String? get token => _cached;

  Future<void> write(String t) async {
    _cached = t;
    try {
      await _storage.write(key: _key, value: t);
    } catch (e) {
      AppLog.warn('auth', 'Secure storage write failed: $e');
    }
  }

  Future<void> clear() async {
    _cached = null;
    try {
      await _storage.delete(key: _key);
    } catch (e) {
      AppLog.warn('auth', 'Secure storage delete failed: $e');
    }
  }
}
