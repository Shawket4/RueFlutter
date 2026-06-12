// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UploadResponseCWProxy {
  UploadResponse imageUrl(String imageUrl);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UploadResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UploadResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  UploadResponse call({String imageUrl});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUploadResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUploadResponse.copyWith.fieldName(...)`
class _$UploadResponseCWProxyImpl implements _$UploadResponseCWProxy {
  const _$UploadResponseCWProxyImpl(this._value);

  final UploadResponse _value;

  @override
  UploadResponse imageUrl(String imageUrl) => this(imageUrl: imageUrl);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UploadResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UploadResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  UploadResponse call({Object? imageUrl = const $CopyWithPlaceholder()}) {
    return UploadResponse(
      imageUrl: imageUrl == const $CopyWithPlaceholder()
          ? _value.imageUrl
          // ignore: cast_nullable_to_non_nullable
          : imageUrl as String,
    );
  }
}

extension $UploadResponseCopyWith on UploadResponse {
  /// Returns a callable class that can be used as follows: `instanceOfUploadResponse.copyWith(...)` or like so:`instanceOfUploadResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UploadResponseCWProxy get copyWith => _$UploadResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadResponse _$UploadResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UploadResponse', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['image_url']);
      final val = UploadResponse(
        imageUrl: $checkedConvert('image_url', (v) => v as String),
      );
      return val;
    }, fieldKeyMap: const {'imageUrl': 'image_url'});

Map<String, dynamic> _$UploadResponseToJson(UploadResponse instance) =>
    <String, dynamic>{'image_url': instance.imageUrl};
