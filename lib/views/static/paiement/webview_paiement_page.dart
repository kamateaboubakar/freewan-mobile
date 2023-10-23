import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/views/controllers/paiement/webview_paiement_page_vctl.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPaiementPage extends StatelessWidget {
  final String url;
  const WebviewPaiementPage({required this.url, super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WebviewPaiementPageVctl>(
      init: WebviewPaiementPageVctl(url),
      builder: (ctl) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Validation du paiement"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: WebViewWidget(
              controller: ctl.webViewCtl,
            ),
          ),
        );
      },
    );
  }
}
