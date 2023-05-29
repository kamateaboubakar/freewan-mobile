import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
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
      this.detailErrors = "",
      dynamic systemError,
      dynamic systemtraceError}) {
    if (kDebugMode && systemError != null) {
      print(systemError);
      print(systemtraceError);
    }
  }
  HttpResponse.setDetailErrors({required this.detailErrors});

  static HttpResponse<T> decodeBody<T>(Response source) {
    try {
      if (kDebugMode) {
        print(source.statusCode);
      }
      dynamic body;
      if (source.body is String) {
        body = json.decode(source.body);
      } else {
        body = source.body;
      }
      if ([200, 201].contains(source.statusCode)) {
        return HttpResponse.success(data: (body as T));
      } else {
        if (body == null) {
          return HttpResponse.error(
              message:
                  "Désolé, une erreur est survenue. Veuillez réessayer SVP.");
        }

        if (body != null) {
          if (body["message"] != null) {
            return HttpResponse.error(message: body["message"]);
          }

          if (body != null) {
            return HttpResponse.error(message: body);
          }
        }
        return HttpResponse.error();
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

  static Future<HttpResponse<T>> decodeMultipartBody<T>(
      http.StreamedResponse source) async {
    try {
      if (kDebugMode) {
        print(source.statusCode);
      }

      var bodyString = await source.stream.bytesToString();

      dynamic body = json.decode(bodyString);

      if (source.statusCode >= 200 && source.statusCode < 300) {
        return HttpResponse.success(data: (body as T));
      } else {
        if (body == null) {
          return HttpResponse.error(
              message:
                  "Désolé, une erreur est survenue. Veuillez réessayer SVP.");
        }
        return HttpResponse.error(
            message: body["message"] ??
                body ??
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
}
