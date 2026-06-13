// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'removal_scenario.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RemovalScenarioCWProxy {
  RemovalScenario absorbedBy(List<AbsorbedBy> absorbedBy);

  RemovalScenario baselineCm(double baselineCm);

  RemovalScenario complementaryLosses(
    List<ComplementaryLoss> complementaryLosses,
  );

  RemovalScenario explanation(String explanation);

  RemovalScenario itemName(String itemName);

  RemovalScenario key(ItemKey key);

  RemovalScenario netCmChange(double netCmChange);

  RemovalScenario netCmChangeHi(double netCmChangeHi);

  RemovalScenario netCmChangeLo(double netCmChangeLo);

  RemovalScenario recommendation(RemovalRecommendation recommendation);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RemovalScenario(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RemovalScenario(...).copyWith(id: 12, name: "My name")
  /// ````
  RemovalScenario call({
    List<AbsorbedBy> absorbedBy,
    double baselineCm,
    List<ComplementaryLoss> complementaryLosses,
    String explanation,
    String itemName,
    ItemKey key,
    double netCmChange,
    double netCmChangeHi,
    double netCmChangeLo,
    RemovalRecommendation recommendation,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRemovalScenario.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRemovalScenario.copyWith.fieldName(...)`
class _$RemovalScenarioCWProxyImpl implements _$RemovalScenarioCWProxy {
  const _$RemovalScenarioCWProxyImpl(this._value);

  final RemovalScenario _value;

  @override
  RemovalScenario absorbedBy(List<AbsorbedBy> absorbedBy) =>
      this(absorbedBy: absorbedBy);

  @override
  RemovalScenario baselineCm(double baselineCm) => this(baselineCm: baselineCm);

  @override
  RemovalScenario complementaryLosses(
    List<ComplementaryLoss> complementaryLosses,
  ) => this(complementaryLosses: complementaryLosses);

  @override
  RemovalScenario explanation(String explanation) =>
      this(explanation: explanation);

  @override
  RemovalScenario itemName(String itemName) => this(itemName: itemName);

  @override
  RemovalScenario key(ItemKey key) => this(key: key);

  @override
  RemovalScenario netCmChange(double netCmChange) =>
      this(netCmChange: netCmChange);

  @override
  RemovalScenario netCmChangeHi(double netCmChangeHi) =>
      this(netCmChangeHi: netCmChangeHi);

  @override
  RemovalScenario netCmChangeLo(double netCmChangeLo) =>
      this(netCmChangeLo: netCmChangeLo);

  @override
  RemovalScenario recommendation(RemovalRecommendation recommendation) =>
      this(recommendation: recommendation);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RemovalScenario(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RemovalScenario(...).copyWith(id: 12, name: "My name")
  /// ````
  RemovalScenario call({
    Object? absorbedBy = const $CopyWithPlaceholder(),
    Object? baselineCm = const $CopyWithPlaceholder(),
    Object? complementaryLosses = const $CopyWithPlaceholder(),
    Object? explanation = const $CopyWithPlaceholder(),
    Object? itemName = const $CopyWithPlaceholder(),
    Object? key = const $CopyWithPlaceholder(),
    Object? netCmChange = const $CopyWithPlaceholder(),
    Object? netCmChangeHi = const $CopyWithPlaceholder(),
    Object? netCmChangeLo = const $CopyWithPlaceholder(),
    Object? recommendation = const $CopyWithPlaceholder(),
  }) {
    return RemovalScenario(
      absorbedBy: absorbedBy == const $CopyWithPlaceholder()
          ? _value.absorbedBy
          // ignore: cast_nullable_to_non_nullable
          : absorbedBy as List<AbsorbedBy>,
      baselineCm: baselineCm == const $CopyWithPlaceholder()
          ? _value.baselineCm
          // ignore: cast_nullable_to_non_nullable
          : baselineCm as double,
      complementaryLosses: complementaryLosses == const $CopyWithPlaceholder()
          ? _value.complementaryLosses
          // ignore: cast_nullable_to_non_nullable
          : complementaryLosses as List<ComplementaryLoss>,
      explanation: explanation == const $CopyWithPlaceholder()
          ? _value.explanation
          // ignore: cast_nullable_to_non_nullable
          : explanation as String,
      itemName: itemName == const $CopyWithPlaceholder()
          ? _value.itemName
          // ignore: cast_nullable_to_non_nullable
          : itemName as String,
      key: key == const $CopyWithPlaceholder()
          ? _value.key
          // ignore: cast_nullable_to_non_nullable
          : key as ItemKey,
      netCmChange: netCmChange == const $CopyWithPlaceholder()
          ? _value.netCmChange
          // ignore: cast_nullable_to_non_nullable
          : netCmChange as double,
      netCmChangeHi: netCmChangeHi == const $CopyWithPlaceholder()
          ? _value.netCmChangeHi
          // ignore: cast_nullable_to_non_nullable
          : netCmChangeHi as double,
      netCmChangeLo: netCmChangeLo == const $CopyWithPlaceholder()
          ? _value.netCmChangeLo
          // ignore: cast_nullable_to_non_nullable
          : netCmChangeLo as double,
      recommendation: recommendation == const $CopyWithPlaceholder()
          ? _value.recommendation
          // ignore: cast_nullable_to_non_nullable
          : recommendation as RemovalRecommendation,
    );
  }
}

extension $RemovalScenarioCopyWith on RemovalScenario {
  /// Returns a callable class that can be used as follows: `instanceOfRemovalScenario.copyWith(...)` or like so:`instanceOfRemovalScenario.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RemovalScenarioCWProxy get copyWith => _$RemovalScenarioCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemovalScenario _$RemovalScenarioFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'RemovalScenario',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'absorbed_by',
        'baseline_cm',
        'complementary_losses',
        'explanation',
        'item_name',
        'key',
        'net_cm_change',
        'net_cm_change_hi',
        'net_cm_change_lo',
        'recommendation',
      ],
    );
    final val = RemovalScenario(
      absorbedBy: $checkedConvert(
        'absorbed_by',
        (v) => (v as List<dynamic>)
            .map((e) => AbsorbedBy.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      baselineCm: $checkedConvert('baseline_cm', (v) => (v is String ? double.parse(v) : (v as num).toDouble())),
      complementaryLosses: $checkedConvert(
        'complementary_losses',
        (v) => (v as List<dynamic>)
            .map((e) => ComplementaryLoss.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      explanation: $checkedConvert('explanation', (v) => v as String),
      itemName: $checkedConvert('item_name', (v) => v as String),
      key: $checkedConvert(
        'key',
        (v) => ItemKey.fromJson(v as Map<String, dynamic>),
      ),
      netCmChange: $checkedConvert(
        'net_cm_change',
        (v) => (v is String ? double.parse(v) : (v as num).toDouble()),
      ),
      netCmChangeHi: $checkedConvert(
        'net_cm_change_hi',
        (v) => (v is String ? double.parse(v) : (v as num).toDouble()),
      ),
      netCmChangeLo: $checkedConvert(
        'net_cm_change_lo',
        (v) => (v is String ? double.parse(v) : (v as num).toDouble()),
      ),
      recommendation: $checkedConvert(
        'recommendation',
        (v) => $enumDecode(
          _$RemovalRecommendationEnumMap,
          v,
          unknownValue: RemovalRecommendation.unknownDefaultOpenApi,
        ),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'absorbedBy': 'absorbed_by',
    'baselineCm': 'baseline_cm',
    'complementaryLosses': 'complementary_losses',
    'itemName': 'item_name',
    'netCmChange': 'net_cm_change',
    'netCmChangeHi': 'net_cm_change_hi',
    'netCmChangeLo': 'net_cm_change_lo',
  },
);

Map<String, dynamic> _$RemovalScenarioToJson(
  RemovalScenario instance,
) => <String, dynamic>{
  'absorbed_by': instance.absorbedBy.map((e) => e.toJson()).toList(),
  'baseline_cm': instance.baselineCm,
  'complementary_losses': instance.complementaryLosses
      .map((e) => e.toJson())
      .toList(),
  'explanation': instance.explanation,
  'item_name': instance.itemName,
  'key': instance.key.toJson(),
  'net_cm_change': instance.netCmChange,
  'net_cm_change_hi': instance.netCmChangeHi,
  'net_cm_change_lo': instance.netCmChangeLo,
  'recommendation': _$RemovalRecommendationEnumMap[instance.recommendation]!,
};

const _$RemovalRecommendationEnumMap = {
  RemovalRecommendation.remove: 'remove',
  RemovalRecommendation.keepAndBundle: 'keep_and_bundle',
  RemovalRecommendation.keepAndReformulate: 'keep_and_reformulate',
  RemovalRecommendation.noStrongSignal: 'no_strong_signal',
  RemovalRecommendation.unknownDefaultOpenApi: 'unknown_default_open_api',
};
