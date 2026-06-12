// Façade over the OpenAPI-generated wire models (packages/sufrix_api).
import 'package:sufrix_api/sufrix_api.dart';

export 'package:sufrix_api/sufrix_api.dart' show Shift, ShiftPreFill;

extension ShiftX on Shift {
  bool get isOpen => status == 'open';
}
