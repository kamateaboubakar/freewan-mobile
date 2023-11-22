import 'dart:developer';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:lebedoo_assets/tools/web/web_request.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/models/pressing/pressing.dart';
import 'package:wan_mobile/models/pressing/pressing_article.dart';
import 'package:wan_mobile/models/pressing/pressing_service.dart';
import 'package:wan_mobile/tools/types/types.dart';
import '../../models/pressing/pressing_article_category.dart';
import '../../models/pressing/user_localisation.dart';
import '../../tools/const/const.dart';
import 'package:lebedoo_assets/tools/web/app_http_hearders.dart';

class PressingApiCtl {
  User user = AppHttpHeaders.user;
  Future<HttpResponse<List<Pressing>>> getClosestPressings(
      {required double latitude, required double longitude}) async {
    try {
      var url =
          "${Const.pressingBaseUrl}/pressing/nearest/$latitude/$longitude";

      var res =
          await WebRequest.nativRequest(url, headers: AppHttpHeaders.headers);
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

      var res =
          await WebRequest.nativRequest(url, headers: AppHttpHeaders.headers);
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
      var res =
          await WebRequest.nativRequest(url, headers: AppHttpHeaders.headers);
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
      var res = await WebRequest.nativRequest(
        verbe: RequestVerbeEnum.POST,
        url,
        body: {
          "services": selectedServices.map((e) => e.id!).toList(),
          "items": articles.map((e) => e.id!).toList()
        }.parseToJson(),
        headers: AppHttpHeaders.headers,
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
      "customer_id": AppHttpHeaders.user.id,
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
        "customer_id": AppHttpHeaders.user.id,
        "latitude": userLocalisation.latitude!,
        "longitude": userLocalisation.longitude!,
        "localisation_type": userLocalisation.localisationType!.id!,
      }
    };

    var res = await WebRequest.nativRequest(
      verbe: RequestVerbeEnum.POST,
      url,
      body: requestBody.parseToJson(),
      headers: AppHttpHeaders.headers,
    );
    log(res.bodyString!);
    var body = HttpResponse.decodeBody(res);
    if (body.status) {
      return HttpResponse.success(data: []);
    } else {
      return HttpResponse.error(message: body.message);
    }
  }
}
