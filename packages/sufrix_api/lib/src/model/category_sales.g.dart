// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_sales.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CategorySalesCWProxy {
  CategorySales categoryId(String? categoryId);

  CategorySales categoryName(String? categoryName);

  CategorySales categoryNameTranslations(Object categoryNameTranslations);

  CategorySales itemCount(int itemCount);

  CategorySales items(List<ItemSales> items);

  CategorySales quantitySold(int quantitySold);

  CategorySales revenue(int revenue);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CategorySales(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CategorySales(...).copyWith(id: 12, name: "My name")
  /// ````
  CategorySales call({
    String? categoryId,
    String? categoryName,
    Object categoryNameTranslations,
    int itemCount,
    List<ItemSales> items,
    int quantitySold,
    int revenue,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCategorySales.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCategorySales.copyWith.fieldName(...)`
class _$CategorySalesCWProxyImpl implements _$CategorySalesCWProxy {
  const _$CategorySalesCWProxyImpl(this._value);

  final CategorySales _value;

  @override
  CategorySales categoryId(String? categoryId) => this(categoryId: categoryId);

  @override
  CategorySales categoryName(String? categoryName) =>
      this(categoryName: categoryName);

  @override
  CategorySales categoryNameTranslations(Object categoryNameTranslations) =>
      this(categoryNameTranslations: categoryNameTranslations);

  @override
  CategorySales itemCount(int itemCount) => this(itemCount: itemCount);

  @override
  CategorySales items(List<ItemSales> items) => this(items: items);

  @override
  CategorySales quantitySold(int quantitySold) =>
      this(quantitySold: quantitySold);

  @override
  CategorySales revenue(int revenue) => this(revenue: revenue);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CategorySales(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CategorySales(...).copyWith(id: 12, name: "My name")
  /// ````
  CategorySales call({
    Object? categoryId = const $CopyWithPlaceholder(),
    Object? categoryName = const $CopyWithPlaceholder(),
    Object? categoryNameTranslations = const $CopyWithPlaceholder(),
    Object? itemCount = const $CopyWithPlaceholder(),
    Object? items = const $CopyWithPlaceholder(),
    Object? quantitySold = const $CopyWithPlaceholder(),
    Object? revenue = const $CopyWithPlaceholder(),
  }) {
    return CategorySales(
      categoryId: categoryId == const $CopyWithPlaceholder()
          ? _value.categoryId
          // ignore: cast_nullable_to_non_nullable
          : categoryId as String?,
      categoryName: categoryName == const $CopyWithPlaceholder()
          ? _value.categoryName
          // ignore: cast_nullable_to_non_nullable
          : categoryName as String?,
      categoryNameTranslations:
          categoryNameTranslations == const $CopyWithPlaceholder()
          ? _value.categoryNameTranslations
          // ignore: cast_nullable_to_non_nullable
          : categoryNameTranslations as Object,
      itemCount: itemCount == const $CopyWithPlaceholder()
          ? _value.itemCount
          // ignore: cast_nullable_to_non_nullable
          : itemCount as int,
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<ItemSales>,
      quantitySold: quantitySold == const $CopyWithPlaceholder()
          ? _value.quantitySold
          // ignore: cast_nullable_to_non_nullable
          : quantitySold as int,
      revenue: revenue == const $CopyWithPlaceholder()
          ? _value.revenue
          // ignore: cast_nullable_to_non_nullable
          : revenue as int,
    );
  }
}

extension $CategorySalesCopyWith on CategorySales {
  /// Returns a callable class that can be used as follows: `instanceOfCategorySales.copyWith(...)` or like so:`instanceOfCategorySales.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CategorySalesCWProxy get copyWith => _$CategorySalesCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategorySales _$CategorySalesFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CategorySales',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const [
            'category_name_translations',
            'item_count',
            'items',
            'quantity_sold',
            'revenue',
          ],
        );
        final val = CategorySales(
          categoryId: $checkedConvert('category_id', (v) => v as String?),
          categoryName: $checkedConvert('category_name', (v) => v as String?),
          categoryNameTranslations: $checkedConvert(
            'category_name_translations',
            (v) => v as Object,
          ),
          itemCount: $checkedConvert('item_count', (v) => (v as num).toInt()),
          items: $checkedConvert(
            'items',
            (v) => (v as List<dynamic>)
                .map((e) => ItemSales.fromJson(e as Map<String, dynamic>))
                .toList(),
          ),
          quantitySold: $checkedConvert(
            'quantity_sold',
            (v) => (v as num).toInt(),
          ),
          revenue: $checkedConvert('revenue', (v) => (v as num).toInt()),
        );
        return val;
      },
      fieldKeyMap: const {
        'categoryId': 'category_id',
        'categoryName': 'category_name',
        'categoryNameTranslations': 'category_name_translations',
        'itemCount': 'item_count',
        'quantitySold': 'quantity_sold',
      },
    );

Map<String, dynamic> _$CategorySalesToJson(CategorySales instance) =>
    <String, dynamic>{
      'category_id': ?instance.categoryId,
      'category_name': ?instance.categoryName,
      'category_name_translations': instance.categoryNameTranslations,
      'item_count': instance.itemCount,
      'items': instance.items.map((e) => e.toJson()).toList(),
      'quantity_sold': instance.quantitySold,
      'revenue': instance.revenue,
    };
