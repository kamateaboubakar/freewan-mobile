import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/api/loyer/loyer_api_ctl.dart';
import 'package:wan_mobile/models/loyer/maison.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';

class EditionMaisonFormCtl extends ViewController {
  Maison item;
  var nomLocalCtl = TextEditingController();
  var lieuCtl = TextEditingController();
  var nomLocataireCtl = TextEditingController();
  var nbPieceCtl = TextEditingController();
  var loyerCtl = TextEditingController();
  var jourPaiement = TextEditingController();
  var formKey = GlobalKey<FormState>();

  EditionMaisonFormCtl(this.item);

  Future<void> submit() async {
    if (formKey.currentState!.validate()) {
      item.libelle = nomLocalCtl.text;
      item.lieu = lieuCtl.text;
      item.nbPiece = nbPieceCtl.text.toInt();
      item.loyer = loyerCtl.text.toDouble();
      item.jourMoisPaiement = jourPaiement.text.toInt();
      item.ownerId = appCtl.user.accountId;
      await pr.show();
      var res = await LoyerApiCtl().updateMaison(item);
      await pr.hide();
      if (res.status) {
        Get.back(result: item);
      } else {
        Tools.messageBox(message: res.message);
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
    nomLocalCtl.text = item.libelle.value;
    lieuCtl.text = item.lieu.value;
    nbPieceCtl.text = item.nbPiece.value.toString();
    loyerCtl.text = item.loyer.value.toString();
    jourPaiement.text = item.jourMoisPaiement.value.toString();
  }
}