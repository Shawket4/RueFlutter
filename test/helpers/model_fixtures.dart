// Shared test fixtures for the OpenAPI-generated wire models.
//
// The generated constructors require every wire field (created_at,
// name_translations, …); these makers fill the noise with stable defaults so
// tests only state what they assert on.
import 'package:sufrix_pos/core/models/branch.dart';
import 'package:sufrix_pos/core/models/bundle.dart';
import 'package:sufrix_pos/core/models/discount.dart';
import 'package:sufrix_pos/core/models/inventory.dart';
import 'package:sufrix_pos/core/models/menu.dart';
import 'package:sufrix_pos/core/models/order.dart';
import 'package:sufrix_pos/core/models/payment_method.dart';
import 'package:sufrix_pos/core/models/shift.dart';
import 'package:sufrix_pos/core/models/shift_report.dart';
import 'package:sufrix_pos/core/models/user.dart';

final DateTime kFixtureTime = DateTime.parse('2026-01-01T00:00:00.000Z');

MenuItem makeMenuItem({
  String id = 'm1',
  String orgId = 'o1',
  String? categoryId,
  String name = 'Item',
  String? description,
  String? imageUrl,
  int basePrice = 1000,
  bool isActive = true,
  int displayOrder = 0,
  List<ItemSize> sizes = const [],
  List<AddonSlot> addonSlots = const [],
  List<OptionalField> optionalFields = const [],
  String? defaultMilkAddonId,
  List<MenuItemRecipe> recipes = const [],
}) =>
    MenuItem(
      id: id,
      orgId: orgId,
      categoryId: categoryId,
      name: name,
      nameTranslations: const <String, dynamic>{},
      description: description,
      descriptionTranslations: const <String, dynamic>{},
      imageUrl: imageUrl,
      basePrice: basePrice,
      isActive: isActive,
      sizes: sizes,
      addonSlots: addonSlots,
      optionalFields: optionalFields,
      defaultMilkAddonId: defaultMilkAddonId,
      recipes: recipes,
      createdAt: kFixtureTime,
      updatedAt: kFixtureTime,
    );

Category makeCategory({
  String id = 'c1',
  String orgId = 'o1',
  String name = 'Category',
  String? imageUrl,
  int displayOrder = 0,
  bool isActive = true,
}) =>
    Category(
      id: id,
      orgId: orgId,
      name: name,
      nameTranslations: const <String, dynamic>{},
      imageUrl: imageUrl,
      isActive: isActive,
      createdAt: kFixtureTime,
      updatedAt: kFixtureTime,
    );

ItemSize makeItemSize({
  String id = 's1',
  String menuItemId = 'm1',
  String label = 'M',
  int priceOverride = 0,
  int displayOrder = 0,
  bool isActive = true,
}) =>
    ItemSize(
      id: id,
      menuItemId: menuItemId,
      label: label,
      priceOverride: priceOverride,
      isActive: isActive,
    );

AddonItem makeAddonItem({
  String id = 'a1',
  String orgId = 'o1',
  String name = 'Addon',
  String addonType = 'extra',
  int defaultPrice = 0,
  bool isActive = true,
  int displayOrder = 0,
  String? primaryIngredientId,
  List<AddonItemIngredient>? ingredients,
}) =>
    AddonItem(
      id: id,
      orgId: orgId,
      name: name,
      nameTranslations: const <String, dynamic>{},
      addonType: addonType,
      defaultPrice: defaultPrice,
      isActive: isActive,
      primaryIngredientId: primaryIngredientId,
      ingredients: ingredients,
      createdAt: kFixtureTime,
      updatedAt: kFixtureTime,
    );

AddonSlot makeAddonSlot({
  String id = 'slot1',
  String menuItemId = 'm1',
  String addonType = 'extra',
  String? label,
  bool isRequired = false,
  int minSelections = 0,
  int? maxSelections,
  int displayOrder = 0,
}) =>
    AddonSlot(
      id: id,
      menuItemId: menuItemId,
      addonType: addonType,
      label: label,
      labelTranslations: const <String, dynamic>{},
      isRequired: isRequired,
      minSelections: minSelections,
      maxSelections: maxSelections,
      createdAt: kFixtureTime,
    );

OptionalField makeOptionalField({
  String id = 'f1',
  String menuItemId = 'm1',
  String name = 'Field',
  int price = 0,
  String? orgIngredientId,
  String? ingredientName,
  String? ingredientUnit,
  double? quantityUsed,
  String? sizeLabel,
  int displayOrder = 0,
  bool isActive = true,
}) =>
    OptionalField(
      id: id,
      menuItemId: menuItemId,
      name: name,
      nameTranslations: const <String, dynamic>{},
      price: price,
      orgIngredientId: orgIngredientId,
      ingredientName: ingredientName,
      ingredientUnit: ingredientUnit,
      quantityUsed: quantityUsed,
      sizeLabel: sizeLabel,
      isActive: isActive,
      createdAt: kFixtureTime,
      updatedAt: kFixtureTime,
    );

MenuItemRecipe makeMenuItemRecipe({
  String? orgIngredientId,
  double quantityUsed = 1,
  String ingredientName = 'Ingredient',
  String ingredientUnit = 'g',
  String category = 'general',
  String sizeLabel = '',
}) =>
    MenuItemRecipe(
      orgIngredientId: orgIngredientId,
      quantityUsed: quantityUsed,
      ingredientName: ingredientName,
      ingredientUnit: ingredientUnit,
      category: category,
      sizeLabel: sizeLabel,
    );

Bundle makeBundle({
  String id = 'b1',
  String orgId = 'o1',
  String name = 'Bundle',
  String? description,
  int price = 1000,
  BundleStatus status = BundleStatus.active,
  String? imageUrl,
  int displayOrder = 0,
  DateTime? availableFromDate,
  DateTime? availableUntilDate,
  String? availableFromTime,
  String? availableUntilTime,
  List<String> branchIds = const [],
  List<BundleComponent> components = const [],
  int computedCost = 0,
}) =>
    Bundle(
      id: id,
      orgId: orgId,
      name: name,
      nameTranslations: const <String, dynamic>{},
      description: description,
      descriptionTranslations: const <String, dynamic>{},
      price: price,
      status: status,
      imageUrl: imageUrl,
      availableFromDate: availableFromDate,
      availableUntilDate: availableUntilDate,
      availableFromTime: availableFromTime,
      availableUntilTime: availableUntilTime,
      branchIds: branchIds,
      components: components,
      computedCost: computedCost,
      createdAt: kFixtureTime,
      updatedAt: kFixtureTime,
    );

BundleComponent makeBundleComponent({
  String id = 'bc1',
  String bundleId = 'b1',
  String itemId = 'm1',
  String itemName = 'Item',
  int itemPrice = 0,
  int itemCost = 0,
  int quantity = 1,
  int position = 0,
}) =>
    BundleComponent(
      id: id,
      bundleId: bundleId,
      itemId: itemId,
      itemName: itemName,
      itemPrice: itemPrice,
      itemCost: itemCost,
      quantity: quantity,
      position: position,
    );

InventoryItem makeInventoryItem({
  String id = 'inv1',
  String branchId = 'br1',
  String orgIngredientId = 'ing1',
  String ingredientName = 'Milk',
  String unit = 'ml',
  double currentStock = 0,
  double costPerUnit = 0,
  double reorderThreshold = 0,
  bool belowReorder = false,
}) =>
    InventoryItem(
      id: id,
      branchId: branchId,
      orgIngredientId: orgIngredientId,
      ingredientName: ingredientName,
      unit: unit,
      currentStock: currentStock,
      costPerUnit: costPerUnit,
      reorderThreshold: reorderThreshold,
      belowReorder: belowReorder,
      createdAt: kFixtureTime,
      updatedAt: kFixtureTime,
    );

Branch makeBranch({
  String id = 'br1',
  String orgId = 'o1',
  String name = 'Branch',
  String? address,
  String? phone,
  PrinterBrand? printerBrand,
  String? printerIp,
  int? printerPort = 9100,
  bool isActive = true,
  String? orgLogoUrl,
  String timezone = 'Africa/Cairo',
}) =>
    Branch(
      id: id,
      orgId: orgId,
      name: name,
      address: address,
      phone: phone,
      printerBrand: printerBrand,
      printerIp: printerIp,
      printerPort: printerPort,
      isActive: isActive,
      orgLogoUrl: orgLogoUrl,
      timezone: timezone,
      createdAt: kFixtureTime,
      updatedAt: kFixtureTime,
    );

User makeUser({
  String id = 'u1',
  String? orgId = 'o1',
  String? branchId,
  String name = 'Teller',
  String? email,
  UserRole role = UserRole.teller,
  bool isActive = true,
}) =>
    User(
      id: id,
      orgId: orgId,
      branchId: branchId,
      name: name,
      email: email,
      role: role,
      isActive: isActive,
    );

Shift makeShift({
  String id = 'sh1',
  String branchId = 'br1',
  String tellerId = 'u1',
  String tellerName = 'Teller',
  String status = 'open',
  int openingCash = 0,
  bool openingCashWasEdited = false,
  int? closingCashDeclared,
  int? closingCashSystem,
  int? cashDiscrepancy,
  DateTime? openedAt,
  DateTime? closedAt,
}) =>
    Shift(
      id: id,
      branchId: branchId,
      tellerId: tellerId,
      tellerName: tellerName,
      status: status,
      openingCash: openingCash,
      openingCashWasEdited: openingCashWasEdited,
      closingCashDeclared: closingCashDeclared,
      closingCashSystem: closingCashSystem,
      cashDiscrepancy: cashDiscrepancy,
      openedAt: openedAt ?? kFixtureTime,
      closedAt: closedAt,
    );

Discount makeDiscount({
  String id = 'd1',
  String orgId = 'o1',
  String name = 'Discount',
  String dtype = 'percentage',
  int value = 10,
  bool isActive = true,
}) =>
    Discount(
      id: id,
      orgId: orgId,
      name: name,
      nameTranslations: const <String, dynamic>{},
      dtype: dtype,
      value: value,
      isActive: isActive,
      createdAt: kFixtureTime,
      updatedAt: kFixtureTime,
    );

PaymentMethod makePaymentMethod({
  String id = 'pm1',
  String orgId = 'o1',
  String name = 'cash',
  Map<String, dynamic>? labelTranslations,
  String color = '',
  String icon = '',
  bool isCash = true,
  bool isActive = true,
  int displayOrder = 0,
}) =>
    PaymentMethod(
      id: id,
      orgId: orgId,
      name: name,
      labelTranslations: labelTranslations ?? const <String, dynamic>{},
      color: color,
      icon: icon,
      isCash: isCash,
      isActive: isActive,
      createdAt: kFixtureTime,
      updatedAt: kFixtureTime,
    );

Order makeOrder({
  String id = 'ord1',
  String branchId = 'br1',
  String shiftId = 'sh1',
  String tellerId = 'u1',
  String tellerName = 'Teller',
  int orderNumber = 1,
  String status = 'completed',
  String paymentMethod = 'cash',
  int subtotal = 0,
  String? discountType,
  int discountValue = 0,
  int discountAmount = 0,
  int taxAmount = 0,
  int totalAmount = 0,
  int? amountTendered,
  int? changeGiven,
  int? tipAmount,
  String? tipPaymentMethod,
  String? discountId,
  String? customerName,
  String? notes,
  String? voidReason,
  DateTime? createdAt,
  List<OrderItem> items = const [],
}) =>
    Order(
      id: id,
      branchId: branchId,
      shiftId: shiftId,
      tellerId: tellerId,
      tellerName: tellerName,
      orderNumber: orderNumber,
      status: status,
      paymentMethod: paymentMethod,
      subtotal: subtotal,
      discountType: discountType,
      discountValue: discountValue,
      discountAmount: discountAmount,
      taxAmount: taxAmount,
      totalAmount: totalAmount,
      amountTendered: amountTendered,
      changeGiven: changeGiven,
      tipAmount: tipAmount,
      tipPaymentMethod: tipPaymentMethod,
      discountId: discountId,
      customerName: customerName,
      notes: notes,
      voidReason: voidReason,
      createdAt: createdAt ?? kFixtureTime,
      items: items,
    );

OrderItem makeOrderItem({
  String id = 'oi1',
  String orderId = 'ord1',
  String itemName = 'Item',
  String? sizeLabel,
  String? bundleId,
  List<OrderBundleComponentFull>? bundleComponents,
  int unitPrice = 0,
  int quantity = 1,
  int lineTotal = 0,
  List<OrderItemAddon> addons = const [],
  List<OrderItemOptional> optionals = const [],
  Object? deductionsSnapshot = const [],
  bool costMissing = false,
}) =>
    OrderItem(
      id: id,
      orderId: orderId,
      itemName: itemName,
      nameTranslations: const <String, dynamic>{},
      sizeLabel: sizeLabel,
      bundleId: bundleId,
      bundleComponents: bundleComponents,
      unitPrice: unitPrice,
      quantity: quantity,
      lineTotal: lineTotal,
      addons: addons,
      optionals: optionals,
      deductionsSnapshot: deductionsSnapshot,
      costMissing: costMissing,
    );

OrderItemAddon makeOrderItemAddon({
  String id = 'oia1',
  String orderItemId = 'oi1',
  String addonItemId = 'a1',
  String addonName = 'Addon',
  int unitPrice = 0,
  int quantity = 1,
  int lineTotal = 0,
}) =>
    OrderItemAddon(
      id: id,
      orderItemId: orderItemId,
      addonItemId: addonItemId,
      addonName: addonName,
      nameTranslations: const <String, dynamic>{},
      unitPrice: unitPrice,
      quantity: quantity,
      lineTotal: lineTotal,
    );

OrderItemOptional makeOrderItemOptional({
  String id = 'oio1',
  String orderItemId = 'oi1',
  String? optionalFieldId,
  String fieldName = 'Field',
  int price = 0,
  String? orgIngredientId,
  String? ingredientName,
  String? ingredientUnit,
  double? quantityDeducted,
}) =>
    OrderItemOptional(
      id: id,
      orderItemId: orderItemId,
      optionalFieldId: optionalFieldId,
      fieldName: fieldName,
      nameTranslations: const <String, dynamic>{},
      price: price,
      orgIngredientId: orgIngredientId,
      ingredientName: ingredientName,
      ingredientUnit: ingredientUnit,
      quantityDeducted: quantityDeducted,
    );

ShiftReport makeShiftReport({
  Shift? shift,
  List<PaymentSummaryItem> paymentSummary = const [],
  List<CashMovementItem> cashMovements = const [],
  int totalPayments = 0,
  int netPayments = 0,
  int cashMovementsIn = 0,
  int cashMovementsOut = 0,
  int voidedAmount = 0,
  DateTime? printedAt,
}) =>
    ShiftReport(
      shift: shift ?? makeShift(),
      paymentSummary: paymentSummary,
      cashMovements: cashMovements,
      totalPayments: totalPayments,
      netPayments: netPayments,
      cashMovementsIn: cashMovementsIn,
      cashMovementsOut: cashMovementsOut,
      cashMovementsNet: cashMovementsIn - cashMovementsOut,
      voidedAmount: voidedAmount,
      printedAt: printedAt ?? kFixtureTime,
    );

PaymentSummaryItem makePaymentSummaryItem({
  String paymentMethod = 'cash',
  bool isCash = true,
  int total = 0,
  int orderCount = 0,
}) =>
    PaymentSummaryItem(
      paymentMethod: paymentMethod,
      isCash: isCash,
      total: total,
      orderCount: orderCount,
    );

CashMovementItem makeCashMovementItem({
  int amount = 0,
  String note = '',
  String movedByName = 'Teller',
  DateTime? createdAt,
}) =>
    CashMovementItem(
      amount: amount,
      note: note,
      movedByName: movedByName,
      createdAt: createdAt ?? kFixtureTime,
    );
