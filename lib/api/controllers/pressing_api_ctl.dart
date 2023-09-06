import 'dart:developer';

import 'package:wan_mobile/models/pressing/pressing.dart';
import 'package:wan_mobile/models/pressing/pressing_article.dart';
import 'package:wan_mobile/models/pressing/pressing_service.dart';
import 'package:wan_mobile/tools/types/types.dart';

import '../../models/pressing/pressing_article_category.dart';
import '../../models/pressing/user_localisation.dart';
import '../../tools/const/const.dart';
import '../../tools/utils/http_response.dart';
import '../abstracts/http_client_const.dart';
import '../abstracts/web_controller.dart';

class PressingApiCtl extends WebController {
  Future<HttpResponse<List<Pressing>>> getClosestPressings(
      {required double latitude, required double longitude}) async {
    try {
      var url =
          "${Const.pressingBaseUrl}/pressing/nearest/$latitude/$longitude";
      print(url);
      var res = await get(url, headers: HttpClientConst.headers);
      log(res.bodyString!);
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        return HttpResponse.success(
            data:
                (body.data as List).map((e) => Pressing.fromJson(e)).toList());
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e) {
      return HttpResponse.error(detailErrors: e.toString());
    }
  }

  Future<HttpResponse<List<PressingService>>> getPressingServices({
    required int pressingId,
  }) async {
    try {
      var url = "${Const.pressingBaseUrl}/services/pressing/$pressingId";
      print(url);
      var res = await get(url, headers: HttpClientConst.headers);
      log(res.bodyString!);
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        return HttpResponse.success(
            data: (body.data as List)
                .map((e) => PressingService.fromJson(e))
                .toList());
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e) {
      return HttpResponse.error(detailErrors: e.toString());
    }
  }

  Future<HttpResponse<List<PressingArticleCategory>>> getPressingArticles({
    required int pressingId,
  }) async {
    try {
      var url = "${Const.pressingBaseUrl}/commande/articleList/$pressingId";
      var res = await get(url, headers: HttpClientConst.headers);
      log(res.bodyString!);
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        return HttpResponse.success(
            data: (body.data as List)
                .map((e) => PressingArticleCategory.fromJson(e))
                .toList());
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e) {
      return HttpResponse.error(detailErrors: e.toString());
    }
  }

  Future<HttpResponse<List<PressingArticle>>> getUpdateArticlePrice(
    Pressing pressing,
    List<PressingService> selectedServices,
    List<PressingArticle> articles,
  ) async {
    try {
      var url = "${Const.pressingBaseUrl}/commande/prices/${pressing.id!}";
      var res = await post(
        url,
        {
          "services": selectedServices.map((e) => e.id!).toList(),
          "items": articles.map((e) => e.id!).toList()
        }.parseToJson(),
        headers: HttpClientConst.headers,
      );
      log(res.bodyString!);
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        return HttpResponse.success(
            data: (body.data as List)
                .map((e) => PressingArticle.fromJson(e))
                .toList());
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e) {
      return HttpResponse.error(detailErrors: e.toString());
    }
  }

  Future<HttpResponse<List<PressingArticle>>> submitOrder({
    required String recuperationDate,
    required double totalAmount,
    required int pressingId,
    required List<PressingService> services,
    required List<PressingArticle> articles,
    required UserLocalisation userLocalisation,
  }) async {
    var url = "${Const.pressingBaseUrl}/commande";
    var requestBody = {
      "customer_id": appCtl.user.id,
      "transaction_id": "TRANS-${DateTime.now().microsecondsSinceEpoch}",
      "asked_recuperation_date": recuperationDate,
      "fees": totalAmount,
      "pressing_id": pressingId,
      "services": services.map((e) => e.id).toList(),
      "cart": articles
          .map((e) => {"item_id": e.id!, "quantity": e.quantity!})
          .toList(),
      "customer_localisation": {
        "address": userLocalisation.address!,
        "customer_id": appCtl.user.id,
        "latitude": userLocalisation.latitude!,
        "longitude": userLocalisation.longitude!,
        "localisation_type": userLocalisation.localisationType!.id!,
      }
    };
    print(requestBody);
    var res = await post(
      url,
      requestBody.parseToJson(),
      headers: HttpClientConst.headers,
    );
    log(res.bodyString!);
    var body = HttpResponse.decodeBody(res);
    if (body.status) {
      return HttpResponse.success(data: []);
    } else {
      return HttpResponse.error(message: body.message);
    }

    try {
      var url = "${Const.pressingBaseUrl}/commande";
      var requestBody = {
        "customer_id": appCtl.user.id,
        "transaction_id": "TRANS-${DateTime.now().microsecondsSinceEpoch}",
        "asked_recuperation_date": recuperationDate,
        "fees": totalAmount,
        "pressing_id": pressingId,
        "services": services.map((e) => e.id).toList(),
        "cart": articles
            .map((e) => {"item_id": e.id!, "quantity": e.quantity!})
            .toList(),
        "customer_localisation": {
          "address": userLocalisation.address!,
          "customer_id": userLocalisation.customerId!,
          "latitude": userLocalisation.latitude!,
          "longitude": userLocalisation.longitude!,
          "localisation_type": userLocalisation.localisationType!.id!,
        }
      };
      print(requestBody);
      var res = await post(
        url,
        requestBody.parseToJson(),
        headers: HttpClientConst.headers,
      );
      log(res.bodyString!);
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        return HttpResponse.success(data: []);
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e) {
      return HttpResponse.error(detailErrors: e.toString());
    }
  }
}
