import 'package:wan_mobile/api/abstracts/http_client_const.dart';
import 'package:wan_mobile/api/abstracts/web_controller.dart';
import 'package:wan_mobile/models/job/contract_type.dart';
import 'package:wan_mobile/models/job/work_experience.dart';
import 'package:wan_mobile/tools/utils/http_response.dart';

import '../../tools/const/const.dart';

class WorkExperienceApiCtl extends WebController {
  Future<HttpResponse<List<WorkExperience>>> getWorkExperiences() async {
    try {
      var url = "${Const.jobBaseUrl}/work-experiences";
      var res = await get(url, headers: HttpClientConst.headers);
      var body = HttpResponse.decodeBody(res);

      if (body.status) {
        return HttpResponse.success(
            data: (body.data as List)
                .map((e) => WorkExperience.fromJson(e))
                .toList());
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e) {
      return HttpResponse.error(detailErrors: e.toString());
    }
  }
}
