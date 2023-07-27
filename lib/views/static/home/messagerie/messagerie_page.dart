import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/tools/widgets/c_textform_field.dart';
import 'package:wan_mobile/tools/widgets/wrapper_body_listview.dart';
import 'package:wan_mobile/views/static/home/messagerie/chat_room.dart';

class MessageriePages extends StatelessWidget {
  const MessageriePages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const ChatRoom()),
        backgroundColor: AssetColors.blueButton,
        child: const Icon(Icons.add_comment_rounded),
      ),
      appBar: AppBar(
        title: const Text("Messagerie"),
      ),
      body: const Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CTextFormField(
              hintText: "Recherche",
              suffixIcon: Icon(Icons.search),
            ),
          ),
          Expanded(
            child: WrapperBodyListView(
              loading: false,
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}
