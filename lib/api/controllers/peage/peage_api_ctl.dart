import 'package:wan_mobile/api/abstracts/http_client_const.dart';
import 'package:wan_mobile/api/abstracts/request_body_object.dart';
import 'package:wan_mobile/api/abstracts/request_verbe_enum.dart';
import 'package:wan_mobile/api/abstracts/web_controller.dart';
import 'package:wan_mobile/models/peage/fournisseur_peage.dart';
import 'package:wan_mobile/tools/utils/http_response.dart';

class PeageApiCtl extends WebController {
  Future<HttpResponse<List<FournisseurPeage>>> getAllFournisseur() async {
    try {
      var res = await post(
        HttpClientConst.baseUrl(module: "external"),
        RequestBodyObject(
          port: 8091,
          service: "api/v1/providers/all",
          verbe: RequestVerbeEnum.GET,
        ).toJson(),
        headers: HttpClientConst.authHeaders,
      );
      var body = HttpResponse.decodeBody(res);
      if (body.status) {
        return HttpResponse.success(
            data: (body.data["data"] as List)
                .map((e) => FournisseurPeage.fromJson(e))
                .toList());
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e, st) {
      return HttpResponse.error(systemError: e, systemtraceError: st);
    }
  }
}
