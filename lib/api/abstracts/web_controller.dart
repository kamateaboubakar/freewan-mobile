import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:wan_mobile/tools/const/const.dart';

abstract class WebController {
  // AppVctl appVctl = Get.find();
  http.Client get client => http.Client();

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

  Uri baseUrl({required String module, bool local = false}) {
    String url = "${Const.localUrl}/$module";
    if (!local) {
      url = "${Const.onlineUrl}/$module";
    }
    if (kDebugMode) {
      print(url);
    }
    return Uri.parse(url);
  }

  Map<String, String> get headers => {
        "content-type": "application/json",
        "accept": "application/json",
        // "Authorization": "Bearer ${appVctl.jwt}",
      };

  Map<String, String> get multipartHeaders => {
        "content-type": "multipart/form-data",
        "accept": "application/json",
        // "Authorization": "Bearer ${appVctl.jwt}",
      };
}
