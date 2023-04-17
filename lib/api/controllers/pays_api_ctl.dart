import 'package:wan_mobile/api/abstracts/web_controller.dart';
import 'package:wan_mobile/models/pays.dart';
import 'package:wan_mobile/tools/utils/http_response.dart';

class PaysApiCtl extends WebController {
  Future<HttpResponse<List<Pays>>> getAll() async {
    try {
      var response = await client.get(baseUrl(module: "countries"));
      var body = HttpResponse.decodeBody(response);
      if (body.status) {
        return HttpResponse.success(
            data: (body.data as List).map((e) => Pays.fromJson(e)).toList());
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e) {
      return HttpResponse.error(detailErrors: e.toString());
    }
  }
}
