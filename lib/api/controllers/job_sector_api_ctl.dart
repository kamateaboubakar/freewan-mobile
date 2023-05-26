import 'package:wan_mobile/api/abstracts/http_client_const.dart';
import 'package:wan_mobile/api/abstracts/web_controller.dart';
import 'package:wan_mobile/models/job/add_job.dart';
import 'package:wan_mobile/models/job/contract_type.dart';
import 'package:wan_mobile/tools/utils/http_response.dart';

import '../../models/job/company.dart';
import '../../models/job/jobs_sector.dart';
import '../../tools/const/const.dart';

class JobSectorApiCtrl extends WebController {
  Future<HttpResponse<List<JobSector>>> getJobSectors() async {
    try {
      var url = "${Const.jobBaseUrl}/activity-sectors";
      var res = await get(url, headers: HttpClientConst.headers);

      var body = HttpResponse.decodeBody(res);

      if (body.status) {
        return HttpResponse.success(
            data:
                (body.data as List).map((e) => JobSector.fromJson(e)).toList());
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e) {
      return HttpResponse.error(detailErrors: e.toString());
    }
  }
}
