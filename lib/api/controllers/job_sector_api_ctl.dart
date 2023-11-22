import 'package:lebedoo_assets/tools/web/app_http_hearders.dart';
import 'package:lebedoo_assets/tools/web/web_request.dart';

import 'package:tools_flutter_project/tools/http/http_response.dart';

import '../../models/job/jobs_sector.dart';
import '../../tools/const/const.dart';

class JobSectorApiCtrl {
  Future<HttpResponse<List<JobSector>>> getJobSectors() async {
    try {
      var url = "${Const.jobBaseUrl}/activity-sectors";
      var res =
          await WebRequest.nativRequest(url, headers: AppHttpHeaders.headers);

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
