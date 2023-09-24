import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:wan_mobile/models/app_notification.dart';

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final _localNotificationService = FlutterLocalNotificationsPlugin();

  static Future<void> setup() async {
    await _initializeFirebaseNotification();
    await initLocalNotification();
  }

  static void _showLocalNotification(AppNotification notification,
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
        notifId ?? 0,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: androidPlatformChannelSpecifics,
          iOS: iOSPlatformChannelSpecifics,
        ),
      );
    }
  }

  static Future<void> initLocalNotification() async {
    var initializationSettings = const InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: DarwinInitializationSettings(),
    );

    await _localNotificationService.initialize(initializationSettings);
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

  static Future<void> listNotification({void Function()? handler}) async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (message.data.isNotEmpty) {
        // Tools.showSnackbar(
        //     title: message.data["title"], message: message.data["body"]);
        _showLocalNotification(AppNotification.fromRemonteMessage(message));
        if (handler != null) {
          handler.call();
        }
      }
    });
  }
}

Future<void> onBackgroundMessage(RemoteMessage message) async {}
