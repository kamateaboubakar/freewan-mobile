import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:lebedoo_assets/tools/web/app_http_hearders.dart';
import 'package:lebedoo_assets/tools/web/web_request.dart';
import 'package:tools_flutter_project/tools/http/http_response.dart';

class PubApiCtl {
  Future<HttpResponse<List<Img>>> getAll() async {
    try {
      var res = await WebRequest(
        body: const BodyObject(
          service: "api/v1/pubs/all",
          port: 8088,
        ),
        displayRequest: true,
        headers: AppHttpHeaders.authHeaders,
      ).send();
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        return HttpResponse.success(
          data:
              (body.data["data"] as List).map((e) => Img.fromJson(e)).toList(),
        );
      }
      return HttpResponse.error(message: body.message);
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }
}
