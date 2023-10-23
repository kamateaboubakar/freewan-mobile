import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPaiementPageVctl extends ViewController {
  String url;

  WebviewPaiementPageVctl(this.url);

  var webViewCtl = WebViewController();

  @override
  void onReady() async {
    await webViewCtl.setJavaScriptMode(JavaScriptMode.unrestricted);
    await webViewCtl.loadRequest(Uri.parse(url));
    super.onReady();
  }
}
