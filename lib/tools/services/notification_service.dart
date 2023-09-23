import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:wan_mobile/tools/utils/tools.dart';

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static Future<void> setup() async {
    await _initializeFirebaseNotification();
    await initLocalNotification();
  }

  static void sendLocalNotification(notification, {int? notifId}) {
    if (notification.title != null && notification.body != null) {}
  }

  static Future<void> initLocalNotification() async {
    await _messaging.requestPermission();
    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
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
      if (message.data.isNotEmpty) {
        await FlutterRingtonePlayer.playNotification();
        Tools.showSnackbar(
            title: message.data["title"], message: message.data["body"]);
        if (handler != null) {
          handler.call();
        }
      }
    });
  }
}

Future<void> onBackgroundMessage(RemoteMessage message) async {
  print(message.toMap());
}
