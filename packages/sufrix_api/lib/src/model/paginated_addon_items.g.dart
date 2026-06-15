// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_addon_items.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PaginatedAddonItemsCWProxy {
  PaginatedAddonItems data(List<AddonItem> data);

  PaginatedAddonItems page(int page);

  PaginatedAddonItems perPage(int perPage);

  PaginatedAddonItems total(int total);

  PaginatedAddonItems totalPages(int totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PaginatedAddonItems(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PaginatedAddonItems(...).copyWith(id: 12, name: "My name")
  /// ````
  PaginatedAddonItems call({
    List<AddonItem> data,
    int page,
    int perPage,
    int total,
    int totalPages,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPaginatedAddonItems.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPaginatedAddonItems.copyWith.fieldName(...)`
class _$PaginatedAddonItemsCWProxyImpl implements _$PaginatedAddonItemsCWProxy {
  const _$PaginatedAddonItemsCWProxyImpl(this._value);

  final PaginatedAddonItems _value;

  @override
  PaginatedAddonItems data(List<AddonItem> data) => this(data: data);

  @override
  PaginatedAddonItems page(int page) => this(page: page);

  @override
  PaginatedAddonItems perPage(int perPage) => this(perPage: perPage);

  @override
  PaginatedAddonItems total(int total) => this(total: total);

  @override
  PaginatedAddonItems totalPages(int totalPages) =>
      this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PaginatedAddonItems(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PaginatedAddonItems(...).copyWith(id: 12, name: "My name")
  /// ````
  PaginatedAddonItems call({
    Object? data = const $CopyWithPlaceholder(),
    Object? page = const $CopyWithPlaceholder(),
    Object? perPage = const $CopyWithPlaceholder(),
    Object? total = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return PaginatedAddonItems(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<AddonItem>,
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

extension $PaginatedAddonItemsCopyWith on PaginatedAddonItems {
  /// Returns a callable class that can be used as follows: `instanceOfPaginatedAddonItems.copyWith(...)` or like so:`instanceOfPaginatedAddonItems.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PaginatedAddonItemsCWProxy get copyWith =>
      _$PaginatedAddonItemsCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedAddonItems _$PaginatedAddonItemsFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'PaginatedAddonItems',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const [
            'data',
            'page',
            'per_page',
            'total',
            'total_pages',
          ],
        );
        final val = PaginatedAddonItems(
          data: $checkedConvert(
            'data',
            (v) => (v as List<dynamic>)
                .map((e) => AddonItem.fromJson(e as Map<String, dynamic>))
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

Map<String, dynamic> _$PaginatedAddonItemsToJson(
  PaginatedAddonItems instance,
) => <String, dynamic>{
  'data': instance.data.map((e) => e.toJson()).toList(),
  'page': instance.page,
  'per_page': instance.perPage,
  'total': instance.total,
  'total_pages': instance.totalPages,
};
