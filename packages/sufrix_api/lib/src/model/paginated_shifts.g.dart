// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_shifts.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PaginatedShiftsCWProxy {
  PaginatedShifts data(List<Shift> data);

  PaginatedShifts page(int page);

  PaginatedShifts perPage(int perPage);

  PaginatedShifts total(int total);

  PaginatedShifts totalPages(int totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PaginatedShifts(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PaginatedShifts(...).copyWith(id: 12, name: "My name")
  /// ````
  PaginatedShifts call({
    List<Shift> data,
    int page,
    int perPage,
    int total,
    int totalPages,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPaginatedShifts.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPaginatedShifts.copyWith.fieldName(...)`
class _$PaginatedShiftsCWProxyImpl implements _$PaginatedShiftsCWProxy {
  const _$PaginatedShiftsCWProxyImpl(this._value);

  final PaginatedShifts _value;

  @override
  PaginatedShifts data(List<Shift> data) => this(data: data);

  @override
  PaginatedShifts page(int page) => this(page: page);

  @override
  PaginatedShifts perPage(int perPage) => this(perPage: perPage);

  @override
  PaginatedShifts total(int total) => this(total: total);

  @override
  PaginatedShifts totalPages(int totalPages) => this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PaginatedShifts(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PaginatedShifts(...).copyWith(id: 12, name: "My name")
  /// ````
  PaginatedShifts call({
    Object? data = const $CopyWithPlaceholder(),
    Object? page = const $CopyWithPlaceholder(),
    Object? perPage = const $CopyWithPlaceholder(),
    Object? total = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return PaginatedShifts(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<Shift>,
      page: page == const $CopyWithPlaceholder()
          ? _value.page
          // ignore: cast_nullable_to_non_nullable
          : page as int,
      perPage: perPage == const $CopyWithPlaceholder()
          ? _value.perPage
          // ignore: cast_nullable_to_non_nullable
          : perPage as int,
      total: total == const $CopyWithPlaceholder()
          ? _value.total
          // ignore: cast_nullable_to_non_nullable
          : total as int,
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as int,
    );
  }
}

extension $PaginatedShiftsCopyWith on PaginatedShifts {
  /// Returns a callable class that can be used as follows: `instanceOfPaginatedShifts.copyWith(...)` or like so:`instanceOfPaginatedShifts.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PaginatedShiftsCWProxy get copyWith => _$PaginatedShiftsCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedShifts _$PaginatedShiftsFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'PaginatedShifts',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const [
            'data',
            'page',
            'per_page',
            'total',
            'total_pages',
          ],
        );
        final val = PaginatedShifts(
          data: $checkedConvert(
            'data',
            (v) => (v as List<dynamic>)
                .map((e) => Shift.fromJson(e as Map<String, dynamic>))
                .toList(),
          ),
          page: $checkedConvert('page', (v) => (v as num).toInt()),
          perPage: $checkedConvert('per_page', (v) => (v as num).toInt()),
          total: $checkedConvert('total', (v) => (v as num).toInt()),
          totalPages: $checkedConvert('total_pages', (v) => (v as num).toInt()),
        );
        return val;
      },
      fieldKeyMap: const {'perPage': 'per_page', 'totalPages': 'total_pages'},
    );

Map<String, dynamic> _$PaginatedShiftsToJson(PaginatedShifts instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'page': instance.page,
      'per_page': instance.perPage,
      'total': instance.total,
      'total_pages': instance.totalPages,
    };
