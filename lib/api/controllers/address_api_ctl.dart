import 'dart:developer';

import 'package:wan_mobile/models/address/address_type.dart';
import 'package:wan_mobile/models/pressing/pressing.dart';
import 'package:wan_mobile/models/pressing/pressing_article.dart';
import 'package:wan_mobile/models/pressing/pressing_service.dart';
import 'package:wan_mobile/models/pressing/user_localisation.dart';
import 'package:wan_mobile/tools/types/types.dart';

import '../../models/pressing/pressing_article_category.dart';
import '../../tools/const/const.dart';
import '../../tools/utils/http_response.dart';
import '../abstracts/http_client_const.dart';
import '../abstracts/web_controller.dart';

class AddressApiCtl extends WebController {
  Future<HttpResponse<List<UserLocalisation>>> getCustomerAddress(
      {required String customerId}) async {
    try {
      var url =
          "${Const.pressingBaseUrl}/localisation/user/$customerId";
      print(url);
      var res = await get(url, headers: HttpClientConst.headers);
      log(res.bodyString!);
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        return HttpResponse.success(
            data:
                (body.data as List).map((e) => UserLocalisation.fromJson(e)).toList());
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e) {
      return HttpResponse.error(detailErrors: e.toString());
    }
  }

  Future<HttpResponse<List<AddressType>>> getAddressType() async {
    try {
      var url =
          "${Const.pressingBaseUrl}/localisation/type";
      print(url);
      var res = await get(url, headers: HttpClientConst.headers);
      log(res.bodyString!);
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        return HttpResponse.success(
            data:
            (body.data as List).map((e) => AddressType.fromJson(e)).toList());
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e) {
      return HttpResponse.error(detailErrors: e.toString());
    }
  }
}
