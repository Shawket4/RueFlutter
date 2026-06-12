// Façade over the OpenAPI-generated wire models (packages/sufrix_api).
import 'package:sufrix_api/sufrix_api.dart';

export 'package:sufrix_api/sufrix_api.dart' show Discount;

extension DiscountX on Discount {
  /// Human-readable label, e.g. "Staff (10%)" or "Promo (EGP 5 off)".
  String get label {
    if (dtype == 'percentage') return '$name ($value%)';
    final egp = (value / 100).toStringAsFixed(value % 100 == 0 ? 0 : 2);
    return '$name (EGP $egp off)';
  }
}
