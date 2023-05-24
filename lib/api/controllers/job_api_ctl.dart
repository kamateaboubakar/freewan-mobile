import 'package:wan_mobile/api/abstracts/http_client_const.dart';
import 'package:wan_mobile/api/abstracts/web_controller.dart';
import 'package:wan_mobile/models/job/add_job.dart';
import 'package:wan_mobile/models/job/contract_type.dart';
import 'package:wan_mobile/tools/utils/http_response.dart';

import '../../models/job/company.dart';
import '../../models/job/job_offer.dart';
import '../../models/job/jobs_sector.dart';
import '../../tools/const/const.dart';

class JobApiCtrl extends WebController {
  Future<HttpResponse<List<JobOffer>>> getAllJobs() async {
    try {
      var url = "${Const.jobBaseUrl}/jobs";
      var res = await get(url, headers: HttpClientConst.headers);
      var body = HttpResponse.decodeBody(res);

      if (body.status) {
        return HttpResponse.success(
            data:
                (body.data as List).map((e) => JobOffer.fromJson(e)).toList());
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e) {
      return HttpResponse.error(detailErrors: e.toString());
    }
  }

  Future<HttpResponse> addJob(AddJob addJob) async {
    print('body ${addJob.toJson()}');
    try {
      var res = await post(
        "${Const.jobBaseUrl}/jobs",
        addJob.toJson(),
        headers: HttpClientConst.headers,
      );

      print(res.body);

      var body = HttpResponse.decodeBody(res);

      if (body.status) {
        return HttpResponse.success(data: addJob);
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e) {
      return HttpResponse.error(detailErrors: e.toString());
    }
  }
}
