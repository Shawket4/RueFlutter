//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/item_count_input.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'upsert_items_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpsertItemsRequest {
  /// Returns a new [UpsertItemsRequest] instance.
  UpsertItemsRequest({

    required  this.items,
  });

  @JsonKey(
    
    name: r'items',
    required: true,
    includeIfNull: false,
  )


  final List<ItemCountInput> items;





    @override
    bool operator ==(Object other) => identical(this, other) || other is UpsertItemsRequest &&
      other.items == items;

    @override
    int get hashCode =>
        items.hashCode;

  factory UpsertItemsRequest.fromJson(Map<String, dynamic> json) => _$UpsertItemsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpsertItemsRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

