import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:module_master/const/const.dart';

import 'package:wan_mobile/views/controllers/boutique/boutique_page_vctl.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BoutiquePage extends StatelessWidget {
  const BoutiquePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BoutiquePageVctl>(
      init: BoutiquePageVctl(),
      builder: (ctl) {
        return Scaffold(
          appBar: AppBar(),
          body: WebViewWidget(
            controller: WebViewController()
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..loadRequest(Uri.parse(Const.boutiquerUrl)),
          ),
        );
      },
    );
  }
}
