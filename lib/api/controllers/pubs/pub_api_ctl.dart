import 'package:wan_mobile/api/abstracts/http_client_const.dart';
import 'package:wan_mobile/api/abstracts/web_controller.dart';
import 'package:wan_mobile/models/pubs/pub.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/http_response.dart';

class PubApiCtl extends WebController {
  Future<HttpResponse<List<Pub>>> getAll() async {
    try {
      var res = await post(
        HttpClientConst.baseUrl(module: "external"),
        {
          "verbe": "GET",
          "port": "8088",
          "service": "api/v1/pubs/all",
        }.parseToJson(),
        headers: HttpClientConst.authHeaders,
      );
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        return HttpResponse.success(
          data:
              (body.data["data"] as List).map((e) => Pub.fromJson(e)).toList(),
        );
      }
      return HttpResponse.error(message: body.message);
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }
}
