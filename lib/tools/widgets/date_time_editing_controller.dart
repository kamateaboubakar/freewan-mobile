import 'package:flutter/material.dart';
import 'package:wan_mobile/tools/types/types.dart';

class DateTimeEditingController {
  final TextEditingController _textController = TextEditingController();

  DateTime? _date;

  DateTimeEditingController();

  DateTime? get date => _date;

  set date(DateTime? value) {
    _date = value;
    _textController.text = value.toFrenchDate;
  }

  set setTime(DateTime? value) {
    _date = value;
    _textController.text = value.toTime;
  }

  TextEditingController get textController => _textController;

  void clear() {
    _textController.clear();
    _date = null;
  }
}
