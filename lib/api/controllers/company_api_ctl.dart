import 'dart:convert';
import 'dart:developer';

import 'package:wan_mobile/api/abstracts/http_client_const.dart';
import 'package:wan_mobile/api/abstracts/web_controller.dart';
import 'package:wan_mobile/tools/utils/http_response.dart';

import '../../models/job/company.dart';
import '../../tools/const/const.dart';

class CompanyApiCtl extends WebController {
  Future<HttpResponse<Company>> createCompany(Company newCompany) async {
    log(jsonEncode(newCompany.toJson()));

    try {
      var url = "${Const.jobBaseUrl}/companies";
      var res = await post(
        url,
        newCompany.toJson(),
        headers: HttpClientConst.headers,
      );

      print('company response');
      print(res.body);

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
}
