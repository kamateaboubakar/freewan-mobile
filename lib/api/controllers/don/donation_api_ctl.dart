import 'dart:io';
import 'package:module_master/const/const.dart';
import 'package:wan_mobile/api/abstracts/http_client_const.dart';
import 'package:wan_mobile/api/abstracts/web_controller.dart';
import 'package:wan_mobile/models/don/campagne.dart';
import 'package:wan_mobile/models/don/categorie_campagne.dart';
import 'package:wan_mobile/models/don/organization.dart';
import 'package:wan_mobile/models/fichier.dart';

import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/http_response.dart';

class DonationApiCtl extends WebController {
  Future<HttpResponse<List<Campagne>>> getAllCampagneByCategorie(
      int catId) async {
    try {
      var res = await get("${Const.donationBaseUrl}/campaigns/category/$catId",
          headers: HttpClientConst.authHeaders);
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        return HttpResponse.success(
            data:
                (body.data as List).map((e) => Campagne.fromJson(e)).toList());
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  Future<HttpResponse<List<Campagne>>> getAllCampagne() async {
    try {
      var res = await get("${Const.donationBaseUrl}/campaigns",
          headers: HttpClientConst.authHeaders);
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        return HttpResponse.success(
            data:
                (body.data as List).map((e) => Campagne.fromJson(e)).toList());
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  Future<HttpResponse<List<Campagne>>> getAllUserCampagne(String userId) async {
    try {
      var res = await get(
          "${Const.donationBaseUrl}/campaigns/customers/$userId",
          headers: HttpClientConst.authHeaders);
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        return HttpResponse.success(
            data:
                (body.data as List).map((e) => Campagne.fromJson(e)).toList());
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  Future<HttpResponse<List<Organization>>> getAllOrganization() async {
    try {
      var res = await get("${Const.donationBaseUrl}/organizations",
          headers: HttpClientConst.authHeaders);
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        return HttpResponse.success(
            data: (body.data as List)
                .map((e) => Organization.fromJson(e))
                .toList());
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  Future<HttpResponse<List<Organization>>> getAllUserOrganization(
      String customerAccountId) async {
    try {
      var res = await get(
          "${Const.donationBaseUrl}/organizations/customers/$customerAccountId",
          headers: HttpClientConst.authHeaders);
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        return HttpResponse.success(
            data: (body.data as List)
                .map((e) => Organization.fromJson(e))
                .toList());
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  Future<HttpResponse<List<CategorieCampagne>>> getAllCategorie() async {
    try {
      var res = await get("${Const.donationBaseUrl}/categories",
          headers: HttpClientConst.authHeaders);
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        return HttpResponse.success(
            data: (body.data as List)
                .map((e) => CategorieCampagne.fromJson(e))
                .toList());
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  Future<HttpResponse<bool>> createCampagne(Campagne campagne) async {
    try {
      var res = await post(
          "${Const.donationBaseUrl}/campaigns", campagne.toJson().parseToJson(),
          headers: HttpClientConst.authHeaders);
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        return HttpResponse.success(data: true);
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  Future<HttpResponse<bool>> updateCampagne(Campagne campagne) async {
    try {
      var res = await put(
          "${Const.donationBaseUrl}/campaigns", campagne.toJson().parseToJson(),
          headers: HttpClientConst.authHeaders);
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        return HttpResponse.success(data: true);
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  Future<HttpResponse<Fichier>> uploadFile(File fichier) async {
    try {
      var request = await multiPartclient(
        "POST",
        Uri.parse("${Const.donationBaseUrl}/files/upload"),
        headers: HttpClientConst.authMultipartHeaders,
        files: [fichier],
      );

      var response = await request.send();
      if (response.statusCode >= 200 && response.statusCode < 300) {
        var body = await HttpResponse.decodeMultipartBody(response);
        return HttpResponse.success(data: Fichier.fromJson(body.data));
      } else {
        return HttpResponse.error(
            message: "Une erreur est survenue lors du téléchargement");
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  Future<HttpResponse<bool>> createOrganization(
      Organization organization) async {
    try {
      var res = await post("${Const.donationBaseUrl}/organizations",
          organization.toJson().parseToJson(),
          headers: HttpClientConst.authHeaders);
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        return HttpResponse.success(data: true);
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  Future<HttpResponse<bool>> updateOrganisation(
      Organization organization) async {
    try {
      var res = await put("${Const.donationBaseUrl}/organizations",
          organization.toJson().parseToJson(),
          headers: HttpClientConst.authHeaders);
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        return HttpResponse.success(data: true);
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }
}
