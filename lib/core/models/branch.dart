// Façade over the OpenAPI-generated wire models (packages/sufrix_api).
// Keep this file free of hand-rolled fields/fromJson/toJson — only
// exports, typedefs and client-side extensions live here.
import 'package:sufrix_api/sufrix_api.dart';

export 'package:sufrix_api/sufrix_api.dart' show Branch, PrinterBrand;

extension BranchX on Branch {
  /// True when this branch has a usable thermal printer configured.
  /// An unknown printer brand (newer backend than app) degrades to
  /// "no printer" instead of crashing print flows.
  bool get hasPrinter =>
      printerIp != null &&
      printerIp!.trim().isNotEmpty &&
      printerBrand != null &&
      printerBrand != PrinterBrand.unknownDefaultOpenApi;
}
