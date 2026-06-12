//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/order_export.dart';
import 'package:sufrix_api/src/model/order_summary.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'export_response.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ExportResponse {
  /// Returns a new [ExportResponse] instance.
  ExportResponse({

    required  this.data,

    required  this.generatedAt,

    required  this.ingredientCosts,

    required  this.summary,

    required  this.total,
  });

  @JsonKey(
    
    name: r'data',
    required: true,
    includeIfNull: false,
  )


  final List<OrderExport> data;



  @JsonKey(
    
    name: r'generated_at',
    required: true,
    includeIfNull: false,
  )


  final DateTime generatedAt;



  @JsonKey(
    
    name: r'ingredient_costs',
    required: true,
    includeIfNull: false,
  )


  final Map<String, int> ingredientCosts;



  @JsonKey(
    
    name: r'summary',
    required: true,
    includeIfNull: false,
  )


  final OrderSummary summary;



  @JsonKey(
    
    name: r'total',
    required: true,
    includeIfNull: false,
  )


  final int total;





    @override
    bool operator ==(Object other) => identical(this, other) || other is ExportResponse &&
      other.data == data &&
      other.generatedAt == generatedAt &&
      other.ingredientCosts == ingredientCosts &&
      other.summary == summary &&
      other.total == total;

    @override
    int get hashCode =>
        data.hashCode +
        generatedAt.hashCode +
        ingredientCosts.hashCode +
        summary.hashCode +
        total.hashCode;

  factory ExportResponse.fromJson(Map<String, dynamic> json) => _$ExportResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ExportResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

