# BUNDLES_POS_NOTES.md
# Sufrix POS — Bundles Implementation: Investigation Findings

_Written after reading the full codebase end-to-end. §1 answers every question from the prompt.
§2 onward contains design decisions for the implementation._

---

## §1. Investigation Findings

### 1.1 Local Data Layer

**Which local DB?**

There is **no embedded relational database** (no Drift, Isar, or SQLite). All local persistence is via `shared_preferences` (key-value store). The storage layer lives in a single class:

```
lib/core/storage/storage_service.dart  — StorageService
```

Every entity is serialised to JSON and stored under a structured key pattern:

| Key pattern                          | What it holds                       |
|--------------------------------------|-------------------------------------|
| `auth_token`                         | Bearer token string                 |
| `cached_user`                        | User JSON                           |
| `branch_{id}`                        | Branch JSON                         |
| `shift_{branchId}`                   | Active shift JSON                   |
| `menu_v2_{orgId}`                    | `{categories:[...], items:[...]}` JSON |
| `menu_cached_at_{orgId}`             | ISO-8601 timestamp of last pull     |
| `addons_{orgId}`                     | `[AddonItem...]` JSON               |
| `discounts_{orgId}`                  | `[Discount...]` JSON                |
| `orders_{shiftId}`                   | `[Order...]` JSON                   |
| `shifts_list_{branchId}`             | `[Shift...]` JSON                   |
| `inventory_{branchId}`               | `[InventoryItem...]` JSON           |
| `menu_item_{itemId}`                 | Single `MenuItem` JSON              |
| `shift_report_{shiftId}`             | `ShiftReport` JSON                  |
| `recipe_preview_{key}`               | Recipe data JSON                    |
| `offline_pending_actions_v2`         | `[PendingAction...]` JSON — the queue |
| `draft_carts_v1_{scope}`             | `[CartState...]` parked drafts      |
| `active_cart_v1_{scope}`             | Active `CartState` JSON             |

**Migration tool**: None. Versioning is baked into key names (e.g. `menu_v2_`, `offline_pending_actions_v2`, `draft_carts_v1_`). A migration is a new key with a fallback-and-copy in code (see `loadDraftCartsWithLegacyMigration`).

**Menu item columns**: MenuItem is a plain Dart class — `id, orgId, categoryId, name, description, imageUrl, basePrice, isActive, displayOrder, sizes[], addonSlots[], optionalFields[], defaultMilkAddonId, recipes[]`. No SQL columns; it's JSON.

**Indexes**: None (it's a key-value store, no query indexes). Items are filtered in-memory.

**Translated names**: **Not currently stored locally**. The app uses a single `name` string. The backend apparently returns a single language. There is no locale-switch mechanism in the Flutter app at this time (see §1.7).

---

### 1.2 Menu Rendering

**Layout**: The order screen (`lib/features/order/order_screen.dart`) is a **three-panel layout**:
1. `CategoryRail` — vertical scrollable list of category tabs on the left.
2. `MenuGrid` — responsive grid of `MenuCard` tiles (2–6 columns based on available width: `cols = (maxWidth / 160).floor().clamp(2, 6)`). Aspect ratio is ~1:1.22.
3. `CartPanel` — right-side cart (tablets) or floating FAB (phones).

**Category navigation**: `CategoryRail` lists all active categories as tappable pills. Tapping calls `menuProvider.notifier.selectCategory(id)`. `MenuState.filtered` returns items matching `selectedCategoryId`, or all items if null.

**Item images**: Loaded with `MenuImage` widget, which wraps `CachedNetworkImageProvider` + `MenuImageCacheManager` (a singleton `CacheManager` keyed `sufrix_menu_images`, stale period 365 days, max 500 objects). The `MenuNotifier.load()` calls `imageCache.warmUp(urls)` in a fire-and-forget after a fresh pull. On forced refresh (`force: true`) it calls `imageCache.invalidate()` first.

**Out-of-stock / unavailable items**: Currently **not rendered differently** — items are only filtered by `i.isActive`. There is no UI-level stock check per tile today. Bundle implementation will need to introduce this pattern.

---

### 1.3 Order Construction

**In-memory model**: `CartState` (immutable, `@immutable`) holds a `List<CartItem>`. It lives in `CartNotifier extends Notifier<CartState>`.

**`CartItem` fields**: `menuItemId, itemName, sizeLabel, unitPrice, quantity, addons: List<SelectedAddon>, optionals: List<SelectedOptional>, notes`.

**`lineTotal` computation** (inside `CartItem`):
```dart
int get addonsPrice    => addons.fold(0, (s, a) => s + a.priceModifier * a.quantity);
int get optionalsPrice => optionals.fold(0, (s, o) => s + o.price);
int get lineTotal      => (unitPrice + addonsPrice + optionalsPrice) * quantity;
```

**Modifiers/addons**: `SelectedAddon` has `addonItemId, name, priceModifier, quantity`. `SelectedOptional` has `optionalFieldId, name, price`.

**Order total** (inside `CartState`):
```dart
int get subtotal       => items.fold(0, (s, i) => s + i.lineTotal);
int get discountAmount => ...;   // percentage or fixed
int get total          => subtotal - discountAmount;
```

**No tax engine on the client.** The server returns `tax_amount` on the committed `Order`. The client does not compute tax. The client sends the raw items; the server applies tax rules and returns totals.

> **OPEN QUESTION (tax)**: For a bundle line, the client sends `bundle_unit_price`; the server computes tax. The weighted-average approach in the prompt is a server-side concern, not a client concern. The POS simply sends the bundle as an item and the server handles tax. No client change needed for tax. Flag in PR.

**Adding to cart**: `CartNotifier.add(CartItem incoming)` checks for an identical line (same `menuItemId`, `sizeLabel`, addons, optionals) and merges quantities. Otherwise appends a new row.

---

### 1.4 Order Commit & Offline Queue

**Local save**: The active `CartState` is persisted to `shared_preferences` (`saveActiveCart(scope, cart.toStorageJson())`) on every mutation via `CartNotifier._persist()`. The scope is `"${branchId}_${shiftId}"`.

**Offline queue**: `List<PendingAction>` stored at key `offline_pending_actions_v2`. The queue is a simple ordered list; actions are processed in FIFO order by `OfflineQueueNotifier.syncAll()`.

**Idempotency key**: `CartNotifier.idempotencyKey()` returns `state.id` (e.g. `"order_1"` or `"order_1747..."`). This is sent as the `Idempotency-Key` HTTP header and also stored as `PendingOrder.localId`. A 409 response is treated as success (deduplication).

**`PendingOrder` fields**: `localId, branchId, shiftId, paymentMethod, customerName, discountType, discountValue, discountId, amountTendered, tipAmount, tipPaymentMethod, paymentSplits, items: List<CartItem>, orderedAt`.

Items are serialised via `CartItem.toStorageJson()` (for persistence) and `CartItem.toApiJson()` (for the HTTP payload).

**Sync trigger**: On connectivity restored (via `ConnectivityService` stream) → `syncAll()`. Also triggered immediately after every `enqueue*` call if online.

**Conflict resolution**: 409 → dequeue (treat as success). Any other error → increment `retryCount`. After 5 retries, the action is `stuck` and shown to the user in the `SyncStatusBanner`. Teller can discard or retry stuck actions from `pending_orders_screen.dart`.

---

### 1.5 Printing

**Libraries**:
- **Star**: `starxpand_sdk_wrapper ^1.0.2` — `StarXpand.instance.connect(device, monitor: false)`, `StarXpand.instance.printPdf(pdfBytes, width: 576)`, `StarXpand.instance.disconnect()`.
- **Epson**: Raw TCP socket (no Epson SDK package) — PDF → rasterised PNG → ESC/POS bitmap command. Sent to `ip:port` via `dart:io Socket`.

**Receipt template**: **Programmatic PDF builder** using the `pdf ^3.11.1` package (`pw.*` widgets). The `PrinterService` class has `_buildReceiptPdf()` and `_buildShiftReportPdf()` as private static methods. Both build a `pw.Page` with `pw.Column` containing `_row()` helper (two-column label/value layout).

**Font**: Cairo Regular + Cairo SemiBold loaded from asset bundle (`assets/fonts/Cairo-Regular.ttf`, `Cairo-SemiBold.ttf`).

**Item rendering loop** (in `_buildReceiptPdf`):
```dart
...order.items.expand((item) {
  return [
    _row('${item.quantity}x ${item.itemName}...', egp(item.lineTotal), ...),
    ...item.addons.map((a) => _row('  + ${a.addonName}', ..., leftIndent: 4)),
    ...item.optionals.map((o) => _row('  + ${o.fieldName}', ..., leftIndent: 4)),
  ];
})
```

**RTL**: The PDF uses Cairo font (supports Arabic) but does not apply RTL directionality — all text is LTR layout. This is a current limitation. No `pw.TextDirection` is set. Bundle receipt will match this existing pattern.

**Kitchen/barista tickets**: **None exist currently.** The only print path is the customer receipt in `ReceiptSheet`. There is no separate kitchen ticket system.

---

### 1.6 State Management

**Library**: **Riverpod v2** (`flutter_riverpod ^2.6.1`) — specifically `Notifier<S>` + `NotifierProvider<N, S>` pattern. There are no `StateNotifier`, `ChangeNotifier`, or BLoC classes anywhere.

**Notifiers** (all in `lib/core/providers/`):
| Provider | State type | Role |
|---|---|---|
| `authProvider` | `AuthState` | User, branch, session expiry |
| `menuProvider` | `MenuState` | Categories, items, addons, selected category |
| `cartProvider` | `CartState` | Active order items, payment, discount |
| `draftCartsProvider` | `DraftCartsState` | Parked orders (multiple tabs) |
| `shiftProvider` | `ShiftState` | Active shift, system cash |
| `discountProvider` | `DiscountState` | Available discounts |
| `offlineQueueProvider` | `OfflineQueueState` | Pending sync actions |
| `orderHistoryProvider` | `OrderHistoryState` | Shift's completed orders |

**Pattern**: Notifiers use `state = state.copyWith(...)`. No streams exposed to UI directly — widgets use `ref.watch(provider)`. Commands are methods on the notifier: `ref.read(cartProvider.notifier).add(item)`.

---

### 1.7 Theming, i18n, RTL

**i18n**: **Not implemented.** There is no `flutter_localizations`, no `.arb` files, no `intl_utils`, no `AppLocalizations`. All strings are **hardcoded English** in the source. The `Cairo` font is used (which supports Arabic glyphs) but the app does not switch between Arabic and English at runtime.

**RTL**: The app does not set `textDirection` or use `Directionality` widgets. `MaterialApp.router` does not set `locale` or `supportedLocales`.

> **IMPLICATION FOR BUNDLES**: The prompt asks for Arabic translations. Since the app has no i18n system, "Arabic support" at this stage means:
> 1. Using the Cairo font (already done everywhere).
> 2. Keeping strings as constants that can be extracted later.
> 3. **Not** introducing a new i18n framework unless explicitly requested.
>
> The terms "Combo" / "كومبو" will be handled as conditional strings based on a locale helper (to be defined in `formatting.dart` or a new `l10n.dart` file).
>
> **Flag in PR**: Full AR/EN localisation requires a separate workstream.

**Typography**: `cairo()` helper function in `app_theme.dart` returns `GoogleFonts.cairo(...)` with configurable `fontSize, fontWeight, color, height, letterSpacing`.

---

### 1.8 Auth and Tenant Context

**Tenant context** lives in `AuthState`:
- `user.orgId` — used for all menu/discount fetches.
- `user.branchId` — used for shift, inventory, and order commits.
- `branch` — full Branch object including printer config.

**Injected into requests**: Via `DioClient` (`lib/core/api/client.dart`) which reads the auth token from `StorageService` and injects it as `Authorization: Bearer {token}`. Branch/org IDs are passed as parameters when needed (e.g. `MenuApi.items(orgId)`).

**Terminal context**: There is no `terminalId` concept in the current codebase. The device is identified by its user+branch context. Multi-terminal means multiple devices, each with their own user session, sharing the same backend and `shared_preferences` namespace (which is device-local).

---

## §2. Design Decisions for Bundles Implementation

### 2.1 Storage: No DB migration — just new SharedPreferences keys

Since there is no SQL database, "migrations" are new keys:

| New key | Content |
|---|---|
| `bundles_v1_{orgId}` | `[Bundle...]` JSON |
| `bundle_components_v1_{orgId}` | `{bundleId: [BundleComponent...]}` JSON |
| `bundle_branch_avail_v1_{orgId}` | `{bundleId: [branchId...]}` JSON |

These mirror the prompt's schema tables but as in-memory-friendly JSON blobs, consistent with the existing pattern (e.g. `menu_v2_`, `addons_`).

The cart already stores `CartItem.toStorageJson()`. Bundle cart items will use an **extended `CartItem`** with two extra fields:
- `bundleId: String?`
- `bundleComponents: List<BundleComponentSnapshot>?`

Since `CartItem` is stored and restored via JSON, adding nullable fields with default `null` is backward-compatible.

### 2.2 Menu Sync

Follow the exact pattern in `MenuRepository.fetchMenu()`:
- Try API → save → return `fromCache: false`.
- On failure → load from storage → return `fromCache: true`.

Add `fetchBundles(orgId)` to `MenuRepository` (and `MenuApi`) following the same pattern.

Bundles join `MenuState`:
```dart
class MenuState {
  // ...existing fields...
  final List<Bundle> bundles;  // NEW
}
```

And `MenuNotifier.load()` fetches bundles concurrently alongside categories and items.

### 2.3 Category Placement: Option B (inline with components' categories)

Per the prompt default. Bundles appear in the grid alongside items. The rule: **a bundle is shown in the category of its first component** (by position).

Since `MenuState.filtered` already gates items by `selectedCategoryId`, we extend `filtered` to also include bundles whose effective category matches.

The `MenuGrid` will render a mixed list of `MenuCard` (items) and `BundleCard` (bundles), sorted by `displayOrder`.

### 2.4 Bundle Tile: `BundleCard` widget

Same grid cell size as `MenuCard`. Visual distinguishers:
- Small "Combo" ribbon/chip in the top-right corner (navy `AppColors.primary` tint).
- Savings chip below price if `bundle_price < sum_of_component_base_prices`.
- Component count micro-label (e.g. "3 items").
- Same `ScaleTransition` press animation as `MenuCard`.
- Dimmed + tap-disabled if `isBundleAvailableNow()` returns false.

### 2.5 CartItem Extension for Bundles

Rather than a separate `BundleCartItem` class (which would break `CartState.items: List<CartItem>`), extend `CartItem` with:
```dart
final String?                        bundleId;
final List<BundleComponentSnapshot>? bundleComponents;
```

A line is a bundle if `bundleId != null`. All existing total/discount computation works unchanged because `lineTotal` uses `unitPrice * quantity`.

`BundleComponentSnapshot` is:
```dart
class BundleComponentSnapshot {
  final String itemId;
  final String itemName;    // snapshotted for display
  final int    quantity;    // per-bundle quantity
}
```

### 2.6 Cart Row for Bundle Lines

A bundle `CartItem` renders differently in `CartRow`:
- Components listed beneath the title with size, addons, and optionals (same chips as item lines).
- Delete removes the whole combo line.
- Quantity stepper works normally; component quantities shown as `itemName × (qty * componentQty)`.
- Tapping a combo opens `BundleDetailSheet`, which runs each configurable component through `ItemDetailSheet` (same addon/size/optional UI as standalone items).

### 2.7 Offline Queue: No change to `PendingOrder`

`PendingOrder.items` is `List<CartItem>`. Since `CartItem` gains `bundleId` and `bundleComponents`, both fields are included in `toStorageJson()` and `toApiJson()`. The bundle line is transmitted to the backend as part of the normal order payload.

The `OrderApi.create()` call passes `items.map((i) => i.toApiJson())`. Bundle-aware `toApiJson()` will include:
```json
{
  "menu_item_id": null,
  "bundle_id": "...",
  "bundle_unit_price": 4500,
  "quantity": 1,
  "bundle_components": [
    {"item_id": "...", "quantity": 1},
    {"item_id": "...", "quantity": 1}
  ]
}
```

### 2.8 Receipt Template Extension

Add a bundle-line renderer in `PrinterService._buildReceiptPdf()`:
```dart
if (item.isBundleItem) {
  // Header line: "1× Breakfast Combo" + price
  // Component sub-lines: "  - Latte", "  - Croissant", ...
}
```
Components are indented with `leftIndent: 8` and no price column, matching the existing addon-line pattern. The bundle's total is on the header line only.

### 2.9 Tax Question

The client does not compute tax. It sends items; the server returns `tax_amount`. Bundle lines are treated identically — send `bundle_unit_price`, let the server compute tax. No client change needed.

> **FLAG FOR PR**: Backend team needs to confirm whether bundle lines are taxed at a flat rate, weighted-average component rate, or zero rate. The client is agnostic.

### 2.10 Inventory / Stock Check

The existing inventory is stored at `inventory_{branchId}` as `[InventoryItem...]`. Each `InventoryItem` has `id, name, unit, currentStock`.

Items are linked to recipes via `MenuItemRecipe` (embedded on `MenuItem`). However, stock checking per-item in the menu grid **does not currently happen** — there is no per-tile stock gate today.

For bundles, a bundle tile is disabled if any component's current stock (from `loadInventory`) is insufficient, computed once per menu render from the local inventory snapshot.

> **FLAG FOR PR**: The item-level stock gate is also absent for normal items. If the team decides to add it for items too, bundles will benefit automatically.

---

## §3. File-Level Implementation Plan

### New files to create

| File | Purpose |
|---|---|
| `lib/core/models/bundle.dart` | `Bundle`, `BundleComponent`, `BundleComponentSnapshot` models |
| `lib/core/api/bundle_api.dart` | `GET /bundles?org_id=` |
| `lib/core/providers/bundle_notifier.dart` | `BundleState`, `BundleNotifier`, `bundleProvider` |
| `lib/features/order/widgets/bundle_card.dart` | Bundle tile widget |
| `lib/features/order/widgets/bundle_cart_row.dart` | Bundle line in cart |

### Files to modify

| File | Change |
|---|---|
| `lib/core/models/cart.dart` | Add `bundleId`, `bundleComponents` to `CartItem`; update `toApiJson`, `toStorageJson`, `fromStorageJson` |
| `lib/core/storage/storage_service.dart` | Add `saveBundles`, `loadBundles`, `saveBundleComponents`, etc. |
| `lib/core/api/menu_api.dart` | Add `bundles(orgId)` |
| `lib/core/repositories/menu_repository.dart` | Add `fetchBundles(orgId)` |
| `lib/core/providers/menu_notifier.dart` | Add `bundles` to `MenuState`; fetch in `load()` |
| `lib/core/providers/cart_notifier.dart` | Add `addBundle(Bundle, List<BundleComponent>)` |
| `lib/features/order/widgets/menu_grid.dart` | Render `BundleCard` tiles inline |
| `lib/features/order/widgets/cart_panel.dart` | Detect bundle lines, delegate to `BundleCartRow` |
| `lib/core/services/printer_service.dart` | Handle bundle lines in `_buildReceiptPdf` |

---

## §4. Open Questions for PR

1. **Tax rate on bundle lines**: flat/weighted/zero? Client is agnostic; backend controls it.
2. **Category placement override**: Dashboard setting for "Combos" dedicated category — future enhancement.
3. **Kitchen tickets**: There are none today. No action needed for bundles.
4. **Per-component price visibility**: Default NO — barista does not see breakdown. Flagged.
5. **Arabic term for "Combo"**: Using "كومبو" (transliterated). Confirm with dashboard team.
6. **Full i18n system**: Not in scope for this PR. Strings are English-only with Cairo font.
7. **Item-level stock gate**: Currently absent for normal items too. Bundle gate introduces the pattern; items can follow in a separate PR.

---

## §5. `isBundleAvailableNow` Predicate

```dart
/// Single source of truth: should this bundle render as tappable right now?
bool isBundleAvailableNow(Bundle b, String branchId, DateTime now) {
  // Status gate
  if (b.status != BundleStatus.active) return false;

  // Branch availability (empty list = available everywhere)
  if (b.branchAvailability.isNotEmpty &&
      !b.branchAvailability.contains(branchId)) return false;

  // Date window (nullable = unbounded)
  final today = DateTime(now.year, now.month, now.day);
  if (b.availableFromDate != null &&
      today.isBefore(b.availableFromDate!)) return false;
  if (b.availableUntilDate != null &&
      today.isAfter(b.availableUntilDate!)) return false;

  // Time window (nullable = unbounded)
  final nowMinutes = now.hour * 60 + now.minute;
  if (b.availableFromMinutes != null &&
      nowMinutes < b.availableFromMinutes!) return false;
  if (b.availableUntilMinutes != null &&
      nowMinutes > b.availableUntilMinutes!) return false;

  return true;
}
```

Time windows are stored as integer minutes-since-midnight to avoid `TimeOfDay` comparison complexity.
This function is called once during menu grid build, not per-tile.

---

## §6. Stock Gate Predicate

```dart
/// Returns null if bundle is in stock; otherwise returns the name of
/// the first out-of-stock component (for the disabled tile hint message).
String? bundleOutOfStockReason(
  Bundle bundle,
  List<MenuItem> menuItems,
  List<InventoryItem> inventory,
) {
  final invMap = {for (final i in inventory) i.id: i.currentStock};

  for (final comp in bundle.components) {
    final item = menuItems.firstWhereOrNull((m) => m.id == comp.itemId);
    if (item == null) continue;  // item not in local cache — allow

    for (final recipe in item.recipes) {
      if (recipe.orgIngredientId == null) continue;
      final stock = invMap[recipe.orgIngredientId] ?? double.infinity;
      final needed = recipe.quantityUsed * comp.quantity;
      if (stock < needed) return item.name;  // e.g. "Croissant"
    }
  }
  return null;  // all components in stock
}
```

---

_End of investigation notes._
