import 'package:lebedoo_assets/tools/web/app_http_hearders.dart';
import 'package:lebedoo_assets/tools/web/web_request.dart';

import 'package:wan_mobile/models/construction/categorie_materiau_construction.dart';
import 'package:wan_mobile/models/construction/material_unit.dart';
import 'package:wan_mobile/tools/const/const.dart';
import 'package:tools_flutter_project/tools/http/http_response.dart';

class ConstructionApiCtl {
  Future<HttpResponse<List<CategorieMateriauConstruction>>>
      getAllCategorieMateriauConstruction() async {
    try {
      var response = await WebRequest.nativRequest(
          "${Const.constructionBaseUrl}/categories",
          headers: AppHttpHeaders.authHeaders);
      var body = HttpResponse.decodeBody(response);
      if (body.status) {
        return HttpResponse.success(
            data: (body.data as List)
                .map((e) => CategorieMateriauConstruction.fromJson(e))
                .toList());
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e) {
      return HttpResponse.error();
    }
  }

  Future<HttpResponse<List<MaterialUnit>>> getMateriauByCategorie(
      {required int categorieId}) async {
    try {
      var response = await WebRequest.nativRequest(
          "${Const.constructionBaseUrl}/categories",
          headers: AppHttpHeaders.authHeaders);
      var body = HttpResponse.decodeBody(response);
      if (body.status) {
        return HttpResponse.success(
            data: (body.data as List)
                .map((e) => MaterialUnit.fromJson(e))
                .toList());
      }
      return HttpResponse.error(message: body.message);
    } catch (e) {
      return HttpResponse.error();
    }
  }
}
