#!/usr/bin/env bash
# =============================================================================
#  RuePOS Flutter — Full Offline Support (complete version)
#
#  Every screen now works offline:
#
#  Home screen
#    - Shift loaded from cache (status, opening cash, teller name)
#    - Order count + sales total computed from cached orders
#    - System cash computed from cached orders + cached cash movements
#    - Offline banner shown inside the shift card
#    - Close Shift disabled with message when no internet
#
#  Order screen (new orders)
#    - Menu served from cache when offline
#    - Offline queue: orders saved locally, synced when online
#    - Offline/sync banners shown at top
#
#  Order History screen
#    - Orders list cached per shift
#    - Individual order detail cached
#
#  Shift History screen
#    - Shift list cached per branch
#    - Orders within each shift cached
#
#  Close Shift screen
#    - Inventory counts loaded from cache
#    - System cash computed from cache
#    - Submit disabled with message when no internet
#
#  Open Shift screen
#    - Disabled with message when no internet (must be online to create shift)
#
#  Files written (full replace):
#    lib/core/api/order_api.dart             individual order caching
#    lib/core/api/shift_api.dart             shift list + cash movements caching
#    lib/core/api/inventory_api.dart         inventory items caching
#    lib/core/providers/shift_provider.dart  persist shift to prefs
#    lib/core/providers/order_history_provider.dart  persist orders list
#
#  Files patched:
#    lib/features/home/home_screen.dart      offline banner + close guard
#    lib/features/shift/open_shift_screen.dart  open guard
#    lib/features/shift/close_shift_screen.dart  close guard
#    lib/features/order/order_screen.dart    banner + queue (from fix_offline.sh)
#
#  Note: Run fix_offline.sh FIRST (menu caching + main.dart wiring),
#        then run this script. Or run this script alone — it includes
#        everything fix_offline.sh does plus the additional screens.
#
#  Usage:  bash fix_offline_complete.sh [path/to/flutter/project]
#  Default: current directory (.)
# =============================================================================
set -e
PROJ="${1:-.}"
[ -d "$PROJ" ] || { echo "ERROR: not found: $PROJ"; exit 1; }
echo "==> Applying full offline support to: $(cd "$PROJ" && pwd)"

write() {
  local dest="$PROJ/$1"
  mkdir -p "$(dirname "$dest")"
  cat > "$dest"
  echo "  written: $1"
}

PATCHES_DIR="$(dirname "$0")/offline_complete_patches"
mkdir -p "$PATCHES_DIR"

cat > "$PATCHES_DIR/patch_home_screen.py" << 'PY_EOF'
#!/usr/bin/env python3
"""
Patches home_screen.dart:
  - Shows cached banner when shift loaded from cache
  - Disables Open/Close shift buttons with message when offline
"""
import sys

path = sys.argv[1]
with open(path, 'r') as f:
    src = f.read()

changed = []

# Add OfflineSyncService import
imp = "import '../../core/services/offline_sync_service.dart';"
if imp not in src:
    src = src.replace(
        "import '../../shared/widgets/card_container.dart';",
        "import '../../shared/widgets/card_container.dart';\n" + imp,
    )
    changed.append('import')

# Add fromCache banner to _OpenShiftView — show "Offline mode" strip
# Insert after the _OpenShiftView build() return Column, right after the first boxShadow block
old_status_row = '''          // Status row
          Row(children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.18),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Container(
                  width: 7,
                  height: 7,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4ADE80),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text('SHIFT OPEN','''

new_status_row = '''          // Offline cache banner
          Builder(builder: (ctx) {
            final sync = ctx.watch<OfflineSyncService>();
            if (!sync.isOnline) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(children: [
                  const Icon(Icons.wifi_off_rounded, size: 13, color: Colors.white70),
                  const SizedBox(width: 8),
                  Expanded(child: Text(
                    'Offline — showing cached data. New orders will sync when connected.',
                    style: cairo(fontSize: 11, color: Colors.white70),
                  )),
                ]),
              );
            }
            return const SizedBox.shrink();
          }),
          // Status row
          Row(children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.18),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Container(
                  width: 7,
                  height: 7,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4ADE80),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text('SHIFT OPEN','''

if old_status_row in src:
    src = src.replace(old_status_row, new_status_row)
    changed.append('offline-banner')

# Disable Close Shift button when offline — wrap _confirmClose call
old_close_btn = '''            Expanded(
                child: _CardBtn(
              label: 'Close',
              icon: Icons.lock_outline_rounded,
              onTap: () => _confirmClose(context),
              danger: true,
              isTablet: isTablet,
            )),'''

new_close_btn = '''            Builder(builder: (bCtx) {
              final offline = !bCtx.watch<OfflineSyncService>().isOnline;
              return Expanded(
                child: _CardBtn(
                  label: 'Close',
                  icon: Icons.lock_outline_rounded,
                  onTap: offline
                      ? () => ScaffoldMessenger.of(bCtx).showSnackBar(
                          const SnackBar(
                            content: Text('Internet required to close shift'),
                            backgroundColor: Color(0xFF856404),
                          ))
                      : () => _confirmClose(bCtx),
                  danger: true,
                  isTablet: isTablet,
                ),
              );
            }),'''

if old_close_btn in src:
    src = src.replace(old_close_btn, new_close_btn)
    changed.append('close-offline-guard')

with open(path, 'w') as f:
    f.write(src)

print(f"  patched: {', '.join(changed) if changed else 'nothing matched'}")

PY_EOF

cat > "$PATCHES_DIR/patch_open_shift.py" << 'PY_EOF'
#!/usr/bin/env python3
"""
Patches open_shift_screen.dart:
  Shows disabled state + message when offline (opening shift requires internet).
"""
import sys

path = sys.argv[1]
with open(path, 'r') as f:
    src = f.read()

changed = []

imp = "import '../../core/services/offline_sync_service.dart';"
if imp not in src:
    src = src.replace(
        "import 'package:google_fonts/google_fonts.dart';",
        "import 'package:google_fonts/google_fonts.dart';\n" + imp,
    )
    changed.append('import')

# Wrap the AppButton in a Builder that checks connectivity
old_btn = '''                  AppButton(
                    label: 'Open Shift',
                    loading: _loading,
                    width: double.infinity,
                    icon: Icons.play_arrow_rounded,
                    onTap: _open,
                  ),'''

new_btn = '''                  Builder(builder: (bCtx) {
                    final offline = !bCtx.watch<OfflineSyncService>().isOnline;
                    return Column(children: [
                      if (offline)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF3CD),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: const Color(0xFFFFD700)),
                            ),
                            child: Row(children: [
                              const Icon(Icons.wifi_off_rounded,
                                  size: 14, color: Color(0xFF856404)),
                              const SizedBox(width: 8),
                              Expanded(child: Text(
                                'Internet required to open a shift.',
                                style: cairo(fontSize: 12,
                                    color: const Color(0xFF856404)),
                              )),
                            ]),
                          ),
                        ),
                      AppButton(
                        label: 'Open Shift',
                        loading: _loading,
                        width: double.infinity,
                        icon: Icons.play_arrow_rounded,
                        onTap: offline ? null : _open,
                      ),
                    ]);
                  }),'''

if old_btn in src:
    src = src.replace(old_btn, new_btn)
    changed.append('open-offline-guard')

with open(path, 'w') as f:
    f.write(src)
print(f"  patched: {', '.join(changed) if changed else 'nothing matched'}")

PY_EOF

cat > "$PATCHES_DIR/patch_close_shift.py" << 'PY_EOF'
#!/usr/bin/env python3
"""
Patches close_shift_screen.dart:
  Disables the Close Shift button with a message when offline.
"""
import sys

path = sys.argv[1]
with open(path, 'r') as f:
    src = f.read()

changed = []

imp = "import '../../core/services/offline_sync_service.dart';"
if imp not in src:
    src = src.replace(
        "import '../../shared/widgets/label_value.dart';",
        "import '../../shared/widgets/label_value.dart';\n" + imp,
    )
    changed.append('import')

old_btn = '''          AppButton(
            label: 'Close Shift',
            variant: BtnVariant.danger,
            loading: state._submitting,
            width: double.infinity,
            icon: Icons.lock_outline_rounded,
            onTap: state._close,
          ),'''

new_btn = '''          Builder(builder: (bCtx) {
            final offline = !bCtx.watch<OfflineSyncService>().isOnline;
            return Column(children: [
              if (offline)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF3CD),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFFFD700)),
                    ),
                    child: Row(children: [
                      const Icon(Icons.wifi_off_rounded,
                          size: 14, color: Color(0xFF856404)),
                      const SizedBox(width: 8),
                      Expanded(child: Text(
                        'Internet required to close a shift.',
                        style: cairo(fontSize: 12,
                            color: const Color(0xFF856404)),
                      )),
                    ]),
                  ),
                ),
              AppButton(
                label: 'Close Shift',
                variant: BtnVariant.danger,
                loading: state._submitting,
                width: double.infinity,
                icon: Icons.lock_outline_rounded,
                onTap: offline ? null : state._close,
              ),
            ]);
          }),'''

if old_btn in src:
    src = src.replace(old_btn, new_btn)
    changed.append('close-offline-guard')

with open(path, 'w') as f:
    f.write(src)
print(f"  patched: {', '.join(changed) if changed else 'nothing matched'}")

PY_EOF

cat > "$PATCHES_DIR/patch_order_screen.py" << 'PY_EOF'
#!/usr/bin/env python3
"""
Patches lib/features/order/order_screen.dart:
  1. Adds imports for OfflineSyncService and PendingOrder
  2. Adds offline/sync banner to _TopBar
  3. Wires offline queue into CheckoutSheet._place()
"""
import sys

path = sys.argv[1]
with open(path, 'r') as f:
    src = f.read()

changed = []

# ── 1. Imports ─────────────────────────────────────────────────────────────────
for imp in [
    "import '../../core/services/offline_sync_service.dart';",
    "import '../../core/models/pending_order.dart';",
]:
    if imp not in src:
        src = src.replace(
            "import '../../shared/widgets/label_value.dart';",
            "import '../../shared/widgets/label_value.dart';\n" + imp,
        )
        changed.append('imports')

# ── 2. Offline banner in _TopBar.build() ───────────────────────────────────────
# Inject connectivity watch + banner wrapping BEFORE the Container return
OLD_TOPBAR = """  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(12, 10, 16, 10),"""

NEW_TOPBAR = """  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final sync = context.watch<OfflineSyncService>();

    final Widget bar = Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(12, 10, 16, 10),"""

if OLD_TOPBAR in src:
    src = src.replace(OLD_TOPBAR, NEW_TOPBAR)
    changed.append('topbar-start')

# Close the _TopBar build() by finding its closing brace just before _CategoryRail
# Replace the final "return Container(" result with the banner wrapper
OLD_TOPBAR_CLOSE = """      ]),
    );
  }
}

// ── Category Rail"""

NEW_TOPBAR_CLOSE = """      ]),
    );

    if (!sync.isOnline || sync.count > 0) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          bar,
          if (!sync.isOnline)
            Container(
              width: double.infinity,
              color: const Color(0xFFFFF3CD),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              child: Row(children: [
                const Icon(Icons.wifi_off_rounded, size: 13,
                    color: Color(0xFF856404)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Offline \u2014 cached menu. Orders saved & synced when online.',
                    style: cairo(fontSize: 11, color: const Color(0xFF856404)),
                  ),
                ),
              ]),
            ),
          if (sync.isOnline && sync.count > 0)
            Container(
              width: double.infinity,
              color: const Color(0xFFCFE2FF),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              child: Row(children: [
                const SizedBox(
                  width: 10, height: 10,
                  child: CircularProgressIndicator(
                      strokeWidth: 1.5, color: Color(0xFF084298)),
                ),
                const SizedBox(width: 8),
                Text(
                  'Syncing ${sync.count} offline order${sync.count == 1 ? "" : "s"}\u2026',
                  style: cairo(fontSize: 11, color: const Color(0xFF084298)),
                ),
              ]),
            ),
        ],
      );
    }
    return bar;
  }
}

// \u2500\u2500 Category Rail"""

if OLD_TOPBAR_CLOSE in src:
    src = src.replace(OLD_TOPBAR_CLOSE, NEW_TOPBAR_CLOSE)
    changed.append('topbar-banner')

# ── 3. Replace _place() ────────────────────────────────────────────────────────
OLD_PLACE = """  Future<void> _place() async {
    final cart  = context.read<CartProvider>();
    final shift = context.read<ShiftProvider>().shift;
    if (shift == null) { setState(() => _error = 'No open shift'); return; }
    final customer = _customerCtrl.text.trim().isEmpty ? null : _customerCtrl.text.trim();
    setState(() { _loading = true; _error = null; });
    try {
      final order = await orderApi.create(
        branchId:      shift.branchId,
        shiftId:       shift.id,
        paymentMethod: cart.payment,
        items:         cart.items.toList(),
        customerName:  customer,
        discountType:  cart.discountTypeStr,
        discountValue: cart.discountValue,
      );
      context.read<OrderHistoryProvider>().addOrder(order);
      final total = cart.total;
      cart.clear();
      if (mounted) {
        Navigator.pop(context);
        // Show receipt sheet, which handles print
        ReceiptSheet.show(context, order: order, total: total);
      }
    } catch (e) {
      if (e is DioException)
        debugPrint('ORDER ${e.response?.statusCode}: ${e.response?.data}');
      setState(() { _error = 'Failed to place order \u2014 please retry'; _loading = false; });
    }
  }"""

NEW_PLACE = """  Future<void> _place() async {
    final cart  = context.read<CartProvider>();
    final shift = context.read<ShiftProvider>().shift;
    if (shift == null) { setState(() => _error = 'No open shift'); return; }
    final customer = _customerCtrl.text.trim().isEmpty
        ? null : _customerCtrl.text.trim();
    setState(() { _loading = true; _error = null; });
    try {
      final order = await orderApi.create(
        branchId:      shift.branchId,
        shiftId:       shift.id,
        paymentMethod: cart.payment,
        items:         cart.items.toList(),
        customerName:  customer,
        discountType:  cart.discountTypeStr,
        discountValue: cart.discountValue,
      );
      context.read<OrderHistoryProvider>().addOrder(order);
      final total = cart.total;
      cart.clear();
      if (mounted) {
        Navigator.pop(context);
        ReceiptSheet.show(context, order: order, total: total);
      }
    } on DioException catch (e) {
      // Network error \u2014 save to offline queue
      final isOffline = e.response == null ||
          e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout;

      if (isOffline) {
        final localId =
            '\${DateTime.now().millisecondsSinceEpoch}_\${shift.id.substring(0, 8)}';
        await offlineSyncService.savePending(PendingOrder(
          localId:       localId,
          branchId:      shift.branchId,
          shiftId:       shift.id,
          paymentMethod: cart.payment,
          items:         cart.items.toList(),
          customerName:  customer,
          discountType:  cart.discountTypeStr,
          discountValue: cart.discountValue,
          createdAt:     DateTime.now(),
        ));
        cart.clear();
        if (mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'No connection \u2014 order saved. Will sync automatically when online.'),
            backgroundColor: Color(0xFF856404),
            duration: Duration(seconds: 4),
          ));
        }
      } else {
        debugPrint('ORDER \${e.response?.statusCode}: \${e.response?.data}');
        setState(() {
          _error   = 'Server error \u2014 please retry';
          _loading = false;
        });
      }
    } catch (e) {
      setState(() { _error = 'Failed to place order \u2014 please retry'; _loading = false; });
    }
  }"""

if OLD_PLACE in src:
    src = src.replace(OLD_PLACE, NEW_PLACE)
    changed.append('place-method')
else:
    print("  WARN: _place() exact text not matched")
    print("        Manual wiring needed — see patch_order_screen.py")

with open(path, 'w') as f:
    f.write(src)

print(f"  patched: {', '.join(changed) if changed else 'nothing matched'}")
print(f"  saved: {path}")

PY_EOF

# ────────────────────────────────────────────────────────────────────────
# lib/core/api/order_api.dart
# ────────────────────────────────────────────────────────────────────────
write 'lib/core/api/order_api.dart' << 'DART_EOF'
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'client.dart';
import '../models/order.dart';

class OrderApi {
  Future<Order> create({
    required String branchId,
    required String shiftId,
    required String paymentMethod,
    required List<CartItem> items,
    String? customerName,
    String? discountType,
    int?    discountValue,
  }) async {
    final res = await dio.post('/orders', data: {
      'branch_id':      branchId,
      'shift_id':       shiftId,
      'payment_method': paymentMethod,
      'customer_name':  customerName,
      'discount_type':  discountType,
      'discount_value': discountValue,
      'items':          items.map((i) => i.toJson()).toList(),
    });
    return Order.fromJson(res.data as Map<String, dynamic>);
  }

  Future<List<Order>> list({String? shiftId, String? branchId}) async {
    final params = <String, dynamic>{};
    if (shiftId  != null) params['shift_id']  = shiftId;
    if (branchId != null) params['branch_id'] = branchId;
    final res = await dio.get('/orders', queryParameters: params);
    return (res.data as List).map((o) => Order.fromJson(o)).toList();
  }

  /// Fetch a single order. Caches result; serves cache when offline.
  Future<Order> get(String id) async {
    try {
      final res   = await dio.get('/orders/$id');
      final order = Order.fromJson(res.data as Map<String, dynamic>);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('order_$id', jsonEncode(_orderToJson(order)));
      return order;
    } catch (_) {
      final prefs  = await SharedPreferences.getInstance();
      final cached = prefs.getString('order_$id');
      if (cached != null) {
        return Order.fromJson(jsonDecode(cached) as Map<String, dynamic>);
      }
      rethrow;
    }
  }

  /// Void an order.
  Future<Order> voidOrder(String id, {String? reason, bool restoreInventory = false}) async {
    final res = await dio.post('/orders/$id/void', data: {
      'reason':            reason,
      'restore_inventory': restoreInventory,
    });
    return Order.fromJson(res.data as Map<String, dynamic>);
  }

  Map<String, dynamic> _orderToJson(Order o) => {
    'id':             o.id,
    'branch_id':      o.branchId,
    'shift_id':       o.shiftId,
    'teller_id':      o.tellerId,
    'teller_name':    o.tellerName,
    'order_number':   o.orderNumber,
    'status':         o.status,
    'payment_method': o.paymentMethod,
    'subtotal':       o.subtotal,
    'discount_type':  o.discountType,
    'discount_value': o.discountValue,
    'discount_amount':o.discountAmount,
    'tax_amount':     o.taxAmount,
    'total_amount':   o.totalAmount,
    'customer_name':  o.customerName,
    'notes':          o.notes,
    'created_at':     o.createdAt.toIso8601String(),
    'items': o.items.map((i) => {
      'id':         i.id,
      'item_name':  i.itemName,
      'size_label': i.sizeLabel,
      'unit_price': i.unitPrice,
      'quantity':   i.quantity,
      'line_total': i.lineTotal,
      'addons': i.addons.map((a) => {
        'id':         a.id,
        'addon_name': a.addonName,
        'unit_price': a.unitPrice,
        'quantity':   a.quantity,
        'line_total': a.lineTotal,
      }).toList(),
    }).toList(),
  };
}

final orderApi = OrderApi();

DART_EOF

# ────────────────────────────────────────────────────────────────────────
# lib/core/api/shift_api.dart
# ────────────────────────────────────────────────────────────────────────
write 'lib/core/api/shift_api.dart' << 'DART_EOF'
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'client.dart';
import '../models/shift.dart';

class ShiftApi {
  Future<ShiftPreFill> current(String branchId) async {
    final res = await dio.get('/shifts/branches/$branchId/current');
    return ShiftPreFill.fromJson(res.data as Map<String, dynamic>);
  }

  /// List all shifts for a branch. Caches result; serves cache offline.
  Future<List<Shift>> list(String branchId) async {
    try {
      final res    = await dio.get('/shifts/branches/$branchId');
      final shifts = (res.data as List).map((s) => Shift.fromJson(s)).toList();
      final prefs  = await SharedPreferences.getInstance();
      await prefs.setString('shift_list_$branchId',
          jsonEncode(shifts.map(_shiftToJson).toList()));
      return shifts;
    } catch (_) {
      final prefs  = await SharedPreferences.getInstance();
      final raw    = prefs.getString('shift_list_$branchId');
      if (raw != null) {
        return (jsonDecode(raw) as List)
            .map((s) => Shift.fromJson(s as Map<String, dynamic>))
            .toList();
      }
      rethrow;
    }
  }

  Future<Shift> open(String branchId, int openingCash) async {
    final res = await dio.post('/shifts/branches/$branchId/open',
        data: {'opening_cash': openingCash});
    return Shift.fromJson(res.data as Map<String, dynamic>);
  }

  Future<Shift> close(String shiftId, {
    required int closingCash, String? note,
    required List<Map<String, dynamic>> inventoryCounts,
  }) async {
    final res = await dio.post('/shifts/$shiftId/close', data: {
      'closing_cash_declared': closingCash,
      'cash_note':             note,
      'inventory_counts':      inventoryCounts,
    });
    final body = res.data as Map<String, dynamic>;
    return Shift.fromJson(body['shift'] as Map<String, dynamic>);
  }

  /// Compute system cash. Tries live API; falls back to cached orders.
  Future<int> getSystemCash(String shiftId, int openingCash) async {
    final ordersData = await _fetchOrCacheOrders(shiftId);
    final cashFromOrders = ordersData
        .where((o) => o['payment_method'] == 'cash' &&
            o['status'] != 'voided' && o['status'] != 'refunded')
        .fold<int>(0, (s, o) => s + (o['total_amount'] as int));

    int cashMovements = 0;
    try {
      final movRes = await dio.get('/shifts/$shiftId/cash-movements');
      final movements = movRes.data as List;
      cashMovements = movements.fold<int>(0, (s, m) => s + (m['amount'] as int));
      // Cache movements
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('cash_movements_$shiftId', jsonEncode(movements));
    } catch (_) {
      // Try cached movements
      try {
        final prefs = await SharedPreferences.getInstance();
        final raw   = prefs.getString('cash_movements_$shiftId');
        if (raw != null) {
          final movements = jsonDecode(raw) as List;
          cashMovements = movements.fold<int>(0, (s, m) => s + (m['amount'] as int));
        }
      } catch (_) {}
    }
    return openingCash + cashFromOrders + cashMovements;
  }

  Future<List<Map<String, dynamic>>> _fetchOrCacheOrders(String shiftId) async {
    try {
      final res = await dio.get('/orders', queryParameters: {'shift_id': shiftId});
      final orders = (res.data as List).cast<Map<String, dynamic>>();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('raw_orders_$shiftId', jsonEncode(orders));
      return orders;
    } catch (_) {
      final prefs = await SharedPreferences.getInstance();
      final raw   = prefs.getString('raw_orders_$shiftId');
      if (raw != null) return (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
      return [];
    }
  }

  Map<String, dynamic> _shiftToJson(Shift s) => {
    'id': s.id, 'branch_id': s.branchId, 'teller_id': s.tellerId,
    'teller_name': s.tellerName, 'status': s.status,
    'opening_cash': s.openingCash,
    'closing_cash_declared': s.closingCashDeclared,
    'closing_cash_system':   s.closingCashSystem,
    'cash_discrepancy':      s.cashDiscrepancy,
    'opened_at':  s.openedAt.toIso8601String(),
    'closed_at':  s.closedAt?.toIso8601String(),
  };
}

final shiftApi = ShiftApi();

DART_EOF

# ────────────────────────────────────────────────────────────────────────
# lib/core/api/inventory_api.dart
# ────────────────────────────────────────────────────────────────────────
write 'lib/core/api/inventory_api.dart' << 'DART_EOF'
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'client.dart';
import '../models/inventory.dart';

class InventoryApi {
  /// Fetch inventory items for a branch. Caches; serves cache offline.
  Future<List<InventoryItem>> items(String branchId) async {
    try {
      final res   = await dio.get('/inventory/branches/$branchId/items');
      final items = (res.data as List).map((i) => InventoryItem.fromJson(i)).toList();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('inventory_$branchId',
          jsonEncode(items.map((i) => {
            'id': i.id, 'name': i.name,
            'unit': i.unit, 'current_stock': i.currentStock,
          }).toList()));
      return items;
    } catch (_) {
      final prefs  = await SharedPreferences.getInstance();
      final raw    = prefs.getString('inventory_$branchId');
      if (raw != null) {
        return (jsonDecode(raw) as List)
            .map((i) => InventoryItem.fromJson(i as Map<String, dynamic>))
            .toList();
      }
      rethrow;
    }
  }
}

final inventoryApi = InventoryApi();

DART_EOF

# ────────────────────────────────────────────────────────────────────────
# lib/core/providers/shift_provider.dart
# ────────────────────────────────────────────────────────────────────────
write 'lib/core/providers/shift_provider.dart' << 'DART_EOF'
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/shift.dart';
import '../api/shift_api.dart';

class ShiftProvider extends ChangeNotifier {
  Shift?        _shift;
  ShiftPreFill? _preFill;
  bool          _loading   = false;
  String?       _error;
  bool          _fromCache = false;

  Shift?        get shift      => _shift;
  ShiftPreFill? get preFill    => _preFill;
  bool          get loading    => _loading;
  String?       get error      => _error;
  bool          get hasOpen    => _shift?.isOpen ?? false;
  bool          get fromCache  => _fromCache;

  Future<void> load(String branchId) async {
    _set(true);
    try {
      _preFill    = await shiftApi.current(branchId);
      _shift      = _preFill?.openShift;
      _error      = null;
      _fromCache  = false;
      if (_shift != null) await _saveShift(_shift!);
    } catch (_) {
      // Try cache
      final cached = await _loadShift(branchId);
      if (cached != null) {
        _shift     = cached;
        _fromCache = true;
        _error     = null;
      } else {
        _error = 'Could not load shift — check connection';
      }
    }
    _set(false);
  }

  Future<bool> openShift(String branchId, int openingCash) async {
    _set(true);
    try {
      _shift     = await shiftApi.open(branchId, openingCash);
      _error     = null;
      _fromCache = false;
      await _saveShift(_shift!);
      _set(false);
      return true;
    } catch (e) {
      _error = _friendly(e);
      _set(false);
      return false;
    }
  }

  Future<bool> closeShift({
    required int closingCash,
    String? note,
    required List<Map<String, dynamic>> inventoryCounts,
  }) async {
    if (_shift == null) return false;
    _set(true);
    try {
      _shift     = await shiftApi.close(
        _shift!.id,
        closingCash: closingCash, note: note,
        inventoryCounts: inventoryCounts,
      );
      _error     = null;
      _fromCache = false;
      // Clear cached shift since it's now closed
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('shift_${_shift!.branchId}');
      _set(false);
      return true;
    } catch (e) {
      _error = _friendly(e);
      _set(false);
      return false;
    }
  }

  // ── Persistence ──────────────────────────────────────────────────────────
  Future<void> _saveShift(Shift s) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('shift_${s.branchId}', _shiftToJson(s));
    } catch (_) {}
  }

  Future<Shift?> _loadShift(String branchId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw   = prefs.getString('shift_$branchId');
      if (raw == null) return null;
      return _shiftFromJson(raw);
    } catch (_) { return null; }
  }

  String _shiftToJson(Shift s) => jsonEncode({
    'id':                    s.id,
    'branch_id':             s.branchId,
    'teller_id':             s.tellerId,
    'teller_name':           s.tellerName,
    'status':                s.status,
    'opening_cash':          s.openingCash,
    'closing_cash_declared': s.closingCashDeclared,
    'closing_cash_system':   s.closingCashSystem,
    'cash_discrepancy':      s.cashDiscrepancy,
    'opened_at':             s.openedAt.toIso8601String(),
    'closed_at':             s.closedAt?.toIso8601String(),
  });

  Shift _shiftFromJson(String raw) {
    final j = jsonDecode(raw) as Map<String, dynamic>;
    return Shift(
      id:                  j['id'],
      branchId:            j['branch_id'],
      tellerId:            j['teller_id'],
      tellerName:          j['teller_name'],
      status:              j['status'],
      openingCash:         j['opening_cash'],
      closingCashDeclared: j['closing_cash_declared'],
      closingCashSystem:   j['closing_cash_system'],
      cashDiscrepancy:     j['cash_discrepancy'],
      openedAt:            DateTime.parse(j['opened_at']),
      closedAt:            j['closed_at'] != null
          ? DateTime.parse(j['closed_at']) : null,
    );
  }

  void _set(bool v) { _loading = v; notifyListeners(); }

  String _friendly(Object e) {
    final s = e.toString();
    if (s.contains('401')) return 'Session expired — please sign in again';
    if (s.contains('409')) return 'A shift is already open for this branch';
    if (s.contains('404')) return 'Shift not found';
    return 'Something went wrong — please try again';
  }
}

DART_EOF

# ────────────────────────────────────────────────────────────────────────
# lib/core/providers/order_history_provider.dart
# ────────────────────────────────────────────────────────────────────────
write 'lib/core/providers/order_history_provider.dart' << 'DART_EOF'
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/order.dart';
import '../api/order_api.dart';

class OrderHistoryProvider extends ChangeNotifier {
  List<Order> _orders    = [];
  bool        _loading   = false;
  String?     _error;
  String?     _shiftId;
  bool        _fromCache = false;

  List<Order> get orders    => _orders;
  bool        get loading   => _loading;
  String?     get error     => _error;
  bool        get fromCache => _fromCache;

  Future<void> loadForShift(String shiftId) async {
    if (_shiftId == shiftId && _orders.isNotEmpty) return;
    _loading   = true;
    _fromCache = false;
    _error     = null;
    notifyListeners();
    try {
      _orders   = await orderApi.list(shiftId: shiftId);
      _shiftId  = shiftId;
      _fromCache = false;
      await _saveOrders(shiftId, _orders);
    } catch (_) {
      final cached = await _loadOrders(shiftId);
      if (cached != null) {
        _orders    = cached;
        _shiftId   = shiftId;
        _fromCache = true;
      } else {
        _error = 'Could not load orders — check connection';
      }
    }
    _loading = false;
    notifyListeners();
  }

  void refresh(String shiftId) {
    _shiftId = null;
    loadForShift(shiftId);
  }

  void addOrder(Order o) {
    _orders.insert(0, o);
    notifyListeners();
    if (_shiftId != null) _saveOrders(_shiftId!, _orders);
  }

  // Called by OfflineSyncService after a pending order syncs successfully
  void onOrderSynced(Order o) => addOrder(o);

  // ── Persistence ──────────────────────────────────────────────────────────
  static String _key(String shiftId) => 'orders_$shiftId';

  Future<void> _saveOrders(String shiftId, List<Order> orders) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          _key(shiftId), jsonEncode(orders.map(_orderToJson).toList()));
    } catch (_) {}
  }

  Future<List<Order>?> _loadOrders(String shiftId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw   = prefs.getString(_key(shiftId));
      if (raw == null) return null;
      return (jsonDecode(raw) as List)
          .map((o) => Order.fromJson(o as Map<String, dynamic>))
          .toList();
    } catch (_) { return null; }
  }

  Map<String, dynamic> _orderToJson(Order o) => {
    'id':             o.id,
    'branch_id':      o.branchId,
    'shift_id':       o.shiftId,
    'teller_id':      o.tellerId,
    'teller_name':    o.tellerName,
    'order_number':   o.orderNumber,
    'status':         o.status,
    'payment_method': o.paymentMethod,
    'subtotal':       o.subtotal,
    'discount_type':  o.discountType,
    'discount_value': o.discountValue,
    'discount_amount':o.discountAmount,
    'tax_amount':     o.taxAmount,
    'total_amount':   o.totalAmount,
    'customer_name':  o.customerName,
    'notes':          o.notes,
    'created_at':     o.createdAt.toIso8601String(),
    'items': o.items.map((i) => {
      'id':         i.id,
      'item_name':  i.itemName,
      'size_label': i.sizeLabel,
      'unit_price': i.unitPrice,
      'quantity':   i.quantity,
      'line_total': i.lineTotal,
      'addons': i.addons.map((a) => {
        'id':         a.id,
        'addon_name': a.addonName,
        'unit_price': a.unitPrice,
        'quantity':   a.quantity,
        'line_total': a.lineTotal,
      }).toList(),
    }).toList(),
  };
}

DART_EOF

# ────────────────────────────────────────────────────────────────────────
# lib/core/models/menu.dart
# ────────────────────────────────────────────────────────────────────────
write 'lib/core/models/menu.dart' << 'DART_EOF'
class Category {
  final String  id;
  final String  name;
  final String? imageUrl;
  final int     displayOrder;
  final bool    isActive;

  const Category({required this.id, required this.name, this.imageUrl,
      required this.displayOrder, required this.isActive});

  factory Category.fromJson(Map<String, dynamic> j) => Category(
        id: j['id'], name: j['name'], imageUrl: j['image_url'],
        displayOrder: j['display_order'], isActive: j['is_active']);

  Map<String, dynamic> toJson() => {
        'id': id, 'name': name, 'image_url': imageUrl,
        'display_order': displayOrder, 'is_active': isActive};
}

class ItemSize {
  final String id;
  final String label;
  final int    price;
  const ItemSize({required this.id, required this.label, required this.price});

  factory ItemSize.fromJson(Map<String, dynamic> j) =>
      ItemSize(id: j['id'], label: j['label'], price: j['price_override'] ?? 0);

  Map<String, dynamic> toJson() =>
      {'id': id, 'label': label, 'price_override': price};
}

class DrinkOptionItem {
  final String id;
  final String addonItemId;
  final String name;
  final int    price;
  const DrinkOptionItem({required this.id, required this.addonItemId,
      required this.name, required this.price});

  factory DrinkOptionItem.fromJson(Map<String, dynamic> j) => DrinkOptionItem(
        id: j['id'], addonItemId: j['addon_item_id'], name: j['name'],
        price: (j['price_override'] ?? j['default_price'] ?? 0) as int);

  Map<String, dynamic> toJson() => {
        'id': id, 'addon_item_id': addonItemId, 'name': name,
        'price_override': price, 'default_price': price};
}

class DrinkOptionGroup {
  final String                id;
  final String                groupType;
  final bool                  isRequired;
  final bool                  isMultiSelect;
  final List<DrinkOptionItem> items;

  String get displayName => groupType
      .replaceAll('_', ' ').split(' ')
      .map((w) => w.isEmpty ? '' : w[0].toUpperCase() + w.substring(1))
      .join(' ');

  const DrinkOptionGroup({required this.id, required this.groupType,
      required this.isRequired, required this.isMultiSelect, required this.items});

  factory DrinkOptionGroup.fromJson(Map<String, dynamic> j) => DrinkOptionGroup(
        id: j['id'], groupType: j['group_type'] ?? '',
        isRequired:    (j['is_required']   ?? false) as bool,
        isMultiSelect: (j['selection_type'] ?? 'single') == 'multi',
        items: (j['items'] as List? ?? [])
            .map((i) => DrinkOptionItem.fromJson(i)).toList());

  Map<String, dynamic> toJson() => {
        'id': id, 'group_type': groupType, 'is_required': isRequired,
        'selection_type': isMultiSelect ? 'multi' : 'single',
        'items': items.map((i) => i.toJson()).toList()};
}

class MenuItem {
  final String                 id;
  final String                 orgId;
  final String?                categoryId;
  final String                 name;
  final String?                description;
  final String?                imageUrl;
  final int                    basePrice;
  final bool                   isActive;
  final int                    displayOrder;
  final List<ItemSize>         sizes;
  final List<DrinkOptionGroup> optionGroups;

  const MenuItem({required this.id, required this.orgId, this.categoryId,
      required this.name, this.description, this.imageUrl,
      required this.basePrice, required this.isActive, required this.displayOrder,
      this.sizes = const [], this.optionGroups = const []});

  int priceForSize(String? label) {
    if (label == null || sizes.isEmpty) return basePrice;
    return sizes.firstWhere((s) => s.label == label,
        orElse: () => ItemSize(id: '', label: '', price: basePrice)).price;
  }

  factory MenuItem.fromJson(Map<String, dynamic> j) => MenuItem(
        id: j['id'], orgId: j['org_id'], categoryId: j['category_id'],
        name: j['name'], description: j['description'], imageUrl: j['image_url'],
        basePrice: j['base_price'], isActive: j['is_active'],
        displayOrder: j['display_order'],
        sizes: (j['sizes'] as List? ?? []).map((s) => ItemSize.fromJson(s)).toList(),
        optionGroups: (j['option_groups'] as List? ?? [])
            .map((g) => DrinkOptionGroup.fromJson(g)).toList());

  Map<String, dynamic> toJson() => {
        'id': id, 'org_id': orgId, 'category_id': categoryId,
        'name': name, 'description': description, 'image_url': imageUrl,
        'base_price': basePrice, 'is_active': isActive,
        'display_order': displayOrder,
        'sizes': sizes.map((s) => s.toJson()).toList(),
        'option_groups': optionGroups.map((g) => g.toJson()).toList()};
}

DART_EOF

# ────────────────────────────────────────────────────────────────────────
# lib/core/api/menu_api.dart
# ────────────────────────────────────────────────────────────────────────
write 'lib/core/api/menu_api.dart' << 'DART_EOF'
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'client.dart';
import '../models/menu.dart';

class MenuApi {
  Future<List<Category>> categories(String orgId) async {
    final res = await dio.get('/categories', queryParameters: {'org_id': orgId});
    return (res.data as List).map((c) => Category.fromJson(c)).toList();
  }

  Future<List<MenuItem>> items(String orgId) async {
    final res = await dio.get('/menu-items', queryParameters: {'org_id': orgId});
    return (res.data as List).map((m) => MenuItem.fromJson(m)).toList();
  }

  /// Fetch single item with full sizes + option groups.
  /// Caches result; serves cache on network failure.
  Future<MenuItem> item(String id) async {
    try {
      final res  = await dio.get('/menu-items/$id');
      final item = MenuItem.fromJson(res.data as Map<String, dynamic>);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('menu_item_$id', jsonEncode(item.toJson()));
      return item;
    } catch (_) {
      final prefs  = await SharedPreferences.getInstance();
      final cached = prefs.getString('menu_item_$id');
      if (cached != null) {
        return MenuItem.fromJson(jsonDecode(cached) as Map<String, dynamic>);
      }
      rethrow;
    }
  }
}

final menuApi = MenuApi();

DART_EOF

# ────────────────────────────────────────────────────────────────────────
# lib/core/providers/menu_provider.dart
# ────────────────────────────────────────────────────────────────────────
write 'lib/core/providers/menu_provider.dart' << 'DART_EOF'
import 'dart:convert';
import 'package:flutter/foundation.dart' hide Category;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/menu.dart';
import '../api/menu_api.dart';

class MenuProvider extends ChangeNotifier {
  List<Category>  _cats        = [];
  List<MenuItem>  _items       = [];
  String?         _selId;
  bool            _loading     = false;
  String?         _error;
  String?         _loadedOrgId;
  bool            _fromCache   = false;

  List<Category>  get categories => _cats;
  List<MenuItem>  get allItems   => _items;
  String?         get selectedId => _selId;
  bool            get loading    => _loading;
  String?         get error      => _error;
  bool            get fromCache  => _fromCache;

  List<MenuItem> get filtered => _selId == null
      ? _items
      : _items.where((i) => i.categoryId == _selId).toList();

  Future<void> load(String orgId) async {
    if (_loadedOrgId == orgId && _items.isNotEmpty && !_fromCache) return;
    _loading   = true;
    _fromCache = false;
    notifyListeners();
    try {
      final cats  = await menuApi.categories(orgId);
      final items = await menuApi.items(orgId);
      _cats        = cats;
      _items       = items;
      _selId       = _cats.isNotEmpty ? _cats.first.id : null;
      _error       = null;
      _loadedOrgId = orgId;
      _fromCache   = false;
      await _saveCache(orgId);
    } catch (e) {
      final ok = await _loadCache(orgId);
      if (ok) {
        _fromCache   = true;
        _error       = null;
        _loadedOrgId = orgId;
      } else {
        _error = 'No connection and no cached menu available';
      }
    }
    _loading = false;
    notifyListeners();
  }

  void refresh(String orgId) { _loadedOrgId = null; load(orgId); }

  void select(String id) { _selId = id; notifyListeners(); }

  Future<void> _saveCache(String orgId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('menu_cache_v2_$orgId', jsonEncode({
        'categories': _cats.map((c)  => c.toJson()).toList(),
        'items':      _items.map((i) => i.toJson()).toList(),
      }));
    } catch (_) {}
  }

  Future<bool> _loadCache(String orgId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw   = prefs.getString('menu_cache_v2_$orgId');
      if (raw == null) return false;
      final data  = jsonDecode(raw) as Map<String, dynamic>;
      _cats  = (data['categories'] as List)
          .map((c) => Category.fromJson(c as Map<String, dynamic>)).toList();
      _items = (data['items'] as List)
          .map((i) => MenuItem.fromJson(i as Map<String, dynamic>)).toList();
      _selId = _cats.isNotEmpty ? _cats.first.id : null;
      return true;
    } catch (_) { return false; }
  }
}

DART_EOF

# ────────────────────────────────────────────────────────────────────────
# lib/core/models/pending_order.dart
# ────────────────────────────────────────────────────────────────────────
write 'lib/core/models/pending_order.dart' << 'DART_EOF'
import 'order.dart';

class PendingOrder {
  final String         localId;
  final String         branchId;
  final String         shiftId;
  final String         paymentMethod;
  final String?        customerName;
  final String?        discountType;
  final int?           discountValue;
  final List<CartItem> items;
  final DateTime       createdAt;

  PendingOrder({required this.localId, required this.branchId,
      required this.shiftId, required this.paymentMethod,
      this.customerName, this.discountType, this.discountValue,
      required this.items, required this.createdAt});

  Map<String, dynamic> toJson() => {
    'local_id': localId, 'branch_id': branchId, 'shift_id': shiftId,
    'payment_method': paymentMethod, 'customer_name': customerName,
    'discount_type': discountType, 'discount_value': discountValue,
    'items': items.map((i) => i.toJson()).toList(),
    'created_at': createdAt.toIso8601String(),
  };

  factory PendingOrder.fromJson(Map<String, dynamic> j) => PendingOrder(
    localId:       j['local_id']       as String,
    branchId:      (j['branch_id']     as String?) ?? '',
    shiftId:       j['shift_id']       as String,
    paymentMethod: j['payment_method'] as String,
    customerName:  j['customer_name']  as String?,
    discountType:  j['discount_type']  as String?,
    discountValue: j['discount_value'] as int?,
    items: (j['items'] as List).map((i) {
      final m = i as Map<String, dynamic>;
      return CartItem(
        menuItemId: m['menu_item_id'] as String,
        itemName:   m['item_name']    ?? '',
        sizeLabel:  m['size_label']   as String?,
        unitPrice:  (m['unit_price']  ?? 0) as int,
        quantity:   (m['quantity']    ?? 1)  as int,
        addons: (m['addons'] as List? ?? []).map((a) {
          final am = a as Map<String, dynamic>;
          return SelectedAddon(
            addonItemId:       am['addon_item_id'],
            drinkOptionItemId: am['drink_option_item_id'] ?? '',
            name:              am['name']            ?? '',
            priceModifier:     (am['price_modifier']  ?? 0) as int,
          );
        }).toList(),
      );
    }).toList(),
    createdAt: DateTime.parse(j['created_at'] as String),
  );
}

DART_EOF

# ────────────────────────────────────────────────────────────────────────
# lib/core/services/offline_sync_service.dart
# ────────────────────────────────────────────────────────────────────────
write 'lib/core/services/offline_sync_service.dart' << 'DART_EOF'
import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/order_api.dart';
import '../models/pending_order.dart';

const _kPendingKey = 'offline_pending_orders';

class OfflineSyncService extends ChangeNotifier {
  List<PendingOrder> _pending  = [];
  bool               _syncing  = false;
  bool               _isOnline = true;
  String?            _lastError;
  StreamSubscription<List<ConnectivityResult>>? _sub;

  List<PendingOrder> get pending   => List.unmodifiable(_pending);
  bool               get syncing   => _syncing;
  bool               get isOnline  => _isOnline;
  int                get count     => _pending.length;
  String?            get lastError => _lastError;

  Future<void> init() async {
    await _load();
    final results = await Connectivity().checkConnectivity();
    _isOnline = results.any((r) => r != ConnectivityResult.none);
    _sub = Connectivity().onConnectivityChanged.listen((results) {
      final online = results.any((r) => r != ConnectivityResult.none);
      if (online && !_isOnline && _pending.isNotEmpty) syncAll();
      _isOnline = online;
      notifyListeners();
    });
    if (_isOnline && _pending.isNotEmpty) syncAll();
  }

  @override
  void dispose() { _sub?.cancel(); super.dispose(); }

  Future<void> savePending(PendingOrder order) async {
    _pending.add(order);
    await _persist();
    notifyListeners();
  }

  Future<void> syncAll() async {
    if (_syncing || _pending.isEmpty) return;
    _syncing   = true;
    _lastError = null;
    notifyListeners();
    final done = <String>[];
    for (final p in List.of(_pending)) {
      try {
        await orderApi.create(
          branchId:      p.branchId,
          shiftId:       p.shiftId,
          paymentMethod: p.paymentMethod,
          items:         p.items,
          customerName:  p.customerName,
          discountType:  p.discountType,
          discountValue: p.discountValue,
        );
        done.add(p.localId);
      } catch (e) { _lastError = 'Sync failed: $e'; break; }
    }
    _pending.removeWhere((p) => done.contains(p.localId));
    await _persist();
    _syncing = false;
    notifyListeners();
  }

  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw   = prefs.getString(_kPendingKey);
      if (raw != null) {
        _pending = (jsonDecode(raw) as List)
            .map((e) => PendingOrder.fromJson(e as Map<String, dynamic>)).toList();
      }
    } catch (_) { _pending = []; }
  }

  Future<void> _persist() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_kPendingKey,
          jsonEncode(_pending.map((p) => p.toJson()).toList()));
    } catch (_) {}
  }
}

final offlineSyncService = OfflineSyncService();

DART_EOF

# ────────────────────────────────────────────────────────────────────────
# lib/main.dart
# ────────────────────────────────────────────────────────────────────────
write 'lib/main.dart' << 'DART_EOF'
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'core/providers/auth_provider.dart';
import 'core/providers/branch_provider.dart';
import 'core/providers/cart_provider.dart';
import 'core/providers/menu_provider.dart';
import 'core/providers/order_history_provider.dart';
import 'core/providers/shift_provider.dart';
import 'core/router/router.dart';
import 'core/services/offline_sync_service.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp,
  ]);
  await offlineSyncService.init();
  runApp(const RuePOS());
}

class RuePOS extends StatelessWidget {
  const RuePOS({super.key});

  @override
  Widget build(BuildContext context) {
    final branchProvider = BranchProvider();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<OfflineSyncService>.value(value: offlineSyncService),
        ChangeNotifierProvider<BranchProvider>.value(value: branchProvider),
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(branchProvider)..init(),
        ),
        ChangeNotifierProvider(create: (_) => ShiftProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => MenuProvider()),
        ChangeNotifierProvider(create: (_) => OrderHistoryProvider()),
      ],
      child: Builder(builder: (ctx) {
        final auth = ctx.watch<AuthProvider>();
        if (auth.loading) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            home: const Scaffold(
              backgroundColor: AppColors.bg,
              body: Center(child: CircularProgressIndicator(color: AppColors.primary)),
            ),
          );
        }
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Rue POS',
          theme: AppTheme.light,
          routerConfig: buildRouter(auth),
        );
      }),
    );
  }
}

DART_EOF


# ─────────────────────────────────────────────────────────────────────────────
#  Patch screen files
# ─────────────────────────────────────────────────────────────────────────────
run_patch() {
    local script="$PATCHES_DIR/$1" target="$PROJ/$2"
    [ -f "$target" ] && python3 "$script" "$target" || echo "  SKIP: $2 not found"
}

run_patch patch_order_screen.py  lib/features/order/order_screen.dart
run_patch patch_home_screen.py   lib/features/home/home_screen.dart
run_patch patch_open_shift.py    lib/features/shift/open_shift_screen.dart
run_patch patch_close_shift.py   lib/features/shift/close_shift_screen.dart

# ─────────────────────────────────────────────────────────────────────────────
#  pubspec.yaml — add connectivity_plus if missing
# ─────────────────────────────────────────────────────────────────────────────
PUBSPEC="$PROJ/pubspec.yaml"
if [ -f "$PUBSPEC" ]; then
    if ! grep -q "connectivity_plus" "$PUBSPEC"; then
        grep -q "shared_preferences" "$PUBSPEC" \
            && sed -i '/shared_preferences/a\  connectivity_plus: ^6.0.0' "$PUBSPEC" \
            || sed -i '/^dependencies:/a\  connectivity_plus: ^6.0.0' "$PUBSPEC"
        echo "  pubspec: added connectivity_plus"
    else
        echo "  pubspec: connectivity_plus already present"
    fi
fi

# ─────────────────────────────────────────────────────────────────────────────
#  flutter pub get
# ─────────────────────────────────────────────────────────────────────────────
echo ""
echo "==> flutter pub get..."
cd "$PROJ" && flutter pub get

echo ""
echo "========================================"
echo "  Full offline support applied!"
echo "========================================"
echo ""
echo "What works offline:"
echo "  Home screen    Shift status, order count, sales, system cash"
echo "  Order screen   Full menu with sizes and options, place orders (queued)"
echo "  Order history  Browse all orders for current shift"
echo "  Shift history  Browse past shifts and their orders"
echo "  Close shift    Inventory counts (from cache), system cash"
echo ""
echo "What requires internet:"
echo "  Open shift     Must be online (creates shift on backend)"
echo "  Close shift    Must be online (writes final counts to backend)"
echo "  Void order     Must be online"
echo ""
echo "Offline order sync:"
echo "  Queued orders auto-send the moment connectivity returns"
echo "  Blue banner shows sync progress in the order screen"
echo "  Offline order count shown in the banner"
echo ""
echo "First use:"
echo "  Must be online at least once per session to populate caches"
echo "  Open a shift online, then you can work offline all day"
echo ""