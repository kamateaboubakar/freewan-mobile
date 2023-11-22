import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:lebedoo_assets/tools/web/app_http_hearders.dart';
import 'package:lebedoo_assets/tools/web/web_request.dart';

import 'package:wan_mobile/tools/types/types.dart';
import 'package:tools_flutter_project/tools/http/http_response.dart';

class QrLoginApiCtl {
  Future<HttpResponse<bool>> setUser(
      {required String userId, required String qrCode}) async {
    try {
      var res = await WebRequest.nativRequest(
        verbe: RequestVerbeEnum.POST,
        "http://148.113.143.59:8081/api/v1/auth/qrLogin/setUser",
        body: {"qrCode": qrCode}.parseToJson(),
        headers: AppHttpHeaders.authHeaders,
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
