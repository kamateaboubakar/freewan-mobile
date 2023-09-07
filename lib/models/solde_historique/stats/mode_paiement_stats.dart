import 'package:wan_mobile/tools/types/types.dart';

class ModePaiementStats {
  String? modePayment;
  int? totalAmount;

  ModePaiementStats({this.modePayment, this.totalAmount});

  ModePaiementStats.fromJson(Map<String, dynamic> json) {
    modePayment = json["mode_payment"];
    totalAmount = json['total_amount'].toString().toDouble().toInt();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["mode_payment"] = modePayment;
    data['total_amount'] = totalAmount;
    return data;
  }

  String get getModeLabel =>
      (modePayment == "CB") ? "Carte Bancaire" : "Mobile Money";
}
