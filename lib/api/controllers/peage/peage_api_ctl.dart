import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:lebedoo_assets/tools/web/app_http_hearders.dart';
import 'package:lebedoo_assets/tools/web/web_request.dart';

import 'package:wan_mobile/models/peage/fournisseur_peage.dart';
import 'package:tools_flutter_project/tools/http/http_response.dart';

class PeageApiCtl {
  Future<HttpResponse<List<FournisseurPeage>>> getAllFournisseur() async {
    try {
      var res = await WebRequest.nativRequest(
        verbe: RequestVerbeEnum.POST,
        AppHttpHeaders.baseUrl(module: "external"),
        body: const BodyObject(
          port: 8091,
          service: "api/v1/providers/all",
          verbe: RequestVerbeEnum.GET,
        ),
        headers: AppHttpHeaders.authHeaders,
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
