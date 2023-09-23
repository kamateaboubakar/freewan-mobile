import 'package:wan_mobile/api/controllers/auth/notification_api_ctl.dart';
import 'package:wan_mobile/models/app_notification.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';

class NotificationListPageVctl extends ViewController {
  List<AppNotification> notifs = [];

  Future<void> fetchNotifications() async {
    await pr.show();
    var res = await NotificationApiCtl().getNotifications();
    await pr.hide();
    if (res.status) {
      notifs = res.data!;
      update();
    } else {
      Tools.messageBox(message: res.message);
    }
  }

  @override
  void onReady() {
    super.onReady();
    fetchNotifications();
  }
}
