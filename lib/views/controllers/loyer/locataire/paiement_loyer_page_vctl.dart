import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/api/loyer/loyer_api_ctl.dart';
import 'package:wan_mobile/models/loyer/abstracts/habitat.dart';
import 'package:wan_mobile/models/loyer/paiement_loyer.dart';
import 'package:wan_mobile/tools/utils/functions.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';
import 'package:wan_mobile/views/static/home/home_page.dart';

class PaiementLoyerPageVctl extends ViewController {
  Habitat habitat;
  int? mois;
  int? annee;
  var formKey = GlobalKey<FormState>();
  List<String> moisList = Functions.listMois;
  Functions functions = Functions();

  PaiementLoyerPageVctl(this.habitat);

  Future<void> submit() async {
    //  Get.to(
    //   () => PaiementRecap(
    //     description:
    //         "Paiement de loyer de ${habitat.loyer.toAmount()}",
    //   ),
    // );

    if (formKey.currentState!.validate()) {
      var rep = await Tools.showChoiceMessage(
          message: "Confirmez-vous le paiement ?");
      if (rep == true) {
        await pr.show();
        PaiementLoyer paie = PaiementLoyer();
        paie.annee = annee;
        paie.mois = mois;
        paie.habitat = habitat;
        paie.idUserPaiement = appCtl.user.accountId;
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
    }
  }
}
