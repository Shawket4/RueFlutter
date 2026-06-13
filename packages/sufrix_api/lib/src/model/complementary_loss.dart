//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/item_key.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'complementary_loss.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ComplementaryLoss {
  /// Returns a new [ComplementaryLoss] instance.
  ComplementaryLoss({

    required  this.key,

    required  this.lostCm,

    required  this.lostUnits,
  });

  @JsonKey(
    
    name: r'key',
    required: true,
    includeIfNull: false,
  )


  final ItemKey key;



  @JsonKey(
    
    name: r'lost_cm',
    required: true,
    includeIfNull: false,
  )


  final double lostCm;



  @JsonKey(
    
    name: r'lost_units',
    required: true,
    includeIfNull: false,
  )


  final double lostUnits;





    @override
    bool operator ==(Object other) => identical(this, other) || other is ComplementaryLoss &&
      other.key == key &&
      other.lostCm == lostCm &&
      other.lostUnits == lostUnits;

    @override
    int get hashCode =>
        key.hashCode +
        lostCm.hashCode +
        lostUnits.hashCode;

  factory ComplementaryLoss.fromJson(Map<String, dynamic> json) => _$ComplementaryLossFromJson(json);

  Map<String, dynamic> toJson() => _$ComplementaryLossToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

