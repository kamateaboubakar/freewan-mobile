import 'package:wan_mobile/api/abstracts/http_client_const.dart';
import 'package:wan_mobile/api/abstracts/web_controller.dart';
import 'package:wan_mobile/models/scolarite/search_etudiant_result.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/http_response.dart';

class ScolariteApiCtl extends WebController {
  Future<HttpResponse<SearchEtudiantResult>> searchEtudiant({
    required String numeroIdentification,
    required String anneeScolaire,
  }) async {
    try {
      final response = await post(
        HttpClientConst.baseUrl(module: "external"),
        {
          "verbe": "POST",
          "port": "8087",
          "service":
              "api/v1/etudiants/search?numero_identification=$numeroIdentification&annee_scolaire=$anneeScolaire",
        }.parseToJson(),
        headers: HttpClientConst.authHeaders,
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
      final response = await post(
        HttpClientConst.baseUrl(module: "external"),
        {
          "verbe": "POST",
          "port": "8087",
          "service": "api/v1/paiements/store",
          "body": {
            "moyen_paiement": moyenPaiement,
            "montant": montant,
            "numero_paiement": numeroPaiement,
            "user_paiement_id": userPaiementId,
            "classe_id": classeId,
            "etudiant_id": etudiantId,
          }
        }.parseToJson(),
        headers: HttpClientConst.authHeaders,
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
