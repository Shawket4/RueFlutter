//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/order_summary.dart';
import 'package:sufrix_api/src/model/order_full.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'paginated_orders_full.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PaginatedOrdersFull {
  /// Returns a new [PaginatedOrdersFull] instance.
  PaginatedOrdersFull({

    required  this.data,

    required  this.page,

    required  this.perPage,

    required  this.summary,

    required  this.total,

    required  this.totalPages,
  });

  @JsonKey(
    
    name: r'data',
    required: true,
    includeIfNull: false,
  )


  final List<OrderFull> data;



  @JsonKey(
    
    name: r'page',
    required: true,
    includeIfNull: false,
  )


  final int page;



  @JsonKey(
    
    name: r'per_page',
    required: true,
    includeIfNull: false,
  )


  final int perPage;



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



  @JsonKey(
    
    name: r'total_pages',
    required: true,
    includeIfNull: false,
  )


  final int totalPages;





    @override
    bool operator ==(Object other) => identical(this, other) || other is PaginatedOrdersFull &&
      other.data == data &&
      other.page == page &&
      other.perPage == perPage &&
      other.summary == summary &&
      other.total == total &&
      other.totalPages == totalPages;

    @override
    int get hashCode =>
        data.hashCode +
        page.hashCode +
        perPage.hashCode +
        summary.hashCode +
        total.hashCode +
        totalPages.hashCode;

  factory PaginatedOrdersFull.fromJson(Map<String, dynamic> json) => _$PaginatedOrdersFullFromJson(json);

  Map<String, dynamic> toJson() => _$PaginatedOrdersFullToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

