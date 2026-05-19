import '../models/shift.dart';

/// SharedPreferences scope: `{branchId}_{shiftId}`.
String? cartStorageScope(Shift? shift) {
  if (shift == null) return null;
  return '${shift.branchId}_${shift.id}';
}
