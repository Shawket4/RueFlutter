# Claude Code Conventions: Sufrix POS

## Project Overview
This is the Sufrix Point of Sale (POS) application, referred to as the "Teller App". It is a multi-platform Flutter application designed to handle in-store checkouts, receipts, and local synchronization.

## Core Technology Stack
- **Framework**: Flutter
- **Language**: Dart
- **State Management**: Riverpod (`flutter_riverpod` v2)
- **Routing**: GoRouter (`go_router`)
- **Networking**: Dio (`dio`)
- **Local Storage / DB**: Sqflite (`sqflite`, `sqflite_common_ffi`)

## UI & Assets
- **Fonts**: Google Fonts (using `Cairo` as the primary font family).
- **Icons & Animations**: Cupertino Icons, Lottie (`lottie`)
- **Images**: Cached Network Image, Flutter SVG

## Hardware & Capabilities
- **Printing**: `printing`, `pdf`, and `starxpand_sdk_wrapper` (for thermal receipt printing).
- **Network**: `connectivity_plus` to handle offline/online state transitions.

## Development Workflow
- **Run App**: `flutter run`
- **Run Tests**: `flutter test` (Uses `mocktail` for mocking)
- **Code Generation**: Use `flutter pub run build_runner build --delete-conflicting-outputs` (if dealing with Riverpod generators or Freezed).
- **Lints**: Adhere to `flutter_lints` rules (`flutter analyze`).

## Architecture Guidelines
1. **State Management**: Strictly use Riverpod (`Provider`, `StateNotifierProvider`, or `Notifier`) for state management. Avoid using `setState` for complex logic.
2. **Offline-First**: Because this is a POS system, rely on `sqflite` for local caching and use `connectivity_plus` to sync data when online.
3. **Navigation**: Always use `go_router` for deep linking and declarative routing.
4. **API Calls**: Route all HTTP requests through the `dio` client to ensure proper interception, token injection, and error handling.
5. **Wire Models**: All API models are GENERATED from the backend OpenAPI spec into `packages/sufrix_api` — never hand-roll wire fields/fromJson/toJson. When the backend schema changes, run `./tool/generate_api.sh` (POS equivalent of the dashboard's `npm run generate:api`). Files in `lib/core/models/` are façades only: exports, typedefs (e.g. app `Order` = generated `OrderFull`) and client-side extensions. Client-only models (`cart.dart`, `pending_action.dart`) stay hand-written.

## Related Projects (Ecosystem)
When working on new POS features, syncing data, or handling API responses, you may need to inspect the main backend or dashboard code. You can find them at:
- **Sufrix Backend**: `/Users/shawket/Desktop/SufrixRust` (Actix-Web Rust backend)
- **SufrixDashboard**: `/Users/shawket/Desktop/SufrixDashboard` (React/Tauri Dashboard)
You can use file read commands or `cd` into these directories to check how the backend is structured or how the dashboard handles similar flows.
