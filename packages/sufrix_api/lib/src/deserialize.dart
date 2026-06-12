import 'package:sufrix_api/src/model/add_to_stock_request.dart';
import 'package:sufrix_api/src/model/addon_cost.dart';
import 'package:sufrix_api/src/model/addon_ingredient.dart';
import 'package:sufrix_api/src/model/addon_input.dart';
import 'package:sufrix_api/src/model/addon_item.dart';
import 'package:sufrix_api/src/model/addon_item_ingredient.dart';
import 'package:sufrix_api/src/model/addon_override.dart';
import 'package:sufrix_api/src/model/addon_sales_row.dart';
import 'package:sufrix_api/src/model/addon_slot.dart';
import 'package:sufrix_api/src/model/assign_branch_request.dart';
import 'package:sufrix_api/src/model/auth_permissions_response.dart';
import 'package:sufrix_api/src/model/branch.dart';
import 'package:sufrix_api/src/model/branch_comparison.dart';
import 'package:sufrix_api/src/model/branch_inventory_adjustment.dart';
import 'package:sufrix_api/src/model/branch_inventory_item.dart';
import 'package:sufrix_api/src/model/branch_inventory_transfer.dart';
import 'package:sufrix_api/src/model/branch_sales_report.dart';
import 'package:sufrix_api/src/model/branch_stock_report.dart';
import 'package:sufrix_api/src/model/bundle.dart';
import 'package:sufrix_api/src/model/bundle_component_hydrated.dart';
import 'package:sufrix_api/src/model/bundle_component_input.dart';
import 'package:sufrix_api/src/model/bundle_performance_response.dart';
import 'package:sufrix_api/src/model/bundle_sales_row.dart';
import 'package:sufrix_api/src/model/bundle_with_components.dart';
import 'package:sufrix_api/src/model/cash_movement.dart';
import 'package:sufrix_api/src/model/cash_movement_request.dart';
import 'package:sufrix_api/src/model/cash_movement_summary_row.dart';
import 'package:sufrix_api/src/model/category.dart';
import 'package:sufrix_api/src/model/category_sales.dart';
import 'package:sufrix_api/src/model/close_shift_request.dart';
import 'package:sufrix_api/src/model/close_shift_response.dart';
import 'package:sufrix_api/src/model/combined_item_sales_row.dart';
import 'package:sufrix_api/src/model/component_popularity.dart';
import 'package:sufrix_api/src/model/create_addon_item_request.dart';
import 'package:sufrix_api/src/model/create_addon_slot_request.dart';
import 'package:sufrix_api/src/model/create_adjustment_request.dart';
import 'package:sufrix_api/src/model/create_branch_request.dart';
import 'package:sufrix_api/src/model/create_bundle_component_input.dart';
import 'package:sufrix_api/src/model/create_bundle_request.dart';
import 'package:sufrix_api/src/model/create_catalog_item_request.dart';
import 'package:sufrix_api/src/model/create_category_request.dart';
import 'package:sufrix_api/src/model/create_discount_request.dart';
import 'package:sufrix_api/src/model/create_menu_item_request.dart';
import 'package:sufrix_api/src/model/create_optional_field_request.dart';
import 'package:sufrix_api/src/model/create_order_request.dart';
import 'package:sufrix_api/src/model/create_payment_method_request.dart';
import 'package:sufrix_api/src/model/create_transfer_request.dart';
import 'package:sufrix_api/src/model/create_user_request.dart';
import 'package:sufrix_api/src/model/create_user_response.dart';
import 'package:sufrix_api/src/model/deduction_log_row.dart';
import 'package:sufrix_api/src/model/discount.dart';
import 'package:sufrix_api/src/model/drink_recipe.dart';
import 'package:sufrix_api/src/model/error_body.dart';
import 'package:sufrix_api/src/model/export_response.dart';
import 'package:sufrix_api/src/model/force_close_request.dart';
import 'package:sufrix_api/src/model/inventory_count_input.dart';
import 'package:sufrix_api/src/model/inventory_count_row.dart';
import 'package:sufrix_api/src/model/inventory_discrepancy.dart';
import 'package:sufrix_api/src/model/item_sales.dart';
import 'package:sufrix_api/src/model/item_size.dart';
import 'package:sufrix_api/src/model/login_request.dart';
import 'package:sufrix_api/src/model/login_response.dart';
import 'package:sufrix_api/src/model/me_response.dart';
import 'package:sufrix_api/src/model/menu_engineering_report.dart';
import 'package:sufrix_api/src/model/menu_engineering_row.dart';
import 'package:sufrix_api/src/model/menu_item.dart';
import 'package:sufrix_api/src/model/menu_item_full.dart';
import 'package:sufrix_api/src/model/menu_item_recipe.dart';
import 'package:sufrix_api/src/model/onboarding_status.dart';
import 'package:sufrix_api/src/model/onboarding_step.dart';
import 'package:sufrix_api/src/model/open_shift_request.dart';
import 'package:sufrix_api/src/model/optional_field.dart';
import 'package:sufrix_api/src/model/order.dart';
import 'package:sufrix_api/src/model/order_bundle_component_addon.dart';
import 'package:sufrix_api/src/model/order_bundle_component_full.dart';
import 'package:sufrix_api/src/model/order_bundle_component_optional.dart';
import 'package:sufrix_api/src/model/order_export.dart';
import 'package:sufrix_api/src/model/order_full.dart';
import 'package:sufrix_api/src/model/order_item.dart';
import 'package:sufrix_api/src/model/order_item_addon.dart';
import 'package:sufrix_api/src/model/order_item_full.dart';
import 'package:sufrix_api/src/model/order_item_input.dart';
import 'package:sufrix_api/src/model/order_item_optional.dart';
import 'package:sufrix_api/src/model/order_payment.dart';
import 'package:sufrix_api/src/model/order_summary.dart';
import 'package:sufrix_api/src/model/org.dart';
import 'package:sufrix_api/src/model/org_comparison_report.dart';
import 'package:sufrix_api/src/model/org_ingredient.dart';
import 'package:sufrix_api/src/model/org_payment_method.dart';
import 'package:sufrix_api/src/model/paginated_bundles.dart';
import 'package:sufrix_api/src/model/paginated_orders.dart';
import 'package:sufrix_api/src/model/paginated_orders_full.dart';
import 'package:sufrix_api/src/model/payment_split_input.dart';
import 'package:sufrix_api/src/model/payment_summary_row.dart';
import 'package:sufrix_api/src/model/permission.dart';
import 'package:sufrix_api/src/model/permission_matrix.dart';
import 'package:sufrix_api/src/model/preview_addon_input.dart';
import 'package:sufrix_api/src/model/preview_ingredient.dart';
import 'package:sufrix_api/src/model/preview_recipe_request.dart';
import 'package:sufrix_api/src/model/public_addon_item.dart';
import 'package:sufrix_api/src/model/public_addon_slot.dart';
import 'package:sufrix_api/src/model/public_category.dart';
import 'package:sufrix_api/src/model/public_item_size.dart';
import 'package:sufrix_api/src/model/public_menu_item.dart';
import 'package:sufrix_api/src/model/public_menu_response.dart';
import 'package:sufrix_api/src/model/public_org.dart';
import 'package:sufrix_api/src/model/resolve_branch_request.dart';
import 'package:sufrix_api/src/model/resolve_branch_response.dart';
import 'package:sufrix_api/src/model/role_permission.dart';
import 'package:sufrix_api/src/model/shift.dart';
import 'package:sufrix_api/src/model/shift_pre_fill.dart';
import 'package:sufrix_api/src/model/shift_report_response.dart';
import 'package:sufrix_api/src/model/shift_summary.dart';
import 'package:sufrix_api/src/model/sku_cost.dart';
import 'package:sufrix_api/src/model/stock_row.dart';
import 'package:sufrix_api/src/model/teller_stats.dart';
import 'package:sufrix_api/src/model/timeseries_point.dart';
import 'package:sufrix_api/src/model/update_addon_item_request.dart';
import 'package:sufrix_api/src/model/update_addon_slot_request.dart';
import 'package:sufrix_api/src/model/update_branch_request.dart';
import 'package:sufrix_api/src/model/update_bundle_request.dart';
import 'package:sufrix_api/src/model/update_catalog_item_request.dart';
import 'package:sufrix_api/src/model/update_category_request.dart';
import 'package:sufrix_api/src/model/update_discount_request.dart';
import 'package:sufrix_api/src/model/update_menu_item_request.dart';
import 'package:sufrix_api/src/model/update_optional_field_request.dart';
import 'package:sufrix_api/src/model/update_org_request.dart';
import 'package:sufrix_api/src/model/update_payment_method_request.dart';
import 'package:sufrix_api/src/model/update_stock_request.dart';
import 'package:sufrix_api/src/model/update_transfer_request.dart';
import 'package:sufrix_api/src/model/update_user_request.dart';
import 'package:sufrix_api/src/model/upload_response.dart';
import 'package:sufrix_api/src/model/upsert_addon_ingredient_request.dart';
import 'package:sufrix_api/src/model/upsert_addon_override_request.dart';
import 'package:sufrix_api/src/model/upsert_drink_recipe_request.dart';
import 'package:sufrix_api/src/model/upsert_permission_request.dart';
import 'package:sufrix_api/src/model/upsert_role_permission_request.dart';
import 'package:sufrix_api/src/model/upsert_size_request.dart';
import 'package:sufrix_api/src/model/user_branch.dart';
import 'package:sufrix_api/src/model/user_permission_item.dart';
import 'package:sufrix_api/src/model/user_public.dart';
import 'package:sufrix_api/src/model/void_order_request.dart';

final _regList = RegExp(r'^List<(.*)>$');
final _regSet = RegExp(r'^Set<(.*)>$');
final _regMap = RegExp(r'^Map<String,(.*)>$');

  ReturnType deserialize<ReturnType, BaseType>(dynamic value, String targetType, {bool growable= true}) {
      switch (targetType) {
        case 'String':
          return '$value' as ReturnType;
        case 'int':
          return (value is int ? value : int.parse('$value')) as ReturnType;
        case 'bool':
          if (value is bool) {
            return value as ReturnType;
          }
          final valueString = '$value'.toLowerCase();
          return (valueString == 'true' || valueString == '1') as ReturnType;
        case 'double':
          return (value is double ? value : double.parse('$value')) as ReturnType;
        case 'AddToStockRequest':
          return AddToStockRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'AddonCost':
          return AddonCost.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'AddonIngredient':
          return AddonIngredient.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'AddonInput':
          return AddonInput.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'AddonItem':
          return AddonItem.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'AddonItemIngredient':
          return AddonItemIngredient.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'AddonOverride':
          return AddonOverride.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'AddonSalesRow':
          return AddonSalesRow.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'AddonSlot':
          return AddonSlot.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'AssignBranchRequest':
          return AssignBranchRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'AuthPermissionsResponse':
          return AuthPermissionsResponse.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'Branch':
          return Branch.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'BranchComparison':
          return BranchComparison.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'BranchInventoryAdjustment':
          return BranchInventoryAdjustment.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'BranchInventoryItem':
          return BranchInventoryItem.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'BranchInventoryTransfer':
          return BranchInventoryTransfer.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'BranchSalesReport':
          return BranchSalesReport.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'BranchStockReport':
          return BranchStockReport.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'Bundle':
          return Bundle.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'BundleComponentHydrated':
          return BundleComponentHydrated.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'BundleComponentInput':
          return BundleComponentInput.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'BundlePerformanceResponse':
          return BundlePerformanceResponse.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'BundleSalesRow':
          return BundleSalesRow.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'BundleStatus':
          
          
        case 'BundleWithComponents':
          return BundleWithComponents.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'CashMovement':
          return CashMovement.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'CashMovementRequest':
          return CashMovementRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'CashMovementSummaryRow':
          return CashMovementSummaryRow.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'Category':
          return Category.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'CategorySales':
          return CategorySales.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'CloseShiftRequest':
          return CloseShiftRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'CloseShiftResponse':
          return CloseShiftResponse.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'CombinedItemSalesRow':
          return CombinedItemSalesRow.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ComponentPopularity':
          return ComponentPopularity.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'CreateAddonItemRequest':
          return CreateAddonItemRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'CreateAddonSlotRequest':
          return CreateAddonSlotRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'CreateAdjustmentRequest':
          return CreateAdjustmentRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'CreateBranchRequest':
          return CreateBranchRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'CreateBundleComponentInput':
          return CreateBundleComponentInput.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'CreateBundleRequest':
          return CreateBundleRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'CreateCatalogItemRequest':
          return CreateCatalogItemRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'CreateCategoryRequest':
          return CreateCategoryRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'CreateDiscountRequest':
          return CreateDiscountRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'CreateMenuItemRequest':
          return CreateMenuItemRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'CreateOptionalFieldRequest':
          return CreateOptionalFieldRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'CreateOrderRequest':
          return CreateOrderRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'CreatePaymentMethodRequest':
          return CreatePaymentMethodRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'CreateTransferRequest':
          return CreateTransferRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'CreateUserRequest':
          return CreateUserRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'CreateUserResponse':
          return CreateUserResponse.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DeductionLogRow':
          return DeductionLogRow.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'Discount':
          return Discount.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DrinkRecipe':
          return DrinkRecipe.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ErrorBody':
          return ErrorBody.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ExportResponse':
          return ExportResponse.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ForceCloseRequest':
          return ForceCloseRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'InventoryCountInput':
          return InventoryCountInput.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'InventoryCountRow':
          return InventoryCountRow.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'InventoryDiscrepancy':
          return InventoryDiscrepancy.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ItemSales':
          return ItemSales.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ItemSize':
          return ItemSize.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'LoginRequest':
          return LoginRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'LoginResponse':
          return LoginResponse.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MeResponse':
          return MeResponse.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MenuEngineeringReport':
          return MenuEngineeringReport.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MenuEngineeringRow':
          return MenuEngineeringRow.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MenuItem':
          return MenuItem.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MenuItemFull':
          return MenuItemFull.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MenuItemRecipe':
          return MenuItemRecipe.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OnboardingStatus':
          return OnboardingStatus.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OnboardingStep':
          return OnboardingStep.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OpenShiftRequest':
          return OpenShiftRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OptionalField':
          return OptionalField.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'Order':
          return Order.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OrderBundleComponentAddon':
          return OrderBundleComponentAddon.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OrderBundleComponentFull':
          return OrderBundleComponentFull.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OrderBundleComponentOptional':
          return OrderBundleComponentOptional.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OrderExport':
          return OrderExport.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OrderFull':
          return OrderFull.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OrderItem':
          return OrderItem.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OrderItemAddon':
          return OrderItemAddon.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OrderItemFull':
          return OrderItemFull.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OrderItemInput':
          return OrderItemInput.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OrderItemOptional':
          return OrderItemOptional.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OrderPayment':
          return OrderPayment.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OrderSummary':
          return OrderSummary.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'Org':
          return Org.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OrgComparisonReport':
          return OrgComparisonReport.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OrgIngredient':
          return OrgIngredient.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OrgPaymentMethod':
          return OrgPaymentMethod.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'PaginatedBundles':
          return PaginatedBundles.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'PaginatedOrders':
          return PaginatedOrders.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'PaginatedOrdersFull':
          return PaginatedOrdersFull.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'PaymentSplitInput':
          return PaymentSplitInput.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'PaymentSummaryRow':
          return PaymentSummaryRow.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'Permission':
          return Permission.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'PermissionMatrix':
          return PermissionMatrix.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'PreviewAddonInput':
          return PreviewAddonInput.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'PreviewIngredient':
          return PreviewIngredient.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'PreviewRecipeRequest':
          return PreviewRecipeRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'PrinterBrand':
          
          
        case 'PublicAddonItem':
          return PublicAddonItem.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'PublicAddonSlot':
          return PublicAddonSlot.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'PublicCategory':
          return PublicCategory.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'PublicItemSize':
          return PublicItemSize.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'PublicMenuItem':
          return PublicMenuItem.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'PublicMenuResponse':
          return PublicMenuResponse.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'PublicOrg':
          return PublicOrg.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ResolveBranchRequest':
          return ResolveBranchRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ResolveBranchResponse':
          return ResolveBranchResponse.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'RolePermission':
          return RolePermission.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'Shift':
          return Shift.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ShiftPreFill':
          return ShiftPreFill.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ShiftReportResponse':
          return ShiftReportResponse.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ShiftSummary':
          return ShiftSummary.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'SkuCost':
          return SkuCost.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'StockRow':
          return StockRow.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'TellerStats':
          return TellerStats.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'TimeseriesPoint':
          return TimeseriesPoint.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UpdateAddonItemRequest':
          return UpdateAddonItemRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UpdateAddonSlotRequest':
          return UpdateAddonSlotRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UpdateBranchRequest':
          return UpdateBranchRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UpdateBundleRequest':
          return UpdateBundleRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UpdateCatalogItemRequest':
          return UpdateCatalogItemRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UpdateCategoryRequest':
          return UpdateCategoryRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UpdateDiscountRequest':
          return UpdateDiscountRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UpdateMenuItemRequest':
          return UpdateMenuItemRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UpdateOptionalFieldRequest':
          return UpdateOptionalFieldRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UpdateOrgRequest':
          return UpdateOrgRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UpdatePaymentMethodRequest':
          return UpdatePaymentMethodRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UpdateStockRequest':
          return UpdateStockRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UpdateTransferRequest':
          return UpdateTransferRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UpdateUserRequest':
          return UpdateUserRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UploadResponse':
          return UploadResponse.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UpsertAddonIngredientRequest':
          return UpsertAddonIngredientRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UpsertAddonOverrideRequest':
          return UpsertAddonOverrideRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UpsertDrinkRecipeRequest':
          return UpsertDrinkRecipeRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UpsertPermissionRequest':
          return UpsertPermissionRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UpsertRolePermissionRequest':
          return UpsertRolePermissionRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UpsertSizeRequest':
          return UpsertSizeRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UserBranch':
          return UserBranch.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UserPermissionItem':
          return UserPermissionItem.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UserPublic':
          return UserPublic.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UserRole':
          
          
        case 'VoidOrderRequest':
          return VoidOrderRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        default:
          RegExpMatch? match;

          if (value is List && (match = _regList.firstMatch(targetType)) != null) {
            targetType = match![1]!; // ignore: parameter_assignments
            return value
              .map<BaseType>((dynamic v) => deserialize<BaseType, BaseType>(v, targetType, growable: growable))
              .toList(growable: growable) as ReturnType;
          }
          if (value is Set && (match = _regSet.firstMatch(targetType)) != null) {
            targetType = match![1]!; // ignore: parameter_assignments
            return value
              .map<BaseType>((dynamic v) => deserialize<BaseType, BaseType>(v, targetType, growable: growable))
              .toSet() as ReturnType;
          }
          if (value is Map && (match = _regMap.firstMatch(targetType)) != null) {
            targetType = match![1]!.trim(); // ignore: parameter_assignments
            return Map<String, BaseType>.fromIterables(
              value.keys as Iterable<String>,
              value.values.map((dynamic v) => deserialize<BaseType, BaseType>(v, targetType, growable: growable)),
            ) as ReturnType;
          }
          break;
    }
    throw Exception('Cannot deserialize');
  }