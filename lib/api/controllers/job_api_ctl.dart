import 'dart:convert';
import 'dart:developer';

import 'package:wan_mobile/api/abstracts/http_client_const.dart';
import 'package:wan_mobile/api/abstracts/web_controller.dart';
import 'package:wan_mobile/models/job/add_job.dart';
import 'package:wan_mobile/models/job/apply_job.dart';
import 'package:wan_mobile/tools/utils/http_response.dart';

import '../../models/job/job_offer.dart';
import '../../tools/const/const.dart';

class JobApiCtrl extends WebController {
  Future<HttpResponse<List<JobOffer>>> getAllJobs({String? customerId}) async {
    try {
      var url = "${Const.jobBaseUrl}/jobs";
      if (customerId != null) {
        url += "/customers/$customerId";
      }

      var res = await get(url, headers: HttpClientConst.headers);
      var body = HttpResponse.decodeBody(res);

      log(jsonEncode(body.data));

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

  Future<HttpResponse<List<ApplyJob>>> getJobApplied(
      [String? customerId]) async {
    try {
      var url = "${Const.jobBaseUrl}/jobs/applications/customers/$customerId";

      print('url $url');
      var res = await get(url, headers: HttpClientConst.headers);
      var body = HttpResponse.decodeBody(res);

      print('response');

      log(jsonEncode(body.data));

      if (body.status) {
        return HttpResponse.success(
            data:
                (body.data as List).map((e) => ApplyJob.fromJson(e)).toList());
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e) {
      return HttpResponse.error(detailErrors: e.toString());
    }
  }

  Future<HttpResponse> addJob(AddJob addJob) async {
    try {
      var res = await post(
        "${Const.jobBaseUrl}/jobs",
        addJob.toJson(),
        headers: HttpClientConst.headers,
      );

      print(addJob.toJson());

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

  Future<HttpResponse> applyToJob({
    required ApplyJob applyJob,
    required JobOffer jobOffer,
  }) async {
    try {
      String url = "${Const.jobBaseUrl}/jobs/${jobOffer.id!}/apply";
      print(url);

      log(jsonEncode(applyJob.toJson()));
      var res = await post(
        url,
        applyJob.toJson(),
        headers: HttpClientConst.headers,
      );

      print(res.body);

      var body = HttpResponse.decodeBody(res);

      if (body.status) {
        return HttpResponse.success(data: applyJob);
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e) {
      return HttpResponse.error(detailErrors: e.toString());
    }
  }

  Future<HttpResponse> deleteJobOffer(int id) async {
    try {
      var url = "${Const.jobBaseUrl}/jobs/$id";

      print('url $url');
      var res = await delete(url, headers: HttpClientConst.headers);
      var body = HttpResponse.decodeBody(res);

      print('response delete');

      print(body.data);

      if (body.status) {
        return HttpResponse.success(
            data: JobOffer());
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e) {
      return HttpResponse.error(detailErrors: e.toString());
    }
  }
}
