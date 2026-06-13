// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_menu_items.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PaginatedMenuItemsCWProxy {
  PaginatedMenuItems data(List<MenuItemWithCosts> data);

  PaginatedMenuItems page(int page);

  PaginatedMenuItems perPage(int perPage);

  PaginatedMenuItems total(int total);

  PaginatedMenuItems totalPages(int totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PaginatedMenuItems(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PaginatedMenuItems(...).copyWith(id: 12, name: "My name")
  /// ````
  PaginatedMenuItems call({
    List<MenuItemWithCosts> data,
    int page,
    int perPage,
    int total,
    int totalPages,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPaginatedMenuItems.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPaginatedMenuItems.copyWith.fieldName(...)`
class _$PaginatedMenuItemsCWProxyImpl implements _$PaginatedMenuItemsCWProxy {
  const _$PaginatedMenuItemsCWProxyImpl(this._value);

  final PaginatedMenuItems _value;

  @override
  PaginatedMenuItems data(List<MenuItemWithCosts> data) => this(data: data);

  @override
  PaginatedMenuItems page(int page) => this(page: page);

  @override
  PaginatedMenuItems perPage(int perPage) => this(perPage: perPage);

  @override
  PaginatedMenuItems total(int total) => this(total: total);

  @override
  PaginatedMenuItems totalPages(int totalPages) => this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PaginatedMenuItems(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PaginatedMenuItems(...).copyWith(id: 12, name: "My name")
  /// ````
  PaginatedMenuItems call({
    Object? data = const $CopyWithPlaceholder(),
    Object? page = const $CopyWithPlaceholder(),
    Object? perPage = const $CopyWithPlaceholder(),
    Object? total = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return PaginatedMenuItems(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<MenuItemWithCosts>,
      page: page == const $CopyWithPlaceholder()
          ? _value.page
          // ignore: cast_nullable_to_non_nullable
          : page as int,
      perPage: perPage == const $CopyWithPlaceholder()
          ? _value.perPage
          // ignore: cast_nullable_to_non_nullable
          : perPage as int,
      total: total == const $CopyWithPlaceholder()
          ? _value.total
          // ignore: cast_nullable_to_non_nullable
          : total as int,
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as int,
    );
  }
}

extension $PaginatedMenuItemsCopyWith on PaginatedMenuItems {
  /// Returns a callable class that can be used as follows: `instanceOfPaginatedMenuItems.copyWith(...)` or like so:`instanceOfPaginatedMenuItems.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PaginatedMenuItemsCWProxy get copyWith =>
      _$PaginatedMenuItemsCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedMenuItems _$PaginatedMenuItemsFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'PaginatedMenuItems',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const ['data', 'page', 'per_page', 'total', 'total_pages'],
    );
    final val = PaginatedMenuItems(
      data: $checkedConvert(
        'data',
        (v) => (v as List<dynamic>)
            .map((e) => MenuItemWithCosts.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      page: $checkedConvert('page', (v) => (v as num).toInt()),
      perPage: $checkedConvert('per_page', (v) => (v as num).toInt()),
      total: $checkedConvert('total', (v) => (v as num).toInt()),
      totalPages: $checkedConvert('total_pages', (v) => (v as num).toInt()),
    );
    return val;
  },
  fieldKeyMap: const {'perPage': 'per_page', 'totalPages': 'total_pages'},
);

Map<String, dynamic> _$PaginatedMenuItemsToJson(PaginatedMenuItems instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'page': instance.page,
      'per_page': instance.perPage,
      'total': instance.total,
      'total_pages': instance.totalPages,
    };
