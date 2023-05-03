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
}

extension DoubleExt on double? {
  double get value => this ?? 0;
}
