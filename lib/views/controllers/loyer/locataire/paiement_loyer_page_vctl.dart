import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/api/controllers/loyer/loyer_api_ctl.dart';
import 'package:wan_mobile/models/loyer/abstracts/habitat.dart';
import 'package:wan_mobile/models/loyer/paiement_loyer.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:lebedoo_assets/views/controllers/abstracts/view_controller.dart';
import 'package:wan_mobile/views/static/home/home_page.dart';
import 'package:wan_mobile/views/static/paiement/paiement_mode_paiement.dart';

class PaiementLoyerPageVctl extends ViewController {
  Habitat habitat;
  var anneeCtl = TextEditingController();

  int? selectedMois;

  PaiementLoyerPageVctl(this.habitat);

  Future<void> submit() async {
    if (selectedMois != null && anneeCtl.text.isNumericOnly) {
      var rep = await Tools.showChoiceMessage(
          message: "Confirmez-vous le paiement ?");
      if (rep == true) {
        await pr.show();
        var verPaiement = await LoyerApiCtl().checkPaiement(
            habitatId: habitat.id!,
            mois: selectedMois!,
            annee: anneeCtl.text.toInt());
        await pr.hide();
        if (verPaiement.status) {
          if (verPaiement.data!["status"] == false) {
            var page = Get.currentRoute;
            Get.parameters = {};
            await Get.to(
              () => PaiementModePaiement(
                route: page,
                motifPaiement: "Paiement de loyer",
                montant: habitat.loyer.value.toInt(),
                frais: 0,
                service: "Paiement Loyer",
              ),
            );

            var result = Get.parameters['paiementResult'];
            if (result == "true") {
              await pr.show();
              PaiementLoyer paie = PaiementLoyer();
              paie.annee = DateTime.now().year;
              paie.mois = DateTime.now().month;
              paie.habitat = habitat;
              paie.idUserPaiement = appCtl.user.id.value.toString();
              paie.montant = habitat.loyer;
              paie.telPaiement = appCtl.user.phoneNumber;

              var res = await LoyerApiCtl().payerLoyer(paie);
              await pr.hide();
              if (res.status) {
                Get.offAll(() => const HomePage());
                Tools.showToast(message: "Paiement effectué avec succès");
              } else {
                Tools.messageBox(message: res.message);
              }
            }
          } else {
            Tools.messageBox(message: verPaiement.data!["message"]);
          }
        } else {
          Tools.messageBox(message: verPaiement.message);
        }
      }
    } else {
      Tools.messageBox(
          message: "Veuillez saisir un mois et une année valide.");
    }
  }
}
