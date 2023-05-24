import 'package:wan_mobile/api/abstracts/http_client_const.dart';
import 'package:wan_mobile/api/abstracts/web_controller.dart';
import 'package:wan_mobile/models/job/add_job.dart';
import 'package:wan_mobile/models/job/contract_type.dart';
import 'package:wan_mobile/models/security_question.dart';
import 'package:wan_mobile/models/user.dart';
import 'package:wan_mobile/tools/types/types.dart';

import 'package:wan_mobile/tools/utils/http_response.dart';
import 'package:wan_mobile/views/controllers/job/job_sector_vctl.dart';

import '../../models/job/company.dart';
import '../../models/job/jobs_offer.dart';
import '../../models/job/jobs_sector.dart';
import '../../tools/const/const.dart';

class JobApiCtrl extends WebController {
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

  Future<HttpResponse<List<JobOffer>>> getAllJobs() async {
    try {
      //todo decommenter
      /*var url = "${Const.jobBaseUrl}/jobs";
      var res = await get(url, headers: HttpClientConst.headers);
      var body = HttpResponse.decodeBody(res);

      if (body.status) {
        return HttpResponse.success(
            data:
                (body.data as List).map((e) => JobOffer.fromJson(e)).toList());
      } else {
        return HttpResponse.error(message: body.message);
      }*/
      await Future.delayed(Duration(seconds: 2));
      return HttpResponse.success(data: jobs);
    } catch (e) {
      return HttpResponse.error(detailErrors: e.toString());
    }
  }

  Future<HttpResponse<List<ContractType>>> getContractTypes() async {
    try {
      var url = "${Const.jobBaseUrl}/contract-types";
      var res = await get(url, headers: HttpClientConst.headers);
      var body = HttpResponse.decodeBody(res);

      if (body.status) {
        return HttpResponse.success(
            data: (body.data as List)
                .map((e) => ContractType.fromJson(e))
                .toList());
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e) {
      return HttpResponse.error(detailErrors: e.toString());
    }
  }

  Future<HttpResponse<List<Company>>> getCompanies() async {
    try {
      var url = "${Const.jobBaseUrl}/companies";
      var res = await get(url, headers: HttpClientConst.headers);

      print(res.body);

      var body = HttpResponse.decodeBody(res);

      if (body.status) {
        return HttpResponse.success(
            data: (body.data as List).map((e) => Company.fromJson(e)).toList());
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e) {
      print("company exception");
      print(e);
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
