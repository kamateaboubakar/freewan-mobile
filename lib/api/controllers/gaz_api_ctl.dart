import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:lebedoo_assets/tools/web/web_request.dart';
import 'package:tools_flutter_project/tools/http/http_response.dart';
import 'package:wan_mobile/models/gas_size.dart';
import 'package:wan_mobile/models/shop.dart';
import 'package:wan_mobile/tools/types/types.dart';
import '../../tools/const/const.dart';
import 'package:lebedoo_assets/tools/web/app_http_hearders.dart';

class GazApiCtl {
  Future<HttpResponse<List<Shop>>> getClosestShop(
      {required double latitude, required double longitude}) async {
    try {
      var url =
          "${Const.gazBaseUrl}/shops/closests?latitude=$latitude&longitude=$longitude";
      var res =
          await WebRequest.nativRequest(url, headers: AppHttpHeaders.headers);
      var body = HttpResponse.decodeBody(res);

      if (body.status) {
        return HttpResponse.success(
            data: (body.data as List).map((e) => Shop.fromJson(e)).toList());
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e) {
      return HttpResponse.error(detailErrors: e.toString());
    }
  }

  Future<HttpResponse<Shop>> getShopById({required int id}) async {
    try {
      if (id > 0) {
        var res = await WebRequest.nativRequest("${Const.gazBaseUrl}/shops/$id",
            headers: AppHttpHeaders.headers);
        var body = HttpResponse.decodeBody(res);

        if (body.status) {
          return HttpResponse.success(data: Shop.fromJson(body.data));
        } else {
          return HttpResponse.error(message: body.message);
        }
      } else {
        return HttpResponse.error(
            message: "L'identifiant doit être supérieur à 0");
      }
    } catch (e) {
      return HttpResponse.error(detailErrors: e.toString());
    }
  }

  Future<HttpResponse<List<GasSize>>> getGasSize({
    required int shopId,
    required int brandId,
  }) async {
    try {
      var res = await WebRequest.nativRequest(
          "${Const.gazBaseUrl}/brandsInShop/gasSizes?shop_id=$shopId&brand_id=$brandId",
          headers: AppHttpHeaders.headers);
      var body = HttpResponse.decodeBody(res);

      if (body.status) {
        return HttpResponse.success(
            data: (body.data as List).map((e) => GasSize.fromJson(e)).toList());
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e) {
      return HttpResponse.error(detailErrors: e.toString());
    }
  }

  Future<HttpResponse<bool>> submitOrder({
    required int brandInShopId,
    required String customerSessionId,
    required int customerAddressId,
    required double latitude,
    required double longitude,
    required int targetId,
    required int price,
  }) async {
    try {
      var requestBody = {
        "brandInShopId": "$brandInShopId",
        "customerSessionId": customerSessionId,
        "customerAddressId": "$customerAddressId",
        "latitude": "$latitude",
        "longitude": "$longitude",
        "targetId": "$targetId",
        "price": "$price"
      };

      var url = "${Const.gazBaseUrl}/orders/";
      var res = await WebRequest.nativRequest(
          verbe: RequestVerbeEnum.POST,
          url,
          body: requestBody.parseToJson(),
          headers: AppHttpHeaders.headers);
      var body = HttpResponse.decodeBody(res);

      if (body.status) {
        if (body.data != null) {
          return HttpResponse.success(data: true);
        }
        return HttpResponse.success(data: false);
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }
}
