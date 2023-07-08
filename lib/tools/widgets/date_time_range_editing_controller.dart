import 'package:wan_mobile/tools/widgets/date_time_editing_controller.dart';

class CustomDateTimeRange {
  DateTimeEditingController start = DateTimeEditingController();
  DateTimeEditingController end = DateTimeEditingController();

  CustomDateTimeRange({DateTime? startDate, DateTime? endDate}) {
    start.setTime = startDate;
    end.setTime = endDate;
  }
}
