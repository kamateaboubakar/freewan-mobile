import 'package:module_master/const/const.dart';
import 'package:wan_mobile/api/abstracts/http_client_const.dart';
import 'package:wan_mobile/api/abstracts/web_controller.dart';
import 'package:wan_mobile/models/construction/categorie_materiau_construction.dart';
import 'package:wan_mobile/models/construction/material_unit.dart';

import 'package:wan_mobile/tools/utils/http_response.dart';

class ConstructionApiCtl extends WebController {
  Future<HttpResponse<List<CategorieMateriauConstruction>>>
      getAllCategorieMateriauConstruction() async {
    try {
      var response = await get("${Const.constructionBaseUrl}/categories",
          headers: HttpClientConst.authHeaders);
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
      var response = await get("${Const.constructionBaseUrl}/categories",
          headers: HttpClientConst.authHeaders);
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
