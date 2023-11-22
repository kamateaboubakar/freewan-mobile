import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:lebedoo_assets/tools/web/app_http_hearders.dart';
import 'package:lebedoo_assets/tools/web/web_request.dart';

import 'package:tools_flutter_project/tools/http/http_response.dart';

class SecurityQuestionCtl {
  Future<HttpResponse<List<SecurityQuestion>>> getAll() async {
    try {
      var res = await WebRequest.nativRequest(
        AppHttpHeaders.baseUrl(module: "security-questions/all"),
        headers: AppHttpHeaders.headers,
      );

      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        return HttpResponse.success(
          data: (body.data["data"] as List)
              .map((e) => SecurityQuestion.fromJson(e))
              .toList(),
        );
      } else {
        return HttpResponse.error();
      }
    } catch (e) {
      return HttpResponse.error(detailErrors: e.toString());
    }
  }
}
