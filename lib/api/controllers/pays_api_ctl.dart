import 'package:wan_mobile/api/abstracts/http_client_const.dart';
import 'package:wan_mobile/api/abstracts/web_controller.dart';
import 'package:wan_mobile/models/pays.dart';
import 'package:wan_mobile/tools/utils/http_response.dart';

class PaysApiCtl extends WebController {
  Future<HttpResponse<List<Pays>>> getAll() async {
    try {
      var res = await get(HttpClientConst.baseUrl(module: "countries/all"),
          headers: HttpClientConst.headers);
      var body = HttpResponse.decodeBody(res);

      if (body.status) {
        return HttpResponse.success(
            data: (body.data["data"] as List)
                .map((e) => Pays.fromJson(e))
                .toList());
      } else {
        return HttpResponse.error(message: body.message);
      }
    } catch (e) {
      return HttpResponse.error(detailErrors: e.toString());
    }
  }

//  var response = await client.post(
//       baseUrl(),
//       body: {
//         "query": "query GetCountryCodes{ "
//             "CountryNode { "
//             "edges { "
//             "node { id code name ext } } } }",
//         "variables": {}
//       }.toJson(),
//       headers: headers,
//     );

//     var body = HttpResponse.decodeBody(response);
//     if (body.status) {
//       return HttpResponse.success(
//           data: (body.data["data"]["CountryNode"]["edges"] as List)
//               .map((e) => Pays.fromJson(e))
//               .toList());
//     } else {
//       return HttpResponse.error(message: body.message);
//     }
//   } catch (e) {
//     return HttpResponse.error(detailErrors: e.toString());
//   }
}
