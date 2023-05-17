import 'package:wan_mobile/api/abstracts/http_client_const.dart';
import 'package:wan_mobile/api/abstracts/web_controller.dart';
import 'package:wan_mobile/models/security_question.dart';
import 'package:wan_mobile/tools/utils/http_response.dart';

class SecurityQuestionCtl extends WebController {
  Future<HttpResponse<List<SecurityQuestion>>> getAll() async {
    try {
      var res = await get(
        HttpClientConst.baseUrl(module: "security-questions"),
        headers: HttpClientConst.headers,
      );

      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        return HttpResponse.success(
          data: (body.data as List)
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
