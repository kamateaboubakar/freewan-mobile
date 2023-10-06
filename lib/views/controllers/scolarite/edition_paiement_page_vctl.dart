import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/api/controllers/scolarite/scolarite_api_ctl.dart';
import 'package:wan_mobile/models/scolarite/search_etudiant_result.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';
import 'package:wan_mobile/views/static/paiement/paiement_mode_paiement.dart';

class EditionPaiementScolaritePageVctl extends ViewController {
  String initialPage;
  SearchEtudiantResult result;

  EditionPaiementScolaritePageVctl(this.result, {required this.initialPage});

  var montantCtl = TextEditingController();
  var formKey = GlobalKey<FormState>();

  Future<void> submit() async {
    if (formKey.currentState!.validate()) {
      await Get.to(
        () => PaiementModePaiement(
          route: initialPage,
          frais: 0,
          motifPaiement: "Paiement de frais de scolarité",
          montant: montantCtl.text.toInt(),
          service: "Scolarité",
        ),
      );
      if (Get.parameters['paiementResult'] == "true") {
        await pr.show();
        var res = await ScolariteApiCtl().payScolarite(
            classeId: result.classe!.id!,
            montant: montantCtl.text,
            moyenPaiement: "Mobile money",
            numeroPaiement: appCtl.user.phoneNumber.value,
            etudiantId: result.etudiant!.id!,
            userPaiementId: appCtl.user.id!);
        await pr.hide();
        if (res.status) {
          Get.back();
          Tools.showToast(message: "Paiement effectué avec succès.");
        } else {
          Tools.messageBox(message: res.message);
        }
      }
    }
  }
}
