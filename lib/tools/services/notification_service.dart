import 'dart:convert';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:wan_mobile/tools/utils/http_response.dart';

class NotificationService {
  static final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static Future<void> setup() async {
    await _initializeFirebaseNotification();
    await initLocalNotification();
  }

  static void sendLocalNotification(notification, {int? notifId}) {
    if (notification.title != null && notification.body != null) {
      var rdmId = Random().nextInt(1000) + 1;

      // #2
      var androidDetail =
          const AndroidNotificationDetails("smart_partId", "smart_part");

      const iosDetail = DarwinNotificationDetails();

      var noticeDetail = NotificationDetails(
        iOS: iosDetail,
        android: androidDetail,
      );

      _localNotificationsPlugin.show(
        notifId ?? rdmId,
        notification.title,
        notification.body,
        noticeDetail,
      );
    }
  }

  static Future<List<ActiveNotification>> getAllNotifications() async {
    return await _localNotificationsPlugin.getActiveNotifications();
  }

  static Future<void> initLocalNotification() async {
    // #1 Initialization of android et ios local notifications settings
    const androidSetting = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSetting = DarwinInitializationSettings();

    // #2 Initialization of local notifications settings
    const initSettings =
        InitializationSettings(android: androidSetting, iOS: iosSetting);

    // #3 Initialization of local notifications
    await _localNotificationsPlugin.initialize(initSettings);
  }

  static Future<void> _initializeFirebaseNotification() async {
    NotificationSettings settings = await _messaging.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      await _messaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      // FirebaseMessaging.onMessageOpenedApp.listen((event) {
      //   print("###################### ${event.data}");
      // });
    }
  }

  static Future<void> listNotification({void Function()? handler}) async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;

      if (notification != null) {
        var random = Random().nextInt(1000);
        await _localNotificationsPlugin.show(
          random,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              "smart_part",
              "smart_part",
              priority: Priority.high,
              importance: Importance.max,
            ),
            iOS: DarwinNotificationDetails(
              presentSound: true,
              presentAlert: true,
            ),
          ),
          payload: jsonEncode(message.data),
        );
        if (handler != null) {
          handler.call();
        }
      }
    });
  }

  /// 0 (zéro) représent l'id que je donne aux notifications de rappel de "quiz 30 min avant la fin"
  static Future<HttpResponse<bool>> removeScheduledNotif(
      {int notifId = 0}) async {
    try {
      await _localNotificationsPlugin.cancel(notifId);
      return HttpResponse.success(data: true);
    } catch (e) {
      return HttpResponse.error();
    }
  }

  static Future<HttpResponse<bool>> removeAllScheduledNotif() async {
    try {
      await _localNotificationsPlugin.cancelAll();
      return HttpResponse.success(data: true);
    } catch (e) {
      return HttpResponse.error();
    }
  }

  // static Future<void> sendFirebaseNotification({required String token}) async {
  //   _messaging.sendMessage(to: token);
  // }

  static Future<void> backgroundHandler(RemoteMessage message) async {
    if (kDebugMode) {
      print("Handling a background message: ${message.messageId}");
    }
  }

  static Future<String?> getFcmToken() async {
    try {
      String? token = await _messaging.getToken();

      return token;
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
      return null;
    }
  }
}
