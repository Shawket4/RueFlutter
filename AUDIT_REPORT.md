# Sufrix POS — Overnight Audit Report

**Branch:** `audit/overnight`. **Suite:** `flutter test` → **318 passed / 0 failed** (2 skipped); `flutter analyze` → clean. **Baseline was red: 13 failing tests.**

## Fixed — 13 stale tests (test rot, no `lib/` change)
The suite was failing on `main` **before any audit change**. All 13 were stale tests left behind by recent refactors (confirmed against the shipped models + generated `packages/sufrix_api`; none masked a code bug):
- **`display_order` removed from the contract** (menu now renders in *server order*) → updated `Category` / `ItemSize` / `AddonItem` / `MenuItem` / `PaymentMethod` serialization tests (`menu_test`, `wire_compat_test`, `payment_method_test`) and the `menu_notifier` grid/addon tests to assert **server (insertion) order** and key-absence instead of `displayOrder` sorting.
- **Open-shift flow** routes an authenticated user with no open shift to `/open-shift` (not `/home`) → updated two `router_test` redirect tests.
- **`PendingVoidOrder` gained an optional `note`** emitted by `toJson()` → fixed the round-trip fixture.

This makes the POS suite green and aligns the tests with shipped behavior. See commit `test(pos): repair 13 stale tests …`.

## Findings reviewed but NOT changed (and why)

These are real observations from the map, but each is either a **feature** (out of "bug-only" scope), has **no current impact**, or is a UX change that **cannot be verified** without driving the running app — so per the audit discipline (keep the suite green, don't add features, document design gaps) they are logged here rather than changed.

- **Cart total omits tax; split/tender validate against the tax-free total** (`lib/core/models/cart.dart:383`, `checkout_sheet.dart:389,415`).
  `cart.total = subtotal − discount`, with **no tax** and **no `tax_rate` in the cart model at all** — the POS only reads `taxAmount` from the server response for display. The backend charges `total + tax`, so with a non-zero tax rate the POS would show the wrong change and could accept an under-payment.
  **No current impact:** every org in the prod DB has `tax_rate = 0.0000`. **Fixing it correctly is a feature** (fetch the org/branch `tax_rate`, compute a tax-inclusive cart total, validate tender/splits against it, surface tax in the UI) — not a minimal bug fix. **Recommended** before any org enables tax.

- **Backend 403 "different branch" / 409 "shift open" can be swallowed during login/resume** (`auth_notifier.dart:230` `catch (_)` in the post-login shift check; `client.dart:76` already maps 403/409 to friendly messages).
  The backend now returns these crisply (see the backend audit V26 + single-open-shift). The POS's shift-check `catch (_)` treats a 403 there as a network error and allows login silently. **Recommended:** in that catch, distinguish a `DioException` with status 403/409 from a connectivity error and surface it. Not changed here — it's an auth-flow UX change that needs app-level verification.

- **Percentage discount rounds in the POS but truncated in the backend** (`cart.dart:378` `.round()` vs backend `(subtotal*v/100) as i32`) — **RESOLVED on the backend side**: the backend now rounds percentage discount + tax (half away from zero), matching the POS preview to the piastre. No POS change needed (it already rounds).

- **Offline void of an offline-created order can be lost** (`offline_queue.dart:338` — void carries the localId, the server order has a DB-generated id → 404 → dead-letter). Real but lives in the offline-queue reconciliation logic; needs careful design + offline integration testing. Logged for a focused offline-sync pass.

- Minor display: `egp()` prints a bare minus for negatives (`utils/formatting.dart:3`); optimistic/offline order hard-codes `discountAmount` without tax (`checkout_sheet.dart:586`). Cosmetic; deferred.
