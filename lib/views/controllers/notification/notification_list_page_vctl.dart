import 'package:get/get.dart';
import 'package:wan_mobile/api/controllers/auth/notification_api_ctl.dart';
import 'package:wan_mobile/models/app_notification.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';
import 'package:wan_mobile/views/static/notification/detail_notification_page.dart';

class NotificationListPageVctl extends ViewController {
  List<AppNotification> notifs = [];

  Future<void> fetchNotifications() async {
    if (appCtl.notifAccount.value > 0) {
      appCtl.notifAccount.value = 0;
    }
    await pr.show();
    var res = await NotificationApiCtl().getNotifications();
    await pr.hide();
    if (res.status) {
      notifs = res.data!
        ..sort((a, b) => b.createdAt.value.compareTo(a.createdAt.value));
      update();
    } else {
      Tools.messageBox(message: res.message);
    }
  }

  Future<void> setReaded(AppNotification e) async {
    if (e.id != null) {
      await pr.show();
      var res = await NotificationApiCtl().setRead(e.id!);
      await pr.hide();
      if (res.status) {
        e.isRead = true;
        update();
        Get.to(() => DetailNotificationPage(e));
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
    fetchNotifications();
  }
}
