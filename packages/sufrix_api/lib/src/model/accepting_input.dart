//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'accepting_input.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AcceptingInput {
  /// Returns a new [AcceptingInput] instance.
  AcceptingInput({

    required  this.branchId,

    required  this.channel,

    required  this.mode,
  });

  @JsonKey(
    
    name: r'branch_id',
    required: true,
    includeIfNull: false,
  )


  final String branchId;



      /// \"in_mall\" | \"outside\"
  @JsonKey(
    
    name: r'channel',
    required: true,
    includeIfNull: false,
  )


  final String channel;



      /// \"auto\" | \"open\" | \"closed\". Named `mode` (not `override`) because a bare `override` field is a reserved word in Dart and breaks the POS client code generator.
  @JsonKey(
    
    name: r'mode',
    required: true,
    includeIfNull: false,
  )


  final String mode;





    @override
    bool operator ==(Object other) => identical(this, other) || other is AcceptingInput &&
      other.branchId == branchId &&
      other.channel == channel &&
      other.mode == mode;

    @override
    int get hashCode =>
        branchId.hashCode +
        channel.hashCode +
        mode.hashCode;

  factory AcceptingInput.fromJson(Map<String, dynamic> json) => _$AcceptingInputFromJson(json);

  Map<String, dynamic> toJson() => _$AcceptingInputToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

