import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/views/controllers/home/home_page_vctl.dart';
import 'package:wan_mobile/views/static/home/home_drawer.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../controllers/achat_pass/achat_pass_page_vctl.dart';

class AchatPassPage extends StatelessWidget {
  final HomePageVctl hCtl;
  const AchatPassPage(this.hCtl, {super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AchatPassPageVctl>(
        init: AchatPassPageVctl(),
        builder: (ctl) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Achat de pass"),
            ),
            drawer: HomeDrawer(hCtl),
            body: WebViewWidget(
              controller: WebViewController()
                ..setJavaScriptMode(JavaScriptMode.unrestricted)
                ..loadRequest(Uri.parse(
                    "http://148.113.143.59:6006/${ctl.appCtl.user.phoneNumber}")),
            ),
          );
        });
  }
}
