import 'dart:convert';

import 'package:tools_flutter_project/tools/types/map.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/tools/cache/cache_keys.dart';

class Credentials {
  String? phone;
  String? password;

  Credentials({this.phone, this.password});

  String toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['password'] = password;
    return data.parseToJson();
  }

  Credentials.fromJson(Json json) {
    phone = json['phone'];
    password = json['password'];
  }

  static Future<Credentials?> fromCache() async {
    String? creds = await Cache.getString(CacheKey.login.name);
    if (creds.isJson) {
      return Credentials.fromJson(jsonDecode(creds!));
    } else {
      return null;
    }
  }

  Future<bool> save() async {
    if (phone == null || password == null) {
      return false;
    }
    await Cache.setString(
      CacheKey.login.name,
      {"phone": phone, "password": password}.parseToJson(),
    );
    return true;
  }
}
