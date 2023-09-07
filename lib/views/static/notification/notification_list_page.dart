import 'package:flutter/material.dart';
import 'package:wan_mobile/tools/widgets/wrapper_body_listview.dart';

class NotificationListPage extends StatelessWidget {
  const NotificationListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body: WrapperBodyListView(
        loading: false,
        children: [],
      ),
    );
  }
}
