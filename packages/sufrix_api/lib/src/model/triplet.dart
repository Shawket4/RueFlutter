//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'triplet.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Triplet {
  /// Returns a new [Triplet] instance.
  Triplet({

    required  this.hi,

    required  this.lo,

    required  this.mid,
  });

  @JsonKey(
    
    name: r'hi',
    required: true,
    includeIfNull: false,
  )


  final double hi;



  @JsonKey(
    
    name: r'lo',
    required: true,
    includeIfNull: false,
  )


  final double lo;



  @JsonKey(
    
    name: r'mid',
    required: true,
    includeIfNull: false,
  )


  final double mid;





    @override
    bool operator ==(Object other) => identical(this, other) || other is Triplet &&
      other.hi == hi &&
      other.lo == lo &&
      other.mid == mid;

    @override
    int get hashCode =>
        hi.hashCode +
        lo.hashCode +
        mid.hashCode;

  factory Triplet.fromJson(Map<String, dynamic> json) => _$TripletFromJson(json);

  Map<String, dynamic> toJson() => _$TripletToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

