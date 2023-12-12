import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:wan_mobile/views/controllers/achat_fibre/achat_fibre_page_vctl.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AchatFibrePage extends StatelessWidget {
  const AchatFibrePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AchatFibrePageVctl>(
      init: AchatFibrePageVctl(),
      builder: (ctl) {
        return Scaffold(
          appBar: AppBar(title: const Text("Abonnement Fibre")),
          body: WebViewWidget(
            controller: WebViewController()
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..loadRequest(Uri.parse("http://148.113.143.59:6006/AchatFibre")),
          ),
        );
      },
    );
  }
}
