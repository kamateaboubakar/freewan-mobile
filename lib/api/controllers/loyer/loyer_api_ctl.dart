import 'package:wan_mobile/api/abstracts/http_client_const.dart';
import 'package:wan_mobile/api/abstracts/links.dart';
import 'package:wan_mobile/api/abstracts/web_controller.dart';
import 'package:wan_mobile/models/loyer/abstracts/bien_immobilier.dart';
import 'package:wan_mobile/models/loyer/abstracts/bloc_appartement.dart';
import 'package:wan_mobile/models/loyer/abstracts/habitat.dart';
import 'package:wan_mobile/models/loyer/appartement.dart';
import 'package:wan_mobile/models/loyer/maison.dart';
import 'package:wan_mobile/models/loyer/paiement_loyer.dart';
import 'package:wan_mobile/models/loyer/type_appartement.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/http_response.dart';

class LoyerApiCtl extends WebController {
  Future<HttpResponse<List<BlocAppartement>>> getBlocAppartementsByUser(
      String id) async {
    try {
      var res = await get(
        "${Links.loyer}/bienImmobiliers/blocAppartement/byOwner/$id",
        headers: HttpClientConst.headers,
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
      var res = await get(
        "${Links.loyer}/bienImmobiliers/maison/byOwner/$id",
        headers: HttpClientConst.headers,
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
      var res = await post(
        "${Links.loyer}/blocApparts/",
        bienImmobilier.toJson().parseToJson(),
        headers: HttpClientConst.headers,
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
      var res = await post(
        "${Links.loyer}/bienImmobiliers/maison",
        bienImmobilier.toJson().parseToJson(),
        headers: HttpClientConst.headers,
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
      var res = await post(
        "${Links.loyer}/bienImmobiliers/maison/update",
        bienImmobilier.toJson().parseToJson(),
        headers: HttpClientConst.headers,
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
      var res = await get(
        "${Links.loyer}/blocApparts/getblockByOwner/$userId",
        headers: HttpClientConst.headers,
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
      var res = await get("${Links.loyer}/typeAppartements/",
          headers: HttpClientConst.headers);

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
      var res = await post(
        "${Links.loyer}/bienImmobiliers/appartement",
        appartement.toJson().parseToJson(),
        headers: HttpClientConst.headers,
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
      var res = await post(
        "${Links.loyer}/bienImmobiliers/appartement/update",
        appartement.toJson().parseToJson(),
        headers: HttpClientConst.headers,
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
      var res = await get(
        "${Links.loyer}/paiements/historique/habitat/$appartementId",
        headers: HttpClientConst.headers,
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
      var res = await get(
        "${Links.loyer}/bienImmobiliers/getHabitat/$code",
        headers: HttpClientConst.headers,
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
      var res = await post(
        "${Links.loyer}/paiements/payer",
        paiementLoyer.toJson().parseToJson(),
        headers: HttpClientConst.headers,
      );

      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        return HttpResponse.success(data: PaiementLoyer.fromJson(body.data!));
      } else {
        if (body.message is String) {
          return HttpResponse.error(message: body.message);
        } else {
          return HttpResponse.error();
        }
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }
}
