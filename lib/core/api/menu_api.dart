import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/bundle.dart';
import '../models/menu.dart';
import 'client.dart';

class MenuApi {
  final DioClient _c;
  MenuApi(this._c);

  Future<List<Category>> categories(String orgId) async {
    final res = await _c.dio.get('/categories', queryParameters: {'org_id': orgId});
    return (res.data as List).map((c) => Category.fromJson(c)).toList();
  }

  Future<List<MenuItem>> items(String orgId) async {
    final res = await _c.dio.get('/menu-items', queryParameters: {
      'org_id': orgId,
      'full': 'true',
    });
    return (res.data as List)
        .map((m) => MenuItem.fromJson(m as Map<String, dynamic>))
        .toList();
  }

  Future<MenuItem> item(String id) async {
    final res = await _c.dio.get('/menu-items/$id');
    return MenuItem.fromJson(res.data as Map<String, dynamic>);
  }

  Future<List<AddonItem>> addonItems(String orgId) async {
    final res = await _c.dio.get('/addon-items', queryParameters: {'org_id': orgId});
    return (res.data as List)
        .map((a) => AddonItem.fromJson(a as Map<String, dynamic>))
        .toList();
  }

  Future<List<Bundle>> bundles(String orgId, {DateTime? updatedSince}) async {
    final params = <String, dynamic>{'org_id': orgId};
    if (updatedSince != null) {
      params['updated_since'] = updatedSince.toUtc().toIso8601String();
    }
    final res = await _c.dio.get('/bundles', queryParameters: params);
    final data = res.data;
    final List<dynamic> list;
    if (data is List) {
      list = data;
    } else if (data is Map && data['data'] is List) {
      list = data['data'] as List;
    } else {
      return [];
    }
    return list
        .map((b) => Bundle.fromJson(b as Map<String, dynamic>))
        .where((b) => b.status == BundleStatus.active)
        .toList();
  }
}

final menuApiProvider =
    Provider<MenuApi>((ref) => MenuApi(ref.watch(dioClientProvider)));
