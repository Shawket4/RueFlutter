// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_orders_full.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PaginatedOrdersFullCWProxy {
  PaginatedOrdersFull data(List<OrderFull> data);

  PaginatedOrdersFull page(int page);

  PaginatedOrdersFull perPage(int perPage);

  PaginatedOrdersFull summary(OrderSummary summary);

  PaginatedOrdersFull total(int total);

  PaginatedOrdersFull totalPages(int totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PaginatedOrdersFull(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PaginatedOrdersFull(...).copyWith(id: 12, name: "My name")
  /// ````
  PaginatedOrdersFull call({
    List<OrderFull> data,
    int page,
    int perPage,
    OrderSummary summary,
    int total,
    int totalPages,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPaginatedOrdersFull.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPaginatedOrdersFull.copyWith.fieldName(...)`
class _$PaginatedOrdersFullCWProxyImpl implements _$PaginatedOrdersFullCWProxy {
  const _$PaginatedOrdersFullCWProxyImpl(this._value);

  final PaginatedOrdersFull _value;

  @override
  PaginatedOrdersFull data(List<OrderFull> data) => this(data: data);

  @override
  PaginatedOrdersFull page(int page) => this(page: page);

  @override
  PaginatedOrdersFull perPage(int perPage) => this(perPage: perPage);

  @override
  PaginatedOrdersFull summary(OrderSummary summary) => this(summary: summary);

  @override
  PaginatedOrdersFull total(int total) => this(total: total);

  @override
  PaginatedOrdersFull totalPages(int totalPages) =>
      this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PaginatedOrdersFull(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PaginatedOrdersFull(...).copyWith(id: 12, name: "My name")
  /// ````
  PaginatedOrdersFull call({
    Object? data = const $CopyWithPlaceholder(),
    Object? page = const $CopyWithPlaceholder(),
    Object? perPage = const $CopyWithPlaceholder(),
    Object? summary = const $CopyWithPlaceholder(),
    Object? total = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return PaginatedOrdersFull(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<OrderFull>,
      page: page == const $CopyWithPlaceholder()
          ? _value.page
          // ignore: cast_nullable_to_non_nullable
          : page as int,
      perPage: perPage == const $CopyWithPlaceholder()
          ? _value.perPage
          // ignore: cast_nullable_to_non_nullable
          : perPage as int,
      summary: summary == const $CopyWithPlaceholder()
          ? _value.summary
          // ignore: cast_nullable_to_non_nullable
          : summary as OrderSummary,
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

extension $PaginatedOrdersFullCopyWith on PaginatedOrdersFull {
  /// Returns a callable class that can be used as follows: `instanceOfPaginatedOrdersFull.copyWith(...)` or like so:`instanceOfPaginatedOrdersFull.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PaginatedOrdersFullCWProxy get copyWith =>
      _$PaginatedOrdersFullCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedOrdersFull _$PaginatedOrdersFullFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'PaginatedOrdersFull',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const [
            'data',
            'page',
            'per_page',
            'summary',
            'total',
            'total_pages',
          ],
        );
        final val = PaginatedOrdersFull(
          data: $checkedConvert(
            'data',
            (v) => (v as List<dynamic>)
                .map((e) => OrderFull.fromJson(e as Map<String, dynamic>))
                .toList(),
          ),
          page: $checkedConvert('page', (v) => (v as num).toInt()),
          perPage: $checkedConvert('per_page', (v) => (v as num).toInt()),
          summary: $checkedConvert(
            'summary',
            (v) => OrderSummary.fromJson(v as Map<String, dynamic>),
          ),
          total: $checkedConvert('total', (v) => (v as num).toInt()),
          totalPages: $checkedConvert('total_pages', (v) => (v as num).toInt()),
        );
        return val;
      },
      fieldKeyMap: const {'perPage': 'per_page', 'totalPages': 'total_pages'},
    );

Map<String, dynamic> _$PaginatedOrdersFullToJson(
  PaginatedOrdersFull instance,
) => <String, dynamic>{
  'data': instance.data.map((e) => e.toJson()).toList(),
  'page': instance.page,
  'per_page': instance.perPage,
  'summary': instance.summary.toJson(),
  'total': instance.total,
  'total_pages': instance.totalPages,
};
