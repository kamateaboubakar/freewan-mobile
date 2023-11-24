import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:lebedoo_assets/tools/web/app_http_hearders.dart';
import 'package:lebedoo_assets/tools/web/web_request.dart';
import 'package:tools_flutter_project/tools/types/map.dart';
import 'package:wan_mobile/api/abstracts/links.dart';

import 'package:wan_mobile/models/loyer/abstracts/bien_immobilier.dart';
import 'package:wan_mobile/models/loyer/abstracts/bloc_appartement.dart';
import 'package:wan_mobile/models/loyer/abstracts/habitat.dart';
import 'package:wan_mobile/models/loyer/appartement.dart';
import 'package:wan_mobile/models/loyer/maison.dart';
import 'package:wan_mobile/models/loyer/paiement_loyer.dart';
import 'package:wan_mobile/models/loyer/type_appartement.dart';

import 'package:tools_flutter_project/tools/http/http_response.dart';

class LoyerApiCtl {
  Future<HttpResponse<List<BlocAppartement>>> getBlocAppartementsByUser(
      String id) async {
    try {
      var res = await WebRequest.nativRequest(
        "${Links.loyer}/bienImmobiliers/blocAppartement/byOwner/$id",
        headers: AppHttpHeaders.headers,
      );

      var body = HttpResponse.decodeBody<List>(res);
      if (body.status) {
        return HttpResponse.success(
            data: body.data!.map((e) => BlocAppartement.fromJson(e)).toList());
      } else {
        return HttpResponse.error();
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  Future<HttpResponse<List<Maison>>> getMaisonsByUser(String id) async {
    try {
      var res = await WebRequest.nativRequest(
        "${Links.loyer}/bienImmobiliers/maison/byOwner/$id",
        headers: AppHttpHeaders.headers,
      );

      var body = HttpResponse.decodeBody<List>(res);
      if (body.status) {
        return HttpResponse.success(
            data: body.data!.map((e) => Maison.fromJson(e)).toList());
      } else {
        return HttpResponse.error();
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  Future<HttpResponse<BienImmobilier>> createBloc(
      BienImmobilier bienImmobilier) async {
    try {
      var res = await WebRequest.nativRequest(
        "${Links.loyer}/blocApparts/",
        verbe: RequestVerbeEnum.POST,
        body: bienImmobilier.toJson().parseToJson(),
        headers: AppHttpHeaders.headers,
      );

      var body = HttpResponse.decodeBody<Json>(res);
      if (body.status) {
        return HttpResponse.success(data: BienImmobilier.fromJson(body.data!));
      } else {
        return HttpResponse.error();
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  Future<HttpResponse<BienImmobilier>> createMaison(
      BienImmobilier bienImmobilier) async {
    try {
      var res = await WebRequest.nativRequest(
        verbe: RequestVerbeEnum.POST,
        "${Links.loyer}/bienImmobiliers/maison",
        body: bienImmobilier.toJson().parseToJson(),
        headers: AppHttpHeaders.headers,
      );

      var body = HttpResponse.decodeBody<Json>(res);
      if (body.status) {
        return HttpResponse.success(data: BienImmobilier.fromJson(body.data!));
      } else {
        return HttpResponse.error();
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  Future<HttpResponse<BienImmobilier>> updateMaison(
      BienImmobilier bienImmobilier) async {
    try {
      var res = await WebRequest.nativRequest(
        verbe: RequestVerbeEnum.POST,
        "${Links.loyer}/bienImmobiliers/maison/update",
        body: bienImmobilier.toJson().parseToJson(),
        headers: AppHttpHeaders.headers,
      );

      var body = HttpResponse.decodeBody<Json>(res);
      if (body.status) {
        return HttpResponse.success(data: BienImmobilier.fromJson(body.data!));
      } else {
        return HttpResponse.error();
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  Future<HttpResponse<List<BlocAppartement>>> getAllBlocAppartByUser(
      String userId) async {
    try {
      var res = await WebRequest.nativRequest(
        "${Links.loyer}/blocApparts/getblockByOwner/$userId",
        headers: AppHttpHeaders.headers,
      );

      var body = HttpResponse.decodeBody<List>(res);
      if (body.status) {
        return HttpResponse.success(
            data: body.data!.map((e) => BlocAppartement.fromJson(e)).toList());
      } else {
        return HttpResponse.error();
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  Future<HttpResponse<List<TypeAppartement>>> getAllTypeAppartements() async {
    try {
      var res = await WebRequest.nativRequest(
          "${Links.loyer}/typeAppartements/",
          headers: AppHttpHeaders.headers);

      var body = HttpResponse.decodeBody<List>(res);
      if (body.status) {
        return HttpResponse.success(
            data: body.data!.map((e) => TypeAppartement.fromJson(e)).toList());
      } else {
        return HttpResponse.error();
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  Future<HttpResponse<Appartement>> createAppartement(
      Appartement appartement) async {
    try {
      var res = await WebRequest.nativRequest(
        verbe: RequestVerbeEnum.POST,
        "${Links.loyer}/bienImmobiliers/appartement",
        body: appartement.toJson().parseToJson(),
        headers: AppHttpHeaders.headers,
      );

      var body = HttpResponse.decodeBody<Json>(res);
      if (body.status) {
        return HttpResponse.success(data: Appartement.fromJson(body.data!));
      } else {
        return HttpResponse.error();
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  Future<HttpResponse<Appartement>> updateAppartement(
      Appartement appartement) async {
    try {
      var res = await WebRequest.nativRequest(
        verbe: RequestVerbeEnum.POST,
        "${Links.loyer}/bienImmobiliers/appartement/update",
        body: appartement.toJson().parseToJson(),
        headers: AppHttpHeaders.headers,
      );

      var body = HttpResponse.decodeBody<Json>(res);
      if (body.status) {
        return HttpResponse.success(data: Appartement.fromJson(body.data!));
      } else {
        return HttpResponse.error();
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  Future<HttpResponse<List<PaiementLoyer>>> historiquePaiementFromAppartementId(
      int appartementId) async {
    try {
      var res = await WebRequest.nativRequest(
        "${Links.loyer}/paiements/historique/habitat/$appartementId",
        headers: AppHttpHeaders.headers,
      );

      var body = HttpResponse.decodeBody<List>(res);
      if (body.status) {
        return HttpResponse.success(
            data: body.data!.map((e) => PaiementLoyer.fromJson(e)).toList());
      } else {
        return HttpResponse.error();
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  Future<HttpResponse<Habitat>> getHabitatByCode(String code) async {
    try {
      var res = await WebRequest.nativRequest(
        "${Links.loyer}/bienImmobiliers/getHabitat/$code",
        headers: AppHttpHeaders.headers,
      );

      var body = HttpResponse.decodeBody<Json>(res);
      if (body.status) {
        if (body.data!["typeAppartement"] == null) {
          return HttpResponse.success(data: Maison.fromJson(body.data!));
        } else {
          return HttpResponse.success(data: Appartement.fromJson(body.data!));
        }
      } else {
        return HttpResponse.error();
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  Future<HttpResponse<PaiementLoyer>> payerLoyer(
      PaiementLoyer paiementLoyer) async {
    try {
      var res = await WebRequest.nativRequest(
        verbe: RequestVerbeEnum.POST,
        "${Links.loyer}/paiements/payer",
        body: paiementLoyer.toJson().parseToJson(),
        headers: AppHttpHeaders.headers,
      );

      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        return HttpResponse.success(data: PaiementLoyer.fromJson(body.data!));
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  Future<HttpResponse<Json>> checkPaiement(
      {required int habitatId, required int mois, required int annee}) async {
    try {
      var res = await WebRequest.nativRequest(
        verbe: RequestVerbeEnum.POST,
        "${Links.loyer}/paiements/checkPaiement",
        body: {
          "mois": mois,
          "annee": annee,
          "habitat": habitatId,
        }.parseToJson(),
        headers: AppHttpHeaders.headers,
      );

      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        return HttpResponse.success(data: body.data);
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }
}
