import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:lebedoo_assets/tools/web/app_http_hearders.dart';
import 'package:lebedoo_assets/tools/web/web_request.dart';

import 'package:tools_flutter_project/tools/http/http_response.dart';
import 'package:tools_flutter_project/tools/types/map.dart';

import '../../models/job/company.dart';
import '../../tools/const/const.dart';

class CompanyApiCtl {
  Future<HttpResponse<Company>> createCompany(Company newCompany) async {
    try {
      var url = "${Const.jobBaseUrl}/companies";
      var res = await WebRequest.nativRequest(
        verbe: RequestVerbeEnum.POST,
        url,
        body: newCompany.toJson().parseToJson(),
        headers: AppHttpHeaders.headers,
      );

      var body = HttpResponse.decodeBody(res);

      if (body.status) {
        return HttpResponse.success(data: Company.fromJson(body.data));
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
      var res =
          await WebRequest.nativRequest(url, headers: AppHttpHeaders.headers);

      var body = HttpResponse.decodeBody(res);

      if (body.status) {
        return HttpResponse.success(
            data: (body.data as List).map((e) => Company.fromJson(e)).toList());
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e) {
      return HttpResponse.error(detailErrors: e.toString());
    }
  }
}
