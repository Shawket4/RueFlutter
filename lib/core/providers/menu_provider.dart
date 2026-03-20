import 'dart:convert';
import 'package:flutter/foundation.dart' hide Category;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/menu.dart';
import '../api/menu_api.dart';

class MenuProvider extends ChangeNotifier {
  List<Category>  _cats        = [];
  List<MenuItem>  _items       = [];
  String?         _selId;
  bool            _loading     = false;
  String?         _error;
  String?         _loadedOrgId;
  bool            _fromCache   = false;

  List<Category>  get categories => _cats;
  List<MenuItem>  get allItems   => _items;
  String?         get selectedId => _selId;
  bool            get loading    => _loading;
  String?         get error      => _error;
  bool            get fromCache  => _fromCache;

  List<MenuItem> get filtered => _selId == null
      ? _items
      : _items.where((i) => i.categoryId == _selId).toList();

  Future<void> load(String orgId) async {
    if (_loadedOrgId == orgId && _items.isNotEmpty && !_fromCache) return;
    _loading   = true;
    _fromCache = false;
    notifyListeners();
    try {
      final cats  = await menuApi.categories(orgId);
      final items = await menuApi.items(orgId);
      _cats        = cats;
      _items       = items;
      _selId       = _cats.isNotEmpty ? _cats.first.id : null;
      _error       = null;
      _loadedOrgId = orgId;
      _fromCache   = false;
      await _saveCache(orgId);
    } catch (e) {
      final ok = await _loadCache(orgId);
      if (ok) {
        _fromCache   = true;
        _error       = null;
        _loadedOrgId = orgId;
      } else {
        _error = 'No connection and no cached menu available';
      }
    }
    _loading = false;
    notifyListeners();
  }

  void refresh(String orgId) { _loadedOrgId = null; load(orgId); }

  void select(String id) { _selId = id; notifyListeners(); }

  Future<void> _saveCache(String orgId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('menu_cache_v2_$orgId', jsonEncode({
        'categories': _cats.map((c)  => c.toJson()).toList(),
        'items':      _items.map((i) => i.toJson()).toList(),
      }));
    } catch (_) {}
  }

  Future<bool> _loadCache(String orgId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw   = prefs.getString('menu_cache_v2_$orgId');
      if (raw == null) return false;
      final data  = jsonDecode(raw) as Map<String, dynamic>;
      _cats  = (data['categories'] as List)
          .map((c) => Category.fromJson(c as Map<String, dynamic>)).toList();
      _items = (data['items'] as List)
          .map((i) => MenuItem.fromJson(i as Map<String, dynamic>)).toList();
      _selId = _cats.isNotEmpty ? _cats.first.id : null;
      return true;
    } catch (_) { return false; }
  }
}

