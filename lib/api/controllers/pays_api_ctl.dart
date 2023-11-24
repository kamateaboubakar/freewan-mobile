import 'package:lebedoo_assets/models/pays.dart';
import 'package:lebedoo_assets/tools/web/app_http_hearders.dart';
import 'package:lebedoo_assets/tools/web/web_request.dart';

import 'package:tools_flutter_project/tools/http/http_response.dart';

class PaysApiCtl {
  Future<HttpResponse<List<Pays>>> getAll() async {
    try {
      var res = await WebRequest.nativRequest(
          AppHttpHeaders.baseUrl(module: "countries/all"),
          headers: AppHttpHeaders.headers);
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

//  var response = await client.WebRequest.nativRequest(
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
