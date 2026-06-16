//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'org.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Org {
  /// Returns a new [Org] instance.
  Org({

    required  this.currencyCode,

    required  this.id,

    required  this.isActive,

     this.logoUrl,

    required  this.name,

     this.receiptFooter,

    required  this.slug,

    required  this.taxRate,

    required  this.timezone,
  });

  @JsonKey(
    
    name: r'currency_code',
    required: true,
    includeIfNull: false,
  )


  final String currencyCode;



  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'is_active',
    required: true,
    includeIfNull: false,
  )


  final bool isActive;



  @JsonKey(
    
    name: r'logo_url',
    required: false,
    includeIfNull: false,
  )


  final String? logoUrl;



  @JsonKey(
    
    name: r'name',
    required: true,
    includeIfNull: false,
  )


  final String name;



  @JsonKey(
    
    name: r'receipt_footer',
    required: false,
    includeIfNull: false,
  )


  final String? receiptFooter;



  @JsonKey(
    
    name: r'slug',
    required: true,
    includeIfNull: false,
  )


  final String slug;



      /// Tax rate as a decimal (e.g. `0.14` for 14% VAT). Stored as `BigDecimal` internally; transmitted as a JSON number.
  @JsonKey(
    
    name: r'tax_rate',
    required: true,
    includeIfNull: false,
  )


  final double taxRate;



      /// IANA timezone name. The org-level default that branches inherit when their own timezone is unset. Defaults to `Africa/Cairo`.
  @JsonKey(
    
    name: r'timezone',
    required: true,
    includeIfNull: false,
  )


  final String timezone;





    @override
    bool operator ==(Object other) => identical(this, other) || other is Org &&
      other.currencyCode == currencyCode &&
      other.id == id &&
      other.isActive == isActive &&
      other.logoUrl == logoUrl &&
      other.name == name &&
      other.receiptFooter == receiptFooter &&
      other.slug == slug &&
      other.taxRate == taxRate &&
      other.timezone == timezone;

    @override
    int get hashCode =>
        currencyCode.hashCode +
        id.hashCode +
        isActive.hashCode +
        (logoUrl == null ? 0 : logoUrl.hashCode) +
        name.hashCode +
        (receiptFooter == null ? 0 : receiptFooter.hashCode) +
        slug.hashCode +
        taxRate.hashCode +
        timezone.hashCode;

  factory Org.fromJson(Map<String, dynamic> json) => _$OrgFromJson(json);

  Map<String, dynamic> toJson() => _$OrgToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

