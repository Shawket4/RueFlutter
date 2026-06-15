//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'status_input.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class StatusInput {
  /// Returns a new [StatusInput] instance.
  StatusInput({

    required  this.status,
  });

      /// \"confirmed\" | \"preparing\" | \"ready\" | \"out_for_delivery\"
  @JsonKey(
    
    name: r'status',
    required: true,
    includeIfNull: false,
  )


  final String status;





    @override
    bool operator ==(Object other) => identical(this, other) || other is StatusInput &&
      other.status == status;

    @override
    int get hashCode =>
        status.hashCode;

  factory StatusInput.fromJson(Map<String, dynamic> json) => _$StatusInputFromJson(json);

  Map<String, dynamic> toJson() => _$StatusInputToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

