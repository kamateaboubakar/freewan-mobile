import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/const/const.dart';
import 'package:wan_mobile/views/controllers/achat_unite/achat_unite_page_vctl.dart';
import 'package:wan_mobile/views/controllers/home/home_page_vctl.dart';
import 'package:wan_mobile/views/static/home/home_drawer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AchatUnitePage extends StatelessWidget {
  final HomePageVctl hCtl;
  const AchatUnitePage(this.hCtl, {super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AchatUnitePageVctl>(
        init: AchatUnitePageVctl(),
        builder: (ctl) {
          return Scaffold(
            appBar: AppBar(
              title: Image.asset(Const.inLineAppLogo, width: 100, height: 80),
            ),
            drawer: HomeDrawer(hCtl),
            body: WebViewWidget(
              controller: WebViewController()
                ..setJavaScriptMode(JavaScriptMode.unrestricted)
                ..loadRequest(
                    Uri.parse("http://148.113.143.59:6006/mobileTransfer")),
            ),
          );
        });
  }
}
