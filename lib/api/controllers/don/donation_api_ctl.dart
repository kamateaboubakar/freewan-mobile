import 'dart:io';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:lebedoo_assets/tools/web/app_http_hearders.dart';
import 'package:lebedoo_assets/tools/web/web_request.dart';

import 'package:wan_mobile/models/don/campagne.dart';
import 'package:wan_mobile/models/don/categorie_campagne.dart';
import 'package:wan_mobile/models/don/organization.dart';
import 'package:wan_mobile/models/fichier.dart';
import 'package:wan_mobile/tools/const/const.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:tools_flutter_project/tools/http/http_response.dart';

class DonationApiCtl {
  Future<HttpResponse<List<Campagne>>> getAllCampagneByCategorie(
      int catId) async {
    try {
      var res = await WebRequest.nativRequest(
          "${Const.donationBaseUrl}/campaigns/category/$catId",
          headers: AppHttpHeaders.authHeaders);
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
      var res = await WebRequest.nativRequest(
          "${Const.donationBaseUrl}/campaigns",
          headers: AppHttpHeaders.authHeaders);
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
      var res = await WebRequest.nativRequest(
          "${Const.donationBaseUrl}/campaigns/customers/$userId",
          headers: AppHttpHeaders.authHeaders);
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
      var res = await WebRequest.nativRequest(
          "${Const.donationBaseUrl}/organizations",
          headers: AppHttpHeaders.authHeaders);
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
      var res = await WebRequest.nativRequest(
          "${Const.donationBaseUrl}/organizations/customers/$customerAccountId",
          headers: AppHttpHeaders.authHeaders);
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
      var res = await WebRequest.nativRequest(
          "${Const.donationBaseUrl}/categories",
          headers: AppHttpHeaders.authHeaders);
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
      var res = await WebRequest.nativRequest(
          verbe: RequestVerbeEnum.POST,
          "${Const.donationBaseUrl}/campaigns",
          body: campagne.toJson().parseToJson(),
          headers: AppHttpHeaders.authHeaders);
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
      var res = await WebRequest.nativRequest(
          verbe: RequestVerbeEnum.PUT,
          "${Const.donationBaseUrl}/campaigns",
          body: campagne.toJson().parseToJson(),
          headers: AppHttpHeaders.authHeaders);
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
      var response = await WebRequest.multipartRequest(
        url: "${Const.donationBaseUrl}/files/upload",
        verbe: RequestVerbeEnum.POST,
        headers: AppHttpHeaders.authMultipartHeaders,
        files: [fichier],
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var body = HttpResponse.decodeBody(response);
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
      var res = await WebRequest.nativRequest(
          verbe: RequestVerbeEnum.POST,
          "${Const.donationBaseUrl}/organizations",
          body: organization.toJson().parseToJson(),
          headers: AppHttpHeaders.authHeaders);
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
      var res = await WebRequest.nativRequest(
          verbe: RequestVerbeEnum.PUT,
          "${Const.donationBaseUrl}/organizations",
          body: organization.toJson().parseToJson(),
          headers: AppHttpHeaders.authHeaders);
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
