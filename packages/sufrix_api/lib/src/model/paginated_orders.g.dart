// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_orders.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PaginatedOrdersCWProxy {
  PaginatedOrders data(List<Order> data);

  PaginatedOrders page(int page);

  PaginatedOrders perPage(int perPage);

  PaginatedOrders summary(OrderSummary summary);

  PaginatedOrders total(int total);

  PaginatedOrders totalPages(int totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PaginatedOrders(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PaginatedOrders(...).copyWith(id: 12, name: "My name")
  /// ````
  PaginatedOrders call({
    List<Order> data,
    int page,
    int perPage,
    OrderSummary summary,
    int total,
    int totalPages,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPaginatedOrders.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPaginatedOrders.copyWith.fieldName(...)`
class _$PaginatedOrdersCWProxyImpl implements _$PaginatedOrdersCWProxy {
  const _$PaginatedOrdersCWProxyImpl(this._value);

  final PaginatedOrders _value;

  @override
  PaginatedOrders data(List<Order> data) => this(data: data);

  @override
  PaginatedOrders page(int page) => this(page: page);

  @override
  PaginatedOrders perPage(int perPage) => this(perPage: perPage);

  @override
  PaginatedOrders summary(OrderSummary summary) => this(summary: summary);

  @override
  PaginatedOrders total(int total) => this(total: total);

  @override
  PaginatedOrders totalPages(int totalPages) => this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PaginatedOrders(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PaginatedOrders(...).copyWith(id: 12, name: "My name")
  /// ````
  PaginatedOrders call({
    Object? data = const $CopyWithPlaceholder(),
    Object? page = const $CopyWithPlaceholder(),
    Object? perPage = const $CopyWithPlaceholder(),
    Object? summary = const $CopyWithPlaceholder(),
    Object? total = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return PaginatedOrders(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<Order>,
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

extension $PaginatedOrdersCopyWith on PaginatedOrders {
  /// Returns a callable class that can be used as follows: `instanceOfPaginatedOrders.copyWith(...)` or like so:`instanceOfPaginatedOrders.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PaginatedOrdersCWProxy get copyWith => _$PaginatedOrdersCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedOrders _$PaginatedOrdersFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'PaginatedOrders',
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
        final val = PaginatedOrders(
          data: $checkedConvert(
            'data',
            (v) => (v as List<dynamic>)
                .map((e) => Order.fromJson(e as Map<String, dynamic>))
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

Map<String, dynamic> _$PaginatedOrdersToJson(PaginatedOrders instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'page': instance.page,
      'per_page': instance.perPage,
      'summary': instance.summary.toJson(),
      'total': instance.total,
      'total_pages': instance.totalPages,
    };
