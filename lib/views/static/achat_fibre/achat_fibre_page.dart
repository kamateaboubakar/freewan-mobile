import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/views/controllers/achat_fibre/achat_fibre_page_vctl.dart';
import 'package:wan_mobile/views/controllers/home/home_page_vctl.dart';
import 'package:wan_mobile/views/static/home/home_drawer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AchatFibrePage extends StatelessWidget {
  final HomePageVctl hCtl;
  const AchatFibrePage(this.hCtl, {super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AchatFibrePageVctl>(
        init: AchatFibrePageVctl(),
        builder: (ctl) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Abonnement Fibre"),
            ),
            drawer: HomeDrawer(hCtl),
            body: WebViewWidget(
              controller: WebViewController()
                ..setJavaScriptMode(JavaScriptMode.unrestricted)
                ..loadRequest(
                    Uri.parse("http://148.113.143.59:6006/AchatFibre")),
            ),
          );
        });
  }
}
