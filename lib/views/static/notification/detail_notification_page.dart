import 'package:flutter/material.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/models/app_notification.dart';

class DetailNotificationPage extends StatelessWidget {
  final AppNotification notif;
  const DetailNotificationPage(this.notif, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Détails")),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.drafts),
            title: Text(notif.title.value),
            subtitle: Text(notif.createdAt.toDateTime().toFrenchDateTime),
          ),
          const Divider(),
          const Gap(10),
          ListTile(
            title: SelectableText(
              notif.body.value,
            ),
          )
        ],
      ),
    );
  }
}
