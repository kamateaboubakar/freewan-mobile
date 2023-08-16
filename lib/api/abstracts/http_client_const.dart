import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:module_master/const/const.dart';

import '../../views/controllers/app_ctl.dart';

abstract class HttpClientConst {
  static final AppCtl _appCtl = Get.find();

  static String get jwtToken => _appCtl.jwtToken;

  static set jwtToken(String jwtToken) => _appCtl.jwtToken = jwtToken;

  static String baseUrl({required String module, bool local = false}) {
    String url = "${Const.localUrl}/$module";
    if (!local) {
      url = "${Const.onlineUrl}/$module";
    }
    if (kDebugMode) {
      print(url);
    }
    return url;
  }

  static Map<String, String> get headers => {
        "content-type": "application/json",
        "accept": "application/json",
      };

  static Map<String, String> get authHeaders => {
        "content-type": "application/json",
        "accept": "application/json",
        "authorization": "Bearer $jwtToken",
      };

  static Map<String, String> get multipartHeaders => {
        "content-type": "multipart/form-data",
        "accept": "application/json",
      };

  static Map<String, String> get authMultipartHeaders => {
        "content-type": "multipart/form-data",
        "accept": "application/json",
        "authorization": "Bearer $jwtToken",
      };
}
