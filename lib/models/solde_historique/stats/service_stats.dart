import 'package:tools_flutter_project/tools/types/double.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';

class ServiceStats {
  String? service;
  int? totalAmount;

  ServiceStats({this.service, this.totalAmount});

  ServiceStats.fromJson(Map<String, dynamic> json) {
    service = json['service'];
    totalAmount = json['total_amount'].toString().toDouble().value.toInt();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['service'] = service;
    data['total_amount'] = totalAmount;
    return data;
  }
}
