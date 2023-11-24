import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:lebedoo_assets/tools/web/app_http_hearders.dart';
import 'package:lebedoo_assets/tools/web/web_request.dart';

import 'package:wan_mobile/models/scolarite/search_etudiant_result.dart';

import 'package:tools_flutter_project/tools/http/http_response.dart';

class ScolariteApiCtl {
  Future<HttpResponse<SearchEtudiantResult>> searchEtudiant({
    required String numeroIdentification,
    required String anneeScolaire,
  }) async {
    try {
      final response = await WebRequest.nativRequest(
        verbe: RequestVerbeEnum.POST,
        AppHttpHeaders.baseUrl(module: "external"),
        body: BodyObject(
          verbe: RequestVerbeEnum.POST,
          port: 8087,
          service:
              "api/v1/etudiants/search?numero_identification=$numeroIdentification&annee_scolaire=$anneeScolaire",
        ),
        headers: AppHttpHeaders.authHeaders,
      );
      var body = HttpResponse.decodeBody(response);
      if (body.status) {
        if (body.data["status"] == true) {
          return HttpResponse.success(
            data: SearchEtudiantResult.fromJson(body.data["data"]),
          );
        } else {
          return HttpResponse.error(message: body.data["message"]);
        }
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }

  Future<HttpResponse<bool>> payScolarite({
    String moyenPaiement = "Mobile money",
    required String montant,
    required String numeroPaiement,
    required int userPaiementId,
    required int classeId,
    required int etudiantId,
  }) async {
    try {
      final response = await WebRequest.nativRequest(
        verbe: RequestVerbeEnum.POST,
        AppHttpHeaders.baseUrl(module: "external"),
        body: BodyObject(
          verbe: RequestVerbeEnum.POST,
          port: 8087,
          service: "api/v1/paiements/store",
          body: {
            "moyen_paiement": moyenPaiement,
            "montant": montant,
            "numero_paiement": numeroPaiement,
            "user_paiement_id": userPaiementId,
            "classe_id": classeId,
            "etudiant_id": etudiantId,
          },
        ),
        headers: AppHttpHeaders.authHeaders,
      );
      var body = HttpResponse.decodeBody(response);
      if (body.status) {
        if (body.data["status"] == true) {
          return HttpResponse.success(data: true);
        } else {
          return HttpResponse.error(message: body.data["message"]);
        }
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }
}
