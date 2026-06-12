//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/bundle_with_components.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'paginated_bundles.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PaginatedBundles {
  /// Returns a new [PaginatedBundles] instance.
  PaginatedBundles({

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


  final List<BundleWithComponents> data;



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
    bool operator ==(Object other) => identical(this, other) || other is PaginatedBundles &&
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

  factory PaginatedBundles.fromJson(Map<String, dynamic> json) => _$PaginatedBundlesFromJson(json);

  Map<String, dynamic> toJson() => _$PaginatedBundlesToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

