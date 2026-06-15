//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/addon_item.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'paginated_addon_items.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PaginatedAddonItems {
  /// Returns a new [PaginatedAddonItems] instance.
  PaginatedAddonItems({

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


  final List<AddonItem> data;



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
    bool operator ==(Object other) => identical(this, other) || other is PaginatedAddonItems &&
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

  factory PaginatedAddonItems.fromJson(Map<String, dynamic> json) => _$PaginatedAddonItemsFromJson(json);

  Map<String, dynamic> toJson() => _$PaginatedAddonItemsToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

