import 'package:flutter/material.dart';
import 'package:wan_mobile/tools/types/types.dart';

class DateTimeEditingController {
  TextEditingController _textController = TextEditingController();

  DateTime? _date;

  DateTimeEditingController();

  DateTime? get date => _date;

  set date(DateTime? value) {
    _date = value;
    _textController.text = value.toFrenchDate;
  }

  TextEditingController get textController => _textController;

  set textController(TextEditingController value) => _textController = value;
}
