import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/api/loyer/loyer_api_ctl.dart';
import 'package:wan_mobile/models/loyer/abstracts/bloc_appartement.dart';
import 'package:wan_mobile/models/loyer/maison.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';

class FormEditionBienImmobilierVctl extends ViewController {
  bool isMaison;

  FormEditionBienImmobilierVctl(this.isMaison);

  var nomLocalCtl = TextEditingController();
  var lieuCtl = TextEditingController();
  var nomLocataireCtl = TextEditingController();
  var nbPieceCtl = TextEditingController();
  var loyerCtl = TextEditingController();
  var jourPaiement = TextEditingController();
  var formKey = GlobalKey<FormState>();

  Future<void> submit() async {
    if (formKey.currentState!.validate()) {
      if (isMaison) {
        Maison maison = Maison();
        maison.libelle = nomLocalCtl.text;
        maison.lieu = lieuCtl.text;
        maison.nbPiece = nbPieceCtl.text.toInt();
        maison.loyer = loyerCtl.text.toDouble();
        maison.jourMoisPaiement = jourPaiement.text.toInt();
        maison.ownerId = appCtl.user.accountId;
        await pr.show();
        var res = await LoyerApiCtl().createMaison(maison);
        await pr.hide();
        if (res.status) {
          Get.back(result: maison);
        } else {
          Tools.messageBox(message: res.message);
        }
      } else {
        BlocAppartement bloc = BlocAppartement();
        bloc.libelle = nomLocalCtl.text;
        bloc.lieu = lieuCtl.text;
        bloc.ownerId = appCtl.user.accountId;
        await pr.show();
        var res = await LoyerApiCtl().createBloc(bloc);
        await pr.hide();
        if (res.status) {
          Get.back(result: bloc);
        } else {
          Tools.messageBox(message: res.message);
        }
      }
      await pr.hide();
    }
  }
}
