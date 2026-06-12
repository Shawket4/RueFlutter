// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'export_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ExportResponseCWProxy {
  ExportResponse data(List<OrderExport> data);

  ExportResponse generatedAt(DateTime generatedAt);

  ExportResponse ingredientCosts(Map<String, int> ingredientCosts);

  ExportResponse summary(OrderSummary summary);

  ExportResponse total(int total);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExportResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExportResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  ExportResponse call({
    List<OrderExport> data,
    DateTime generatedAt,
    Map<String, int> ingredientCosts,
    OrderSummary summary,
    int total,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfExportResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfExportResponse.copyWith.fieldName(...)`
class _$ExportResponseCWProxyImpl implements _$ExportResponseCWProxy {
  const _$ExportResponseCWProxyImpl(this._value);

  final ExportResponse _value;

  @override
  ExportResponse data(List<OrderExport> data) => this(data: data);

  @override
  ExportResponse generatedAt(DateTime generatedAt) =>
      this(generatedAt: generatedAt);

  @override
  ExportResponse ingredientCosts(Map<String, int> ingredientCosts) =>
      this(ingredientCosts: ingredientCosts);

  @override
  ExportResponse summary(OrderSummary summary) => this(summary: summary);

  @override
  ExportResponse total(int total) => this(total: total);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExportResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExportResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  ExportResponse call({
    Object? data = const $CopyWithPlaceholder(),
    Object? generatedAt = const $CopyWithPlaceholder(),
    Object? ingredientCosts = const $CopyWithPlaceholder(),
    Object? summary = const $CopyWithPlaceholder(),
    Object? total = const $CopyWithPlaceholder(),
  }) {
    return ExportResponse(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<OrderExport>,
      generatedAt: generatedAt == const $CopyWithPlaceholder()
          ? _value.generatedAt
          // ignore: cast_nullable_to_non_nullable
          : generatedAt as DateTime,
      ingredientCosts: ingredientCosts == const $CopyWithPlaceholder()
          ? _value.ingredientCosts
          // ignore: cast_nullable_to_non_nullable
          : ingredientCosts as Map<String, int>,
      summary: summary == const $CopyWithPlaceholder()
          ? _value.summary
          // ignore: cast_nullable_to_non_nullable
          : summary as OrderSummary,
      total: total == const $CopyWithPlaceholder()
          ? _value.total
          // ignore: cast_nullable_to_non_nullable
          : total as int,
    );
  }
}

extension $ExportResponseCopyWith on ExportResponse {
  /// Returns a callable class that can be used as follows: `instanceOfExportResponse.copyWith(...)` or like so:`instanceOfExportResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ExportResponseCWProxy get copyWith => _$ExportResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExportResponse _$ExportResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ExportResponse',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const [
            'data',
            'generated_at',
            'ingredient_costs',
            'summary',
            'total',
          ],
        );
        final val = ExportResponse(
          data: $checkedConvert(
            'data',
            (v) => (v as List<dynamic>)
                .map((e) => OrderExport.fromJson(e as Map<String, dynamic>))
                .toList(),
          ),
          generatedAt: $checkedConvert(
            'generated_at',
            (v) => DateTime.parse(v as String),
          ),
          ingredientCosts: $checkedConvert(
            'ingredient_costs',
            (v) => Map<String, int>.from(v as Map),
          ),
          summary: $checkedConvert(
            'summary',
            (v) => OrderSummary.fromJson(v as Map<String, dynamic>),
          ),
          total: $checkedConvert('total', (v) => (v as num).toInt()),
        );
        return val;
      },
      fieldKeyMap: const {
        'generatedAt': 'generated_at',
        'ingredientCosts': 'ingredient_costs',
      },
    );

Map<String, dynamic> _$ExportResponseToJson(ExportResponse instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'generated_at': instance.generatedAt.toIso8601String(),
      'ingredient_costs': instance.ingredientCosts,
      'summary': instance.summary.toJson(),
      'total': instance.total,
    };
