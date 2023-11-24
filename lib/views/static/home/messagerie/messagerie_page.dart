import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lebedoo_assets/themes/asset_colors.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/views/static/home/messagerie/chat_room.dart';

class MessageriePages extends StatelessWidget {
  final PageController pageViewCtl;

  const MessageriePages(this.pageViewCtl, {super.key});

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
        leading: IconButton(
          splashRadius: 20,
          icon: Icon(
              (Platform.isAndroid) ? Icons.arrow_back : Icons.arrow_back_ios),
          onPressed: () => pageViewCtl.previousPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
          ),
        ),
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
