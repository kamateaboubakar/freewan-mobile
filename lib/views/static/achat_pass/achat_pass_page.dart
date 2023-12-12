import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../controllers/achat_pass/achat_pass_page_vctl.dart';

class AchatPassPage extends StatelessWidget {
  const AchatPassPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AchatPassPageVctl>(
        init: AchatPassPageVctl(),
        builder: (ctl) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Achat de pass"),
            ),
            body: WebViewWidget(
              controller: WebViewController()
                ..setJavaScriptMode(JavaScriptMode.unrestricted)
                ..loadRequest(
                    Uri.parse("http://148.113.143.59:6006/SaisieNumero")),
            ),
          );
        });
  }
}
