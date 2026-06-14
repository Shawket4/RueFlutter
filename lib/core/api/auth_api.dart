import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import 'client.dart';

class AuthApi {
  final DioClient _c;
  AuthApi(this._c);

  Future<Map<String, dynamic>> loginWithPin(
      {required String name,
      required String pin,
      required String branchId}) async {
    final res = await _c.dio.post('/auth/login', data: {
      'name': name,
      'pin': pin,
      'branch_id': branchId,
    });
    return res.data as Map<String, dynamic>;
  }

  /// Manager email/password login — used only by the one-time device setup
  /// flow to fetch the branch list; the token is discarded afterwards.
  Future<Map<String, dynamic>> loginWithEmailPassword(
      {required String email, required String password}) async {
    final res = await _c.dio.post('/auth/login', data: {
      'email': email,
      'password': password,
    });
    return res.data as Map<String, dynamic>;
  }

  /// GET /auth/me — returns the caller plus the org tax rate so the cart can
  /// compute a tax-inclusive total. `tax_rate` is absent on older servers, so
  /// it defaults to 0.0 (tax-free) rather than crashing.
  Future<({User user, double taxRate})> me() async {
    final res = await _c.dio.get('/auth/me');
    final user = User.fromJson(res.data['user'] as Map<String, dynamic>);
    final taxRate = (res.data['tax_rate'] as num?)?.toDouble() ?? 0.0;
    return (user: user, taxRate: taxRate);
  }
}

final authApiProvider = Provider<AuthApi>(
    (ref) => AuthApi(ref.watch(dioClientProvider)));
