import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/models/app_notification.dart';
import 'package:wan_mobile/views/static/notification/notification_list_page.dart';

abstract class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final _localNotificationService = FlutterLocalNotificationsPlugin();

  static Future<void> setup() async {
    await _initializeFirebaseNotification();
    await _initLocalNotification();
  }

  static void showLocalNotification(AppNotification notification,
      {int? notifId}) {
    if (notification.title != null && notification.body != null) {
      const androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'lebedoo_channel_id',
        'lebedoo_channel',
        importance: Importance.max,
        priority: Priority.high,
      );
      const iOSPlatformChannelSpecifics = DarwinNotificationDetails();
      _localNotificationService.show(
        notifId ?? Random().nextInt(1000),
        notification.title,
        notification.body,
        const NotificationDetails(
          android: androidPlatformChannelSpecifics,
          iOS: iOSPlatformChannelSpecifics,
        ),
      );
    }
  }

  static Future<void> _initLocalNotification() async {
    var initializationSettings = const InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: DarwinInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification,
      ),
    );

    await _localNotificationService.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: onNotificationClick,
      onDidReceiveNotificationResponse: onNotificationClick,
    );
  }

  static Future<void> _initializeFirebaseNotification() async {
    await _messaging.requestPermission();
    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
    NotificationSettings settings = await _messaging.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      await _messaging.setForegroundNotificationPresentationOptions(
          alert: true, badge: true, sound: true);
    }
  }

  static Future<void> listNotification(
      {void Function(RemoteMessage? message)? handler}) async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (message.data.isNotEmpty) {
        showLocalNotification(AppNotification.fromRemonteMessage(message));
        if (handler != null) {
          handler.call(message);
        }
      }
    });
  }

  static Future<void> onNotificationClick(NotificationResponse detail) async {
    Get.to(() => const NotificationListPage());
  }

  static Future<void> onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    var notif = AppNotification(
      title: title,
      body: body,
    );
    showLocalNotification(notif);
  }
}

@pragma('vm:entry-point')
Future<void> onBackgroundMessage(RemoteMessage message) async {
  NotificationService.showLocalNotification(
      AppNotification.fromRemonteMessage(message));
}
