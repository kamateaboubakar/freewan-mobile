import 'package:wan_mobile/api/abstracts/http_client_const.dart';
import 'package:wan_mobile/api/abstracts/web_controller.dart';
import 'package:wan_mobile/tools/const/const.dart';
import 'package:wan_mobile/tools/utils/http_response.dart';

class BoutiqueApiCtl extends WebController {
  Future<HttpResponse<String>> getPage() async {
    try {
      var res = await get(Const.boutiquerUrl, headers: HttpClientConst.headers);

      if (res.statusCode == 200) {
        return HttpResponse.success(data: res.body);
      } else {
        return HttpResponse.error(message: res.statusText ?? "");
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }
}
