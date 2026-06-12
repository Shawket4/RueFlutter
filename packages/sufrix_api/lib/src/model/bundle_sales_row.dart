//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bundle_sales_row.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BundleSalesRow {
  /// Returns a new [BundleSalesRow] instance.
  BundleSalesRow({

     this.bundleId,

    required  this.bundleName,

    required  this.quantitySold,

    required  this.revenue,
  });

  @JsonKey(
    
    name: r'bundle_id',
    required: false,
    includeIfNull: false,
  )


  final String? bundleId;



  @JsonKey(
    
    name: r'bundle_name',
    required: true,
    includeIfNull: false,
  )


  final String bundleName;



  @JsonKey(
    
    name: r'quantity_sold',
    required: true,
    includeIfNull: false,
  )


  final int quantitySold;



  @JsonKey(
    
    name: r'revenue',
    required: true,
    includeIfNull: false,
  )


  final int revenue;





    @override
    bool operator ==(Object other) => identical(this, other) || other is BundleSalesRow &&
      other.bundleId == bundleId &&
      other.bundleName == bundleName &&
      other.quantitySold == quantitySold &&
      other.revenue == revenue;

    @override
    int get hashCode =>
        (bundleId == null ? 0 : bundleId.hashCode) +
        bundleName.hashCode +
        quantitySold.hashCode +
        revenue.hashCode;

  factory BundleSalesRow.fromJson(Map<String, dynamic> json) => _$BundleSalesRowFromJson(json);

  Map<String, dynamic> toJson() => _$BundleSalesRowToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

