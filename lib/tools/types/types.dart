import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wan_mobile/tools/utils/functions.dart';

typedef Json = Map<String, dynamic>;

extension CustomBool on bool? {
  int toInt() => (this == true) ? 1 : 0;

  bool toBool(int value) => (value == 1) ? true : false;
}

extension CustomDateTime on DateTime? {
  String get toFrenchDate =>
      (this != null) ? Functions.getStringDate(this) : "";
  String get toFrenchDateTime =>
      (this != null) ? Functions.getStringDate(this, withTime: true) : "";

  String? toStringDateOnly() =>
      this == null ? null : this!.toIso8601String().split("T").first;

  bool isSameDate(DateTime? date2) {
    if (this == null || date2 == null) {
      return false;
    } else {
      return this!.day == date2.day &&
          this!.month == date2.month &&
          this!.year == date2.year;
    }
  }

  String get toTime => (this != null) ? Functions.getTime(this) : "";

  DateTime? setTimeOfDay(TimeOfDay time) {
    if (this == null) {
      return null;
    } else {
      return DateTime(
          this!.year, this!.month, this!.day, time.hour, time.minute);
    }
  }

  TimeOfDay get toTimeOfDay => (this == null)
      ? TimeOfDay.now()
      : TimeOfDay(hour: this!.hour, minute: this!.minute);

  bool isSameTime(TimeOfDay time) {
    if (this == null) {
      return false;
    }
    return this!.hour == time.hour && this!.minute == time.minute;
  }
}

extension CustomTimeOfDay on TimeOfDay? {
  String get toFrenchTime =>
      (this != null) ? "${this!.hour}:${this!.minute}" : "";
}

extension StringExt on String? {
  String get value => this ?? "";
  DateTime? toDateTime() => DateTime.tryParse(toString());
  int toInt() => int.tryParse(toString()) ?? 0;
  double toDouble() => double.tryParse(toString()) ?? 0;
  String toJson() {
    if (this != null) {
      return json.encode(this!);
    }
    return "";
  }

  bool get isJson {
    try {
      if (this == null) {
        return false;
      } else {
        jsonDecode(this!);
        return true;
      }
    } catch (e) {
      return false;
    }
  }
}

extension DoubleExt on double? {
  double get value => this ?? 0;

  String toAmount({bool withDevise = true}) =>
      Functions.formatMontant(toString(), withDevise: withDevise);
}

extension MapExt on Map? {
  String parseToJson() {
    if (this != null) {
      return json.encode(this!);
    }
    return "";
  }
}

extension IntExt on int? {
  int get value => this ?? 0;
  String toAmount({bool withDevise = true}) =>
      Functions.formatMontant(toString(), withDevise: withDevise);
}
