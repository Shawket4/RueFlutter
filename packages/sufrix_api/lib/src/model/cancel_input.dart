//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cancel_input.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CancelInput {
  /// Returns a new [CancelInput] instance.
  CancelInput({

     this.reason,

     this.restoreInventory,
  });

  @JsonKey(
    
    name: r'reason',
    required: false,
    includeIfNull: false,
  )


  final String? reason;



      /// true (default): ingredients stay available. false: the food was made and is wasted — the frozen plan is deducted from stock and logged as `waste`.
  @JsonKey(
    
    name: r'restore_inventory',
    required: false,
    includeIfNull: false,
  )


  final bool? restoreInventory;





    @override
    bool operator ==(Object other) => identical(this, other) || other is CancelInput &&
      other.reason == reason &&
      other.restoreInventory == restoreInventory;

    @override
    int get hashCode =>
        (reason == null ? 0 : reason.hashCode) +
        restoreInventory.hashCode;

  factory CancelInput.fromJson(Map<String, dynamic> json) => _$CancelInputFromJson(json);

  Map<String, dynamic> toJson() => _$CancelInputToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

