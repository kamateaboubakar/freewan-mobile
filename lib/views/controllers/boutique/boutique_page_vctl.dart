import 'package:wan_mobile/api/controllers/boutique_api_ctl.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';

class BoutiquePageVctl extends ViewController {
  String pageHtml = "";
  Future<void> getPage() async {
    var res = await BoutiqueApiCtl().getPage();
    if (res.status) {
      pageHtml = res.data!;
      update();
    } else {
      Tools.messageBox(message: res.message);
    }
  }

  @override
  void onReady() {
    super.onReady();
    getPage();
  }
}
