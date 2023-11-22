import 'dart:convert';
import 'dart:developer';

import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:lebedoo_assets/tools/web/app_http_hearders.dart';
import 'package:lebedoo_assets/tools/web/web_request.dart';

import 'package:wan_mobile/models/job/add_job.dart';
import 'package:wan_mobile/models/job/apply_job.dart';
import 'package:tools_flutter_project/tools/http/http_response.dart';
import 'package:wan_mobile/tools/types/types.dart';

import '../../models/job/job_offer.dart';
import '../../tools/const/const.dart';

class JobApiCtrl {
  Future<HttpResponse<List<JobOffer>>> getAllJobs({String? customerId}) async {
    try {
      var url = "${Const.jobBaseUrl}/jobs";
      if (customerId != null) {
        url += "/customers/$customerId";
      }

      var res =
          await WebRequest.nativRequest(url, headers: AppHttpHeaders.headers);
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

  Future<HttpResponse<List<JobOffer>>> getAllJobByCategory(
      int categoryId) async {
    try {
      var url = "${Const.jobBaseUrl}/jobs/category/$categoryId";

      var res =
          await WebRequest.nativRequest(url, headers: AppHttpHeaders.headers);
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

      var res =
          await WebRequest.nativRequest(url, headers: AppHttpHeaders.headers);
      var body = HttpResponse.decodeBody(res);

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
      var res = await WebRequest.nativRequest(
        verbe: RequestVerbeEnum.POST,
        "${Const.jobBaseUrl}/jobs",
        body: addJob.toJson().parseToJson(),
        headers: AppHttpHeaders.authHeaders,
      );

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

  Future<HttpResponse> updateJob(AddJob addJob) async {
    try {
      var res = await WebRequest.nativRequest(
        verbe: RequestVerbeEnum.PUT,
        "${Const.jobBaseUrl}/jobs",
        body: addJob.toJson().parseToJson(),
        headers: AppHttpHeaders.authHeaders,
      );

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

      log(jsonEncode(applyJob.toJson()));
      var res = await WebRequest.nativRequest(
        verbe: RequestVerbeEnum.POST,
        url,
        body: applyJob.toJson().parseToJson(),
        headers: AppHttpHeaders.headers,
      );

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

      var res = await WebRequest.nativRequest(
        verbe: RequestVerbeEnum.DELETE,
        url,
        headers: AppHttpHeaders.headers,
      );

      var body = HttpResponse.decodeBody(res);

      if (body.status) {
        return HttpResponse.success(data: JobOffer());
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e) {
      return HttpResponse.error(detailErrors: e.toString());
    }
  }

  Future<HttpResponse<List<ApplyJob>>> getJobApplications(
      int jobOfferId) async {
    try {
      var url = "${Const.jobBaseUrl}/jobs/$jobOfferId/applications";

      var res =
          await WebRequest.nativRequest(url, headers: AppHttpHeaders.headers);
      var body = HttpResponse.decodeBody(res);

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
}
