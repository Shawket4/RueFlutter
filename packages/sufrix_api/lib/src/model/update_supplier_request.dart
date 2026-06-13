//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_supplier_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdateSupplierRequest {
  /// Returns a new [UpdateSupplierRequest] instance.
  UpdateSupplierRequest({

     this.contactName,

     this.email,

     this.isActive,

     this.name,

     this.phone,
  });

  @JsonKey(
    
    name: r'contact_name',
    required: false,
    includeIfNull: false,
  )


  final String? contactName;



  @JsonKey(
    
    name: r'email',
    required: false,
    includeIfNull: false,
  )


  final String? email;



  @JsonKey(
    
    name: r'is_active',
    required: false,
    includeIfNull: false,
  )


  final bool? isActive;



  @JsonKey(
    
    name: r'name',
    required: false,
    includeIfNull: false,
  )


  final String? name;



  @JsonKey(
    
    name: r'phone',
    required: false,
    includeIfNull: false,
  )


  final String? phone;





    @override
    bool operator ==(Object other) => identical(this, other) || other is UpdateSupplierRequest &&
      other.contactName == contactName &&
      other.email == email &&
      other.isActive == isActive &&
      other.name == name &&
      other.phone == phone;

    @override
    int get hashCode =>
        (contactName == null ? 0 : contactName.hashCode) +
        (email == null ? 0 : email.hashCode) +
        (isActive == null ? 0 : isActive.hashCode) +
        (name == null ? 0 : name.hashCode) +
        (phone == null ? 0 : phone.hashCode);

  factory UpdateSupplierRequest.fromJson(Map<String, dynamic> json) => _$UpdateSupplierRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateSupplierRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

