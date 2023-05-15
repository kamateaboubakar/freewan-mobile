import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class HttpResponse<T> {
  bool status = false;
  T? data;
  String message = "Désolé, une erreur est survenue. Veuillez réessayer SVP.";
  String detailErrors = "";

  HttpResponse.success({required this.data})
      : status = true,
        message = "";
  HttpResponse.error(
      {this.message =
          "Désolé, une erreur est survenue. Veuillez réessayer SVP.",
      this.detailErrors = ""}) {
    if (kDebugMode) {
      print(detailErrors);
    }
  }
  HttpResponse.setDetailErrors({required this.detailErrors});

  static HttpResponse<T> decodeBody<T>(http.Response source) {
    try {
      if (source.statusCode == 200) {
        var body = jsonDecode(utf8.decode(source.bodyBytes));
        return HttpResponse.success(data: (body as T));
      } else {
        return HttpResponse.error(
            message: source.reasonPhrase ??
                "Désolé, une erreur est survenue. Veuillez réessayer SVP.");
      }
    } catch (e, st) {
      if (kDebugMode) {
        print(e);
        print(st);
      }
      return HttpResponse.setDetailErrors(detailErrors: e.toString());
    }
  }

  static String? encodeBody(dynamic data) {
    try {
      // if (data is Entity) {
      //   return json.encode(data.toMap());
      // }
      return json.encode(data);
    } catch (e, st) {
      if (kDebugMode) {
        print(e);
        print(st);
      }
      return null;
    }
  }
}
