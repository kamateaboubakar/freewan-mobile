import 'package:lebedoo_assets/tools/web/app_http_hearders.dart';
import 'package:lebedoo_assets/tools/web/web_request.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/models/address/address_type.dart';
import 'package:wan_mobile/models/pressing/user_localisation.dart';
import '../../tools/const/const.dart';

class AddressApiCtl {
  Future<HttpResponse<List<UserLocalisation>>> getCustomerAddress(
      {required String customerId}) async {
    try {
      var url = "${Const.pressingBaseUrl}/localisation/user/$customerId";
      var res =
          await WebRequest.nativRequest(url, headers: AppHttpHeaders.headers);
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        return HttpResponse.success(
            data: (body.data as List)
                .map((e) => UserLocalisation.fromJson(e))
                .toList());
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e) {
      return HttpResponse.error(detailErrors: e.toString());
    }
  }

  Future<HttpResponse<List<AddressType>>> getAddressType() async {
    try {
      var url = "${Const.pressingBaseUrl}/localisation/type";
      var res =
          await WebRequest.nativRequest(url, headers: AppHttpHeaders.headers);
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        return HttpResponse.success(
            data: (body.data as List)
                .map((e) => AddressType.fromJson(e))
                .toList());
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e) {
      return HttpResponse.error(detailErrors: e.toString());
    }
  }
}
