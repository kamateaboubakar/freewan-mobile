import 'package:firebase_messaging/firebase_messaging.dart';

class AppNotification {
  int? id;
  String? title;
  String? body;
  int? userId;
  bool? isRead;
  String? createdAt;
  String? updatedAt;

  AppNotification({this.title, this.body, this.userId, this.isRead});

  AppNotification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    userId = json['user_id'];
    isRead = json['is_read'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  AppNotification.fromRemonteMessage(RemoteMessage notification) {
    title = notification.data["title"];
    body = notification.data["body"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    data['user_id'] = userId;
    data['is_read'] = isRead;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
