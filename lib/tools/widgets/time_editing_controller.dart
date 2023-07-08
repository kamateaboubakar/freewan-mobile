import 'package:flutter/material.dart';
import 'package:wan_mobile/tools/types/types.dart';

class TimeEditingController {
  final TextEditingController _textController = TextEditingController();

  TimeOfDay? _time;

  TimeEditingController();

  TimeOfDay? get time => _time;

  set time(TimeOfDay? value) {
    _time = value;
    _textController.text = value.toFrenchTime;
  }

  TextEditingController get textController => _textController;

  void clear() {
    _textController.clear();
    _time = null;
  }
}
