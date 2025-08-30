import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';

class NotificationService {
  static final _messaging = FirebaseMessaging.instance;
  static final _localNotifications = FlutterLocalNotificationsPlugin();

  static Future<void> initialize(BuildContext context) async {
    // Solicita permisos
    await _messaging.requestPermission();

    // Inicializa notificaciones locales
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings();
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (details) {
        _handleLocalNotificationTap(context, details.payload);
      },
    );

    // Foreground: muestra local notification y redirige si corresponde
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showLocalNotification(message);
    });

    // Background & Terminated: redirige cuando el usuario toca la notificación
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleMessage(context, message);
    });

    // App cerrada: redirige si la app se abrió desde una notificación
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(context, initialMessage);
    }
  }

  static void _showLocalNotification(RemoteMessage message) async {
    final notification = message.notification;
    final data = message.data;
    final payload = jsonEncode(data);

    const androidDetails = AndroidNotificationDetails(
      'default_channel',
      'General',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
    );
    const iosDetails = DarwinNotificationDetails();
    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      notification.hashCode,
      notification?.title ?? 'Notificación',
      notification?.body ?? '',
      details,
      payload: payload,
    );
  }

  static void _handleLocalNotificationTap(
    BuildContext context,
    String? payload,
  ) {
    if (payload == null) return;
    final data = jsonDecode(payload);
    _handleData(context, data);
  }

  static void _handleMessage(BuildContext context, RemoteMessage message) {
    final data = message.data;
    _handleData(context, data);
  }

  static void _handleData(BuildContext context, Map<String, dynamic> data) {
    if (data['type'] == 'products' && data['products'] != null) {
      final products = data['products'] is List
          ? List<String>.from(data['products'])
          : (data['products'] as String).split(',');
      GoRouter.of(context).go('/products', extra: products);
    }
    // Puedes agregar más tipos de notificación aquí
  }
}
