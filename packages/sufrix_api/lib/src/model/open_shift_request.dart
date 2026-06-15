//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'open_shift_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OpenShiftRequest {
  /// Returns a new [OpenShiftRequest] instance.
  OpenShiftRequest({

     this.editReason,

     this.id,

     this.openedAt,

    required  this.openingCash,

     this.openingCashEdited,
  });

  @JsonKey(
    
    name: r'edit_reason',
    required: false,
    includeIfNull: false,
  )


  final String? editReason;



  @JsonKey(
    
    name: r'id',
    required: false,
    includeIfNull: false,
  )


  final String? id;



  @JsonKey(
    
    name: r'opened_at',
    required: false,
    includeIfNull: false,
  )


  final DateTime? openedAt;



  @JsonKey(
    
    name: r'opening_cash',
    required: true,
    includeIfNull: false,
  )


  final int openingCash;



      /// Ignored by the server — the carryover edit is DERIVED from the previous shift's declared closing. Kept only for API/back-compat with clients.
  @JsonKey(
    
    name: r'opening_cash_edited',
    required: false,
    includeIfNull: false,
  )


  final bool? openingCashEdited;





    @override
    bool operator ==(Object other) => identical(this, other) || other is OpenShiftRequest &&
      other.editReason == editReason &&
      other.id == id &&
      other.openedAt == openedAt &&
      other.openingCash == openingCash &&
      other.openingCashEdited == openingCashEdited;

    @override
    int get hashCode =>
        (editReason == null ? 0 : editReason.hashCode) +
        (id == null ? 0 : id.hashCode) +
        (openedAt == null ? 0 : openedAt.hashCode) +
        openingCash.hashCode +
        (openingCashEdited == null ? 0 : openingCashEdited.hashCode);

  factory OpenShiftRequest.fromJson(Map<String, dynamic> json) => _$OpenShiftRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OpenShiftRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

