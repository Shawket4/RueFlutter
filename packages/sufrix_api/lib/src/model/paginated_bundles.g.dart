// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_bundles.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PaginatedBundlesCWProxy {
  PaginatedBundles data(List<BundleWithComponents> data);

  PaginatedBundles page(int page);

  PaginatedBundles perPage(int perPage);

  PaginatedBundles total(int total);

  PaginatedBundles totalPages(int totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PaginatedBundles(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PaginatedBundles(...).copyWith(id: 12, name: "My name")
  /// ````
  PaginatedBundles call({
    List<BundleWithComponents> data,
    int page,
    int perPage,
    int total,
    int totalPages,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPaginatedBundles.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPaginatedBundles.copyWith.fieldName(...)`
class _$PaginatedBundlesCWProxyImpl implements _$PaginatedBundlesCWProxy {
  const _$PaginatedBundlesCWProxyImpl(this._value);

  final PaginatedBundles _value;

  @override
  PaginatedBundles data(List<BundleWithComponents> data) => this(data: data);

  @override
  PaginatedBundles page(int page) => this(page: page);

  @override
  PaginatedBundles perPage(int perPage) => this(perPage: perPage);

  @override
  PaginatedBundles total(int total) => this(total: total);

  @override
  PaginatedBundles totalPages(int totalPages) => this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PaginatedBundles(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PaginatedBundles(...).copyWith(id: 12, name: "My name")
  /// ````
  PaginatedBundles call({
    Object? data = const $CopyWithPlaceholder(),
    Object? page = const $CopyWithPlaceholder(),
    Object? perPage = const $CopyWithPlaceholder(),
    Object? total = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return PaginatedBundles(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<BundleWithComponents>,
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

extension $PaginatedBundlesCopyWith on PaginatedBundles {
  /// Returns a callable class that can be used as follows: `instanceOfPaginatedBundles.copyWith(...)` or like so:`instanceOfPaginatedBundles.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PaginatedBundlesCWProxy get copyWith => _$PaginatedBundlesCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedBundles _$PaginatedBundlesFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'PaginatedBundles',
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
        final val = PaginatedBundles(
          data: $checkedConvert(
            'data',
            (v) => (v as List<dynamic>)
                .map(
                  (e) =>
                      BundleWithComponents.fromJson(e as Map<String, dynamic>),
                )
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

Map<String, dynamic> _$PaginatedBundlesToJson(PaginatedBundles instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'page': instance.page,
      'per_page': instance.perPage,
      'total': instance.total,
      'total_pages': instance.totalPages,
    };
