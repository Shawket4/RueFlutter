import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/branch.dart';
import 'client.dart';

class BranchApi {
  final DioClient _c;
  BranchApi(this._c);

  Future<Branch> get(String branchId) async {
    final res = await _c.dio.get('/branches/$branchId');
    return Branch.fromJson(res.data as Map<String, dynamic>);
  }

  /// Active branches of [orgId] visible to the current token (manager during
  /// device setup). The backend requires org_id as a query parameter; auth
  /// comes from the Dio interceptor's bearer token.
  Future<List<Branch>> list({required String orgId}) async {
    final res =
        await _c.dio.get('/branches', queryParameters: {'org_id': orgId});
    return (res.data as List<dynamic>)
        .map((j) => Branch.fromJson(j as Map<String, dynamic>))
        .where((b) => b.isActive)
        .toList();
  }
}

final branchApiProvider = Provider<BranchApi>(
    (ref) => BranchApi(ref.watch(dioClientProvider)));
