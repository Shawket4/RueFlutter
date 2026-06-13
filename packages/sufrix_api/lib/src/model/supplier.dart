//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'supplier.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Supplier {
  /// Returns a new [Supplier] instance.
  Supplier({

     this.contactName,

    required  this.createdAt,

     this.email,

    required  this.id,

    required  this.isActive,

    required  this.name,

    required  this.orgId,

     this.phone,

    required  this.updatedAt,
  });

  @JsonKey(
    
    name: r'contact_name',
    required: false,
    includeIfNull: false,
  )


  final String? contactName;



  @JsonKey(
    
    name: r'created_at',
    required: true,
    includeIfNull: false,
  )


  final DateTime createdAt;



  @JsonKey(
    
    name: r'email',
    required: false,
    includeIfNull: false,
  )


  final String? email;



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
    
    name: r'name',
    required: true,
    includeIfNull: false,
  )


  final String name;



  @JsonKey(
    
    name: r'org_id',
    required: true,
    includeIfNull: false,
  )


  final String orgId;



  @JsonKey(
    
    name: r'phone',
    required: false,
    includeIfNull: false,
  )


  final String? phone;



  @JsonKey(
    
    name: r'updated_at',
    required: true,
    includeIfNull: false,
  )


  final DateTime updatedAt;





    @override
    bool operator ==(Object other) => identical(this, other) || other is Supplier &&
      other.contactName == contactName &&
      other.createdAt == createdAt &&
      other.email == email &&
      other.id == id &&
      other.isActive == isActive &&
      other.name == name &&
      other.orgId == orgId &&
      other.phone == phone &&
      other.updatedAt == updatedAt;

    @override
    int get hashCode =>
        (contactName == null ? 0 : contactName.hashCode) +
        createdAt.hashCode +
        (email == null ? 0 : email.hashCode) +
        id.hashCode +
        isActive.hashCode +
        name.hashCode +
        orgId.hashCode +
        (phone == null ? 0 : phone.hashCode) +
        updatedAt.hashCode;

  factory Supplier.fromJson(Map<String, dynamic> json) => _$SupplierFromJson(json);

  Map<String, dynamic> toJson() => _$SupplierToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

