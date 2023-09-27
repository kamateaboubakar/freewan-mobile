import 'package:flutter/material.dart';
import 'package:wan_mobile/tools/const/const.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EnvoyerVersMobilePage extends StatelessWidget {
  const EnvoyerVersMobilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 45,
        backgroundColor: Colors.transparent,
        title: Image.asset(Const.inLineAppLogo, width: 100, height: 50),
      ),
      // drawer: HomeDrawer(ctl),
      body: WebViewWidget(
        controller: WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(Uri.parse("http://148.113.143.59:6006/mobileTransfer")),
      ),
    );
  }
}
