import 'package:wan_mobile/api/abstracts/http_client_const.dart';
import 'package:wan_mobile/api/abstracts/web_controller.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/http_response.dart';

class QrLoginApiCtl extends WebController {
  Future<HttpResponse<bool>> setUser(
      {required String userId, required String qrCode}) async {
    try {
      var res = await post(
        "http://148.113.143.59:8183/api/v1/auth/qrLogin/setUser",
        {"qrCode": qrCode}.parseToJson(),
        headers: HttpClientConst.authHeaders,
      );
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        return HttpResponse.success(data: true);
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e) {
      return HttpResponse.error();
    }
  }
}
