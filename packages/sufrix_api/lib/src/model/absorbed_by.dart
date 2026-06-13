//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/item_key.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'absorbed_by.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AbsorbedBy {
  /// Returns a new [AbsorbedBy] instance.
  AbsorbedBy({

    required  this.absorbedCm,

    required  this.absorbedUnits,

    required  this.key,
  });

  @JsonKey(
    
    name: r'absorbed_cm',
    required: true,
    includeIfNull: false,
  )


  final double absorbedCm;



  @JsonKey(
    
    name: r'absorbed_units',
    required: true,
    includeIfNull: false,
  )


  final double absorbedUnits;



  @JsonKey(
    
    name: r'key',
    required: true,
    includeIfNull: false,
  )


  final ItemKey key;





    @override
    bool operator ==(Object other) => identical(this, other) || other is AbsorbedBy &&
      other.absorbedCm == absorbedCm &&
      other.absorbedUnits == absorbedUnits &&
      other.key == key;

    @override
    int get hashCode =>
        absorbedCm.hashCode +
        absorbedUnits.hashCode +
        key.hashCode;

  factory AbsorbedBy.fromJson(Map<String, dynamic> json) => _$AbsorbedByFromJson(json);

  Map<String, dynamic> toJson() => _$AbsorbedByToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

