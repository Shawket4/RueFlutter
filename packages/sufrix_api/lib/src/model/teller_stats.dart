//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'teller_stats.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class TellerStats {
  /// Returns a new [TellerStats] instance.
  TellerStats({

    required  this.avgOrderValue,

    required  this.orders,

    required  this.revenue,

    required  this.shifts,

    required  this.tellerId,

    required  this.tellerName,

    required  this.voided,
  });

  @JsonKey(
    
    name: r'avg_order_value',
    required: true,
    includeIfNull: false,
  )


  final int avgOrderValue;



  @JsonKey(
    
    name: r'orders',
    required: true,
    includeIfNull: false,
  )


  final int orders;



  @JsonKey(
    
    name: r'revenue',
    required: true,
    includeIfNull: false,
  )


  final int revenue;



  @JsonKey(
    
    name: r'shifts',
    required: true,
    includeIfNull: false,
  )


  final int shifts;



  @JsonKey(
    
    name: r'teller_id',
    required: true,
    includeIfNull: false,
  )


  final String tellerId;



  @JsonKey(
    
    name: r'teller_name',
    required: true,
    includeIfNull: false,
  )


  final String tellerName;



  @JsonKey(
    
    name: r'voided',
    required: true,
    includeIfNull: false,
  )


  final int voided;





    @override
    bool operator ==(Object other) => identical(this, other) || other is TellerStats &&
      other.avgOrderValue == avgOrderValue &&
      other.orders == orders &&
      other.revenue == revenue &&
      other.shifts == shifts &&
      other.tellerId == tellerId &&
      other.tellerName == tellerName &&
      other.voided == voided;

    @override
    int get hashCode =>
        avgOrderValue.hashCode +
        orders.hashCode +
        revenue.hashCode +
        shifts.hashCode +
        tellerId.hashCode +
        tellerName.hashCode +
        voided.hashCode;

  factory TellerStats.fromJson(Map<String, dynamic> json) => _$TellerStatsFromJson(json);

  Map<String, dynamic> toJson() => _$TellerStatsToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

