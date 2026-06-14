//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/user_public.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'me_response.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MeResponse {
  /// Returns a new [MeResponse] instance.
  MeResponse({

    required  this.currencyCode,

    required  this.taxRate,

    required  this.user,
  });

      /// Org currency code (e.g. \"EGP\").
  @JsonKey(
    
    name: r'currency_code',
    required: true,
    includeIfNull: false,
  )


  final String currencyCode;



      /// Org tax rate as a decimal (e.g. 0.14 = 14% VAT); 0.0 when the user has no org. Exposed so the POS can compute a tax-inclusive cart total client-side.
  @JsonKey(
    
    name: r'tax_rate',
    required: true,
    includeIfNull: false,
  )


  final double taxRate;



  @JsonKey(
    
    name: r'user',
    required: true,
    includeIfNull: false,
  )


  final UserPublic user;





    @override
    bool operator ==(Object other) => identical(this, other) || other is MeResponse &&
      other.currencyCode == currencyCode &&
      other.taxRate == taxRate &&
      other.user == user;

    @override
    int get hashCode =>
        currencyCode.hashCode +
        taxRate.hashCode +
        user.hashCode;

  factory MeResponse.fromJson(Map<String, dynamic> json) => _$MeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MeResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

