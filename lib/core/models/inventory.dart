// Façade over the OpenAPI-generated wire models (packages/sufrix_api).
// The app's `InventoryItem` is the spec's `BranchInventoryItem`.
import 'package:sufrix_api/sufrix_api.dart';

export 'package:sufrix_api/sufrix_api.dart' show BranchInventoryItem;

typedef InventoryItem = BranchInventoryItem;

extension InventoryItemX on BranchInventoryItem {
  /// Legacy app-side alias for the wire `ingredient_name`.
  String get name => ingredientName;
}
