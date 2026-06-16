//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_org_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdateOrgRequest {
  /// Returns a new [UpdateOrgRequest] instance.
  UpdateOrgRequest({

     this.currencyCode,

     this.isActive,

     this.logoUrl,

     this.name,

     this.receiptFooter,

     this.slug,

     this.taxRate,

     this.timezone,
  });

  @JsonKey(
    
    name: r'currency_code',
    required: false,
    includeIfNull: false,
  )


  final String? currencyCode;



  @JsonKey(
    
    name: r'is_active',
    required: false,
    includeIfNull: false,
  )


  final bool? isActive;



      /// `null` clears the logo; absent leaves it unchanged. To set a new logo, use `PUT /orgs/{id}/logo` (multipart) instead — JSON updates only accept the clear-to-null case here.
  @JsonKey(
    
    name: r'logo_url',
    required: false,
    includeIfNull: false,
  )


  final String? logoUrl;



  @JsonKey(
    
    name: r'name',
    required: false,
    includeIfNull: false,
  )


  final String? name;



  @JsonKey(
    
    name: r'receipt_footer',
    required: false,
    includeIfNull: false,
  )


  final String? receiptFooter;



  @JsonKey(
    
    name: r'slug',
    required: false,
    includeIfNull: false,
  )


  final String? slug;



  @JsonKey(
    
    name: r'tax_rate',
    required: false,
    includeIfNull: false,
  )


  final double? taxRate;



      /// IANA timezone name (e.g. `Africa/Cairo`). Validated against the PostgreSQL timezone database. Branches inherit this when their own timezone is unset.
  @JsonKey(
    
    name: r'timezone',
    required: false,
    includeIfNull: false,
  )


  final String? timezone;





    @override
    bool operator ==(Object other) => identical(this, other) || other is UpdateOrgRequest &&
      other.currencyCode == currencyCode &&
      other.isActive == isActive &&
      other.logoUrl == logoUrl &&
      other.name == name &&
      other.receiptFooter == receiptFooter &&
      other.slug == slug &&
      other.taxRate == taxRate &&
      other.timezone == timezone;

    @override
    int get hashCode =>
        (currencyCode == null ? 0 : currencyCode.hashCode) +
        (isActive == null ? 0 : isActive.hashCode) +
        (logoUrl == null ? 0 : logoUrl.hashCode) +
        (name == null ? 0 : name.hashCode) +
        (receiptFooter == null ? 0 : receiptFooter.hashCode) +
        (slug == null ? 0 : slug.hashCode) +
        (taxRate == null ? 0 : taxRate.hashCode) +
        (timezone == null ? 0 : timezone.hashCode);

  factory UpdateOrgRequest.fromJson(Map<String, dynamic> json) => _$UpdateOrgRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateOrgRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

