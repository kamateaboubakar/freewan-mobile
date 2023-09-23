import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/tools/widgets/wrapper_body_listview.dart';
import 'package:wan_mobile/views/controllers/notification/notification_list_page_vctl.dart';

class NotificationListPage extends StatelessWidget {
  const NotificationListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body: GetBuilder<NotificationListPageVctl>(
          init: NotificationListPageVctl(),
          builder: (ctl) {
            return WrapperBodyListView(
              loading: false,
              onRefresh: ctl.fetchNotifications,
              children: ctl.notifs
                  .map(
                    (e) => ListTile(
                      selected: e.isRead == true,
                      selectedColor: AssetColors.blue,
                      leading: const Icon(Icons.notifications_active),
                      title: Text(e.title.value),
                      subtitle: Text(e.body.value, maxLines: 1),
                    ),
                  )
                  .toList(),
            );
          }),
    );
  }
}
