//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_supplier_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CreateSupplierRequest {
  /// Returns a new [CreateSupplierRequest] instance.
  CreateSupplierRequest({

     this.contactName,

     this.email,

    required  this.name,

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
    
    name: r'name',
    required: true,
    includeIfNull: false,
  )


  final String name;



  @JsonKey(
    
    name: r'phone',
    required: false,
    includeIfNull: false,
  )


  final String? phone;





    @override
    bool operator ==(Object other) => identical(this, other) || other is CreateSupplierRequest &&
      other.contactName == contactName &&
      other.email == email &&
      other.name == name &&
      other.phone == phone;

    @override
    int get hashCode =>
        (contactName == null ? 0 : contactName.hashCode) +
        (email == null ? 0 : email.hashCode) +
        name.hashCode +
        (phone == null ? 0 : phone.hashCode);

  factory CreateSupplierRequest.fromJson(Map<String, dynamic> json) => _$CreateSupplierRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateSupplierRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

