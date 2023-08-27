import 'package:wan_mobile/api/abstracts/http_client_const.dart';
import 'package:wan_mobile/api/abstracts/web_controller.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/http_response.dart';

class QrLoginApiCtl extends WebController {
  Future<HttpResponse<bool>> setUser(
      {required String userId, required String qrCode}) async {
    try {
      var res = await post(
        "http://192.168.1.7:8000/api/setUser",
        {"userId": userId, "qrCode": qrCode}.parseToJson(),
        headers: HttpClientConst.headers,
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
