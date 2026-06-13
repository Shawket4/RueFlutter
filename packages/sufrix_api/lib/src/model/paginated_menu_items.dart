//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/menu_item_with_costs.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'paginated_menu_items.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PaginatedMenuItems {
  /// Returns a new [PaginatedMenuItems] instance.
  PaginatedMenuItems({

    required  this.data,

    required  this.page,

    required  this.perPage,

    required  this.total,

    required  this.totalPages,
  });

  @JsonKey(
    
    name: r'data',
    required: true,
    includeIfNull: false,
  )


  final List<MenuItemWithCosts> data;



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
    bool operator ==(Object other) => identical(this, other) || other is PaginatedMenuItems &&
      other.data == data &&
      other.page == page &&
      other.perPage == perPage &&
      other.total == total &&
      other.totalPages == totalPages;

    @override
    int get hashCode =>
        data.hashCode +
        page.hashCode +
        perPage.hashCode +
        total.hashCode +
        totalPages.hashCode;

  factory PaginatedMenuItems.fromJson(Map<String, dynamic> json) => _$PaginatedMenuItemsFromJson(json);

  Map<String, dynamic> toJson() => _$PaginatedMenuItemsToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

