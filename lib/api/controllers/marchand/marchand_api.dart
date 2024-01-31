import 'package:brasserie/api/api_ctl.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:lebedoo_assets/tools/web/app_http_hearders.dart';
import 'package:tools_flutter_project/tools/types/map.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/models/marchand/marchand_request.dart';

abstract class MarchandApi {
  static Future<HttpResponse<bool>> register(MarchandRequest marchand) async {
    try {
      var res = await WebRequest.nativRequest(
        verbe: RequestVerbeEnum.POST,
        "${AppConst.serverUrl}:8081/api/marchand/auth/register",
        headers: AppHttpHeaders.headers,
        body: marchand.toJson().parseToJson(),
      );

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
