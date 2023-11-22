import 'package:get/get.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:lebedoo_assets/views/controllers/abstracts/view_controller.dart';
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
            message: "Effectué avec succès. Voulez-vous faire un autre don ?");
        if (rep != true) {
          Get.back();
        }
      }
    }
  }
}
