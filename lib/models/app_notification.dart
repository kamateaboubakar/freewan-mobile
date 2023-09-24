import 'package:firebase_messaging/firebase_messaging.dart';

class AppNotification {
  String? title;
  String? body;
  int? userId;
  bool? isRead;

  AppNotification({this.title, this.body, this.userId, this.isRead});

  AppNotification.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    userId = json['user_id'];
    isRead = json['is_read'];
  }

  AppNotification.fromRemonteMessage(RemoteMessage notification) {
    title = notification.data["title"];
    body = notification.data["body"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['body'] = body;
    data['user_id'] = userId;
    data['is_read'] = isRead;
    return data;
  }
}
