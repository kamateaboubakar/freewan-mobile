import 'package:wan_mobile/models/gas_size.dart';
import 'package:wan_mobile/models/shop.dart';
import 'package:wan_mobile/tools/types/types.dart';

import '../../tools/const/const.dart';
import '../../tools/utils/http_response.dart';
import '../abstracts/http_client_const.dart';
import '../abstracts/web_controller.dart';

class GazApiCtl extends WebController {
  Future<HttpResponse<List<Shop>>> getClosestShop(
      {required double latitude, required double longitude}) async {
    try {
      var url =
          "${Const.gazBaseUrl}/shops/closests?latitude=$latitude&longitude=$longitude";
      var res = await get(url, headers: HttpClientConst.headers);
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
      var res = await get("${Const.gazBaseUrl}/shops/$id",
          headers: HttpClientConst.headers);
      var body = HttpResponse.decodeBody(res);

      if (body.status) {
        return HttpResponse.success(data: Shop.fromJson(body.data));
      } else {
        return HttpResponse.error(message: body.message);
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
      var res = await get(
          "${Const.gazBaseUrl}/brandsInShop/gasSizes?shop_id=$shopId&brand_id=$brandId",
          headers: HttpClientConst.headers);
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
      var res = await post(url, requestBody.toJson(),
          headers: {"Content-Type": "application/form-data"});
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
