import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:wan_mobile/tools/const/const.dart';

abstract class WebController {
  // AppVctl appVctl = Get.find();
  http.Client get client => http.Client();

  Future<QueryResult> grClient(
      {GraphQLCache? cache,
      required Link link,
      required QueryOptions options}) {
    return GraphQLClient(cache: cache ?? GraphQLCache(), link: link)
        .query(options);
  }

  // Future<http.MultipartRequest> multiPartclient(String method, Uri url,
  //     {Map<String, String> headers = const {},
  //     Map<String, String> body = const {},
  //     List<Fichier> files = const []}) async {
  //   var req = http.MultipartRequest(method, url);
  //   req.headers.addAll(headers);
  //   req.fields.addAll(body);
  //   for (var file in files) {
  //     req.files.add(await http.MultipartFile.fromPath("files", file.url!));
  //   }
  //   return req;
  // }

  Uri baseUrl({String? module, bool local = false}) {
    String url = (local) ? Const.localUrl : Const.onlineUrl;

    if (module != null) {
      url += "/$module";
    } else {
      url += "/";
    }
    if (kDebugMode) {
      print(url);
    }
    return Uri.parse(url);
  }

  HttpLink graphBaseUrl({String? module, bool local = false}) {
    String url = (local) ? Const.localUrl : Const.onlineUrl;

    if (module != null) {
      url += "/$module";
    } else {
      url += "/";
    }

    return HttpLink(url);
  }

  Map<String, String> get headers => {
        "content-type": "application/json",
        "accept": "application/json",
      };

  Map<String, String> get authHeaders => {
        "content-type": "application/json",
        "accept": "application/json",
        "Authorization": "Bearer ",
      };

  Map<String, String> get multipartHeaders => {
        "content-type": "multipart/form-data",
        "accept": "application/json",
        // "Authorization": "Bearer ${appVctl.jwt}",
      };
}
