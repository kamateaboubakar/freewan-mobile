import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lebedoo_assets/views/controllers/abstracts/view_controller.dart';
import 'package:tools_flutter_project/tools/types/int.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/views/static/paiement/paiement_mode_paiement.dart';

class PaiementMontantVctl extends ViewController {
  int userDestinationId;
  String route;

  PaiementMontantVctl(this.userDestinationId, this.route);

  var montantCtl = TextEditingController();
  void submit() {
    if (montantCtl.text.isNumericOnly) {
      Get.to(
        () => PaiementModePaiement(
          route: route,
          motifPaiement: "Paiement par Scan",
          frais: 0,
          montant: montantCtl.text.toInt().value,
          service: "ScanPay",
          userDestinationId: userDestinationId,
        ),
      );
    }
  }
}
