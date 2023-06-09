import 'dart:convert';

import 'package:wan_mobile/tools/utils/functions.dart';

typedef Json = Map<String, dynamic>;

extension CustomDateTime on DateTime? {
  String get toFrenchDate =>
      (this != null) ? Functions.getStringDate(this) : "";
  String get toFrenchDateTime =>
      (this != null) ? Functions.getStringDate(this, withTime: true) : "";
}

extension StringExt on String? {
  String get value => this ?? "";
  DateTime? get toDateTime => DateTime.tryParse(toString());
  int toInt() => int.tryParse(toString()) ?? 0;

  String toJson() {
    if (this != null) {
      return json.encode(this!);
    }
    return "";
  }
}

extension DoubleExt on double? {
  double get value => this ?? 0;
}

extension MapExt on Map? {
  String toJson() {
    if (this != null) {
      return json.encode(this!);
    }
    return "";
  }
}
