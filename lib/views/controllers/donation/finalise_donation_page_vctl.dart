import 'package:lebedoo_assets/lebedoo_assets.dart';

import 'package:lebedoo_assets/views/controllers/abstracts/view_controller.dart';
import 'package:tools_flutter_project/tools/types/int.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/views/static/paiement/paiement_mode_paiement.dart';

class FinaliseDonPageVctl extends ViewController {
  int? montant;

  Future<void> submit() async {
    if (montant.value > 0) {
      var page = Get.currentRoute;
      await Get.to(
        () => PaiementModePaiement(
          route: page,
          motifPaiement: "Paiement pour don",
          frais: 0,
          montant: montant!,
          service: "Don",
        ),
      );
      if (Get.parameters['paiementResult'] == "true") {
        montant = null;
        update();
        var rep = await Tools.showChoiceMessage(
            title: AppConst.appName,
            message: "Effectué avec succès. Voulez-vous faire un autre don ?");
        if (rep != true) {
          Get.back();
        }
      }
    }
  }
}
