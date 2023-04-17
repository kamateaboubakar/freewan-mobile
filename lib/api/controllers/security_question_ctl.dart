import 'package:wan_mobile/api/abstracts/web_controller.dart';
import 'package:wan_mobile/models/pays.dart';
import 'package:wan_mobile/models/security_question.dart';
import 'package:wan_mobile/tools/utils/http_response.dart';

class SecurityQuestionCtl extends WebController {
  Future<HttpResponse<List<SecurityQuestion>>> getAll() async {
    try {
      var response = await client.get(baseUrl(module: "security-questions"));
      var body = HttpResponse.decodeBody(response);
      if (body.status) {
        return HttpResponse.success(
            data: (body.data as List)
                .map((e) => SecurityQuestion.fromJson(e))
                .toList());
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e) {
      return HttpResponse.error(detailErrors: e.toString());
    }
  }
}
