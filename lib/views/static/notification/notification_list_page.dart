import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/tools/widgets/wrapper_body_listview.dart';
import 'package:wan_mobile/views/controllers/notification/notification_list_page_vctl.dart';
import 'package:wan_mobile/views/static/notification/detail_notification_page.dart';

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
                      leading: CircleAvatar(
                        child: Icon(
                          color: Colors.white,
                          (e.isRead == true) ? Icons.drafts : Icons.mail,
                        ),
                      ),
                      selected: e.isRead == false,
                      selectedColor: AssetColors.blue,
                      title: Text(e.title.value),
                      subtitle: Row(
                        children: [
                          Expanded(
                            child: Text(
                              e.body.value,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Gap(10),
                          Text(
                            e.createdAt.toDateTime().toFrenchDateTime,
                            textAlign: TextAlign.end,
                          ),
                        ],
                      ),
                      onTap: () {
                        if (e.isRead == true) {
                          Get.to(() => DetailNotificationPage(e));
                        } else {
                          ctl.setReaded(e);
                        }
                      },
                    ),
                  )
                  .toList(),
            );
          }),
    );
  }
}
