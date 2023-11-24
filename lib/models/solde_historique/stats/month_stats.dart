import 'package:tools_flutter_project/tools/types/double.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/tools/utils/functions.dart';

class MonthStats {
  String? month;
  int? totalAmount;

  MonthStats({this.month, this.totalAmount});

  MonthStats.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    totalAmount = json['total_amount'].toString().toDouble().value.toInt();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['month'] = month;
    data['total_amount'] = totalAmount;
    return data;
  }

  String get getPeriodLabel {
    if (month.toDateTime() != null) {
      return "";
      //"${Functions.getMonthLib(month.toDateTime()!)["full"]!} ${month!.substring(0, 4)}";
    } else {
      return "";
    }
  }
}
