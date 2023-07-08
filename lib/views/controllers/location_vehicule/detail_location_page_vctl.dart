import 'package:flutter/material.dart';
import 'package:wan_mobile/tools/widgets/date_time_range_editing_controller.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';

class DetailLocationVehiculePageVctl extends ViewController {
  List<CustomDateTimeRange> seletedDays = [];
  DateTime? focusedDay;
  bool withDriver = false;
  var scrollController = ScrollController();
}
