// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calibration_point.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CalibrationPointCWProxy {
  CalibrationPoint classificationMode(String classificationMode);

  CalibrationPoint decidedAt(DateTime decidedAt);

  CalibrationPoint itemName(String itemName);

  CalibrationPoint menuItemId(String menuItemId);

  CalibrationPoint predictedDeltaPct(double predictedDeltaPct);

  CalibrationPoint previousPrice(int previousPrice);

  CalibrationPoint realizedAt(DateTime realizedAt);

  CalibrationPoint realizedDeltaPct(double realizedDeltaPct);

  CalibrationPoint realizedPrice(int realizedPrice);

  CalibrationPoint sizeLabel(String sizeLabel);

  CalibrationPoint suggestedPrice(int suggestedPrice);

  CalibrationPoint suggestionId(String suggestionId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CalibrationPoint(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CalibrationPoint(...).copyWith(id: 12, name: "My name")
  /// ````
  CalibrationPoint call({
    String classificationMode,
    DateTime decidedAt,
    String itemName,
    String menuItemId,
    double predictedDeltaPct,
    int previousPrice,
    DateTime realizedAt,
    double realizedDeltaPct,
    int realizedPrice,
    String sizeLabel,
    int suggestedPrice,
    String suggestionId,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCalibrationPoint.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCalibrationPoint.copyWith.fieldName(...)`
class _$CalibrationPointCWProxyImpl implements _$CalibrationPointCWProxy {
  const _$CalibrationPointCWProxyImpl(this._value);

  final CalibrationPoint _value;

  @override
  CalibrationPoint classificationMode(String classificationMode) =>
      this(classificationMode: classificationMode);

  @override
  CalibrationPoint decidedAt(DateTime decidedAt) => this(decidedAt: decidedAt);

  @override
  CalibrationPoint itemName(String itemName) => this(itemName: itemName);

  @override
  CalibrationPoint menuItemId(String menuItemId) =>
      this(menuItemId: menuItemId);

  @override
  CalibrationPoint predictedDeltaPct(double predictedDeltaPct) =>
      this(predictedDeltaPct: predictedDeltaPct);

  @override
  CalibrationPoint previousPrice(int previousPrice) =>
      this(previousPrice: previousPrice);

  @override
  CalibrationPoint realizedAt(DateTime realizedAt) =>
      this(realizedAt: realizedAt);

  @override
  CalibrationPoint realizedDeltaPct(double realizedDeltaPct) =>
      this(realizedDeltaPct: realizedDeltaPct);

  @override
  CalibrationPoint realizedPrice(int realizedPrice) =>
      this(realizedPrice: realizedPrice);

  @override
  CalibrationPoint sizeLabel(String sizeLabel) => this(sizeLabel: sizeLabel);

  @override
  CalibrationPoint suggestedPrice(int suggestedPrice) =>
      this(suggestedPrice: suggestedPrice);

  @override
  CalibrationPoint suggestionId(String suggestionId) =>
      this(suggestionId: suggestionId);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CalibrationPoint(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CalibrationPoint(...).copyWith(id: 12, name: "My name")
  /// ````
  CalibrationPoint call({
    Object? classificationMode = const $CopyWithPlaceholder(),
    Object? decidedAt = const $CopyWithPlaceholder(),
    Object? itemName = const $CopyWithPlaceholder(),
    Object? menuItemId = const $CopyWithPlaceholder(),
    Object? predictedDeltaPct = const $CopyWithPlaceholder(),
    Object? previousPrice = const $CopyWithPlaceholder(),
    Object? realizedAt = const $CopyWithPlaceholder(),
    Object? realizedDeltaPct = const $CopyWithPlaceholder(),
    Object? realizedPrice = const $CopyWithPlaceholder(),
    Object? sizeLabel = const $CopyWithPlaceholder(),
    Object? suggestedPrice = const $CopyWithPlaceholder(),
    Object? suggestionId = const $CopyWithPlaceholder(),
  }) {
    return CalibrationPoint(
      classificationMode: classificationMode == const $CopyWithPlaceholder()
          ? _value.classificationMode
          // ignore: cast_nullable_to_non_nullable
          : classificationMode as String,
      decidedAt: decidedAt == const $CopyWithPlaceholder()
          ? _value.decidedAt
          // ignore: cast_nullable_to_non_nullable
          : decidedAt as DateTime,
      itemName: itemName == const $CopyWithPlaceholder()
          ? _value.itemName
          // ignore: cast_nullable_to_non_nullable
          : itemName as String,
      menuItemId: menuItemId == const $CopyWithPlaceholder()
          ? _value.menuItemId
          // ignore: cast_nullable_to_non_nullable
          : menuItemId as String,
      predictedDeltaPct: predictedDeltaPct == const $CopyWithPlaceholder()
          ? _value.predictedDeltaPct
          // ignore: cast_nullable_to_non_nullable
          : predictedDeltaPct as double,
      previousPrice: previousPrice == const $CopyWithPlaceholder()
          ? _value.previousPrice
          // ignore: cast_nullable_to_non_nullable
          : previousPrice as int,
      realizedAt: realizedAt == const $CopyWithPlaceholder()
          ? _value.realizedAt
          // ignore: cast_nullable_to_non_nullable
          : realizedAt as DateTime,
      realizedDeltaPct: realizedDeltaPct == const $CopyWithPlaceholder()
          ? _value.realizedDeltaPct
          // ignore: cast_nullable_to_non_nullable
          : realizedDeltaPct as double,
      realizedPrice: realizedPrice == const $CopyWithPlaceholder()
          ? _value.realizedPrice
          // ignore: cast_nullable_to_non_nullable
          : realizedPrice as int,
      sizeLabel: sizeLabel == const $CopyWithPlaceholder()
          ? _value.sizeLabel
          // ignore: cast_nullable_to_non_nullable
          : sizeLabel as String,
      suggestedPrice: suggestedPrice == const $CopyWithPlaceholder()
          ? _value.suggestedPrice
          // ignore: cast_nullable_to_non_nullable
          : suggestedPrice as int,
      suggestionId: suggestionId == const $CopyWithPlaceholder()
          ? _value.suggestionId
          // ignore: cast_nullable_to_non_nullable
          : suggestionId as String,
    );
  }
}

extension $CalibrationPointCopyWith on CalibrationPoint {
  /// Returns a callable class that can be used as follows: `instanceOfCalibrationPoint.copyWith(...)` or like so:`instanceOfCalibrationPoint.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CalibrationPointCWProxy get copyWith => _$CalibrationPointCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalibrationPoint _$CalibrationPointFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CalibrationPoint',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const [
            'classification_mode',
            'decided_at',
            'item_name',
            'menu_item_id',
            'predicted_delta_pct',
            'previous_price',
            'realized_at',
            'realized_delta_pct',
            'realized_price',
            'size_label',
            'suggested_price',
            'suggestion_id',
          ],
        );
        final val = CalibrationPoint(
          classificationMode: $checkedConvert(
            'classification_mode',
            (v) => v as String,
          ),
          decidedAt: $checkedConvert(
            'decided_at',
            (v) => DateTime.parse(v as String),
          ),
          itemName: $checkedConvert('item_name', (v) => v as String),
          menuItemId: $checkedConvert('menu_item_id', (v) => v as String),
          predictedDeltaPct: $checkedConvert(
            'predicted_delta_pct',
            (v) => (v is String ? double.parse(v) : (v as num).toDouble()),
          ),
          previousPrice: $checkedConvert(
            'previous_price',
            (v) => (v as num).toInt(),
          ),
          realizedAt: $checkedConvert(
            'realized_at',
            (v) => DateTime.parse(v as String),
          ),
          realizedDeltaPct: $checkedConvert(
            'realized_delta_pct',
            (v) => (v is String ? double.parse(v) : (v as num).toDouble()),
          ),
          realizedPrice: $checkedConvert(
            'realized_price',
            (v) => (v as num).toInt(),
          ),
          sizeLabel: $checkedConvert('size_label', (v) => v as String),
          suggestedPrice: $checkedConvert(
            'suggested_price',
            (v) => (v as num).toInt(),
          ),
          suggestionId: $checkedConvert('suggestion_id', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'classificationMode': 'classification_mode',
        'decidedAt': 'decided_at',
        'itemName': 'item_name',
        'menuItemId': 'menu_item_id',
        'predictedDeltaPct': 'predicted_delta_pct',
        'previousPrice': 'previous_price',
        'realizedAt': 'realized_at',
        'realizedDeltaPct': 'realized_delta_pct',
        'realizedPrice': 'realized_price',
        'sizeLabel': 'size_label',
        'suggestedPrice': 'suggested_price',
        'suggestionId': 'suggestion_id',
      },
    );

Map<String, dynamic> _$CalibrationPointToJson(CalibrationPoint instance) =>
    <String, dynamic>{
      'classification_mode': instance.classificationMode,
      'decided_at': instance.decidedAt.toIso8601String(),
      'item_name': instance.itemName,
      'menu_item_id': instance.menuItemId,
      'predicted_delta_pct': instance.predictedDeltaPct,
      'previous_price': instance.previousPrice,
      'realized_at': instance.realizedAt.toIso8601String(),
      'realized_delta_pct': instance.realizedDeltaPct,
      'realized_price': instance.realizedPrice,
      'size_label': instance.sizeLabel,
      'suggested_price': instance.suggestedPrice,
      'suggestion_id': instance.suggestionId,
    };
