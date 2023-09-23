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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['body'] = this.body;
    data['user_id'] = this.userId;
    data['is_read'] = this.isRead;
    return data;
  }
}
