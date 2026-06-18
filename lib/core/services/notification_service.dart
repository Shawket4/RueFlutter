import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';

import '../models/delivery_order.dart';
import '../router/router.dart';
import '../utils/formatting.dart';

/// OS-level local notifications for new delivery orders (Android + iOS).
///
/// Singleton, mirroring [ConnectivityService]. [init] is called once in `main()`
/// before `runApp`. The actual alert is fired from [DeliveryRealtimeService]
/// (the single new-order detection point), so it stays in lockstep with the
/// in-app banner + chime + haptic.
class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  static const _channelId = 'delivery_new_orders';
  static const _channelName = 'New delivery orders';
  static const _channelDesc =
      'Alerts the teller when a new online delivery order arrives.';

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  /// Set up the plugin + Android channel. Permissions are NOT requested here
  /// (deferred to [requestPermissions] after the first authenticated load, so
  /// the OS prompt has context). Best-effort: never throws into `main()`.
  Future<void> init() async {
    if (_initialized) return;
    try {
      const android = AndroidInitializationSettings('@mipmap/ic_launcher');
      const darwin = DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      );
      await _plugin.initialize(
        const InitializationSettings(android: android, iOS: darwin),
        onDidReceiveNotificationResponse: _onTap,
      );

      await _plugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(const AndroidNotificationChannel(
            _channelId,
            _channelName,
            description: _channelDesc,
            importance: Importance.high,
            playSound: true,
          ));
      _initialized = true;
    } catch (e) {
      if (kDebugMode) debugPrint('NotificationService.init failed: $e');
    }
  }

  /// Ask for notification permission. Call once after the first authenticated
  /// delivery load so the prompt is contextual (Android 13+ / iOS).
  Future<void> requestPermissions() async {
    try {
      await _plugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
      await _plugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(alert: true, badge: true, sound: true);
    } catch (e) {
      if (kDebugMode) debugPrint('NotificationService.requestPermissions: $e');
    }
  }

  /// Show the "new delivery order" notification. Tapping it opens the delivery
  /// queue. The notification id is derived from the order id so a repeat of the
  /// same order replaces rather than stacks.
  Future<void> showNewOrder(DeliveryOrder order) async {
    if (!_initialized) return;
    try {
      final id = order.id.hashCode & 0x7fffffff;
      final ref = order.deliveryRef ?? 'New order';
      final body = '${order.customerName} · ${egp(order.total)}';
      await _plugin.show(
        id,
        'New delivery order · $ref',
        body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            _channelId,
            _channelName,
            channelDescription: _channelDesc,
            importance: Importance.high,
            priority: Priority.high,
            category: AndroidNotificationCategory.message,
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: order.id,
      );
    } catch (e) {
      if (kDebugMode) debugPrint('NotificationService.showNewOrder failed: $e');
    }
  }

  /// Cancel a previously-shown new-order notification once the order has been
  /// accepted (or otherwise resolved), so it clears from the OS notification
  /// center. Uses the same id derivation as [showNewOrder].
  Future<void> cancel(String orderId) async {
    if (!_initialized) return;
    try {
      await _plugin.cancel(orderId.hashCode & 0x7fffffff);
    } catch (e) {
      if (kDebugMode) debugPrint('NotificationService.cancel failed: $e');
    }
  }

  void _onTap(NotificationResponse response) {
    final context = rootNavigatorKey.currentContext;
    if (context == null) return;
    GoRouter.of(context).goNamed('delivery-orders');
  }
}
