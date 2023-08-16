import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:module_master/module_master.dart';
import 'package:wan_mobile/api/controllers/loyer/loyer_api_ctl.dart';
import 'package:wan_mobile/models/loyer/abstracts/bloc_appartement.dart';
import 'package:wan_mobile/models/loyer/appartement.dart';
import 'package:wan_mobile/models/loyer/type_appartement.dart';
import 'package:wan_mobile/tools/types/types.dart';

import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';

class FormEditionAppartementVctl extends ViewController {
  var numeroAppart = TextEditingController();
  TypeAppartement? typeAppartement;
  BlocAppartement? blocAppart;
  var nbPiece = TextEditingController();
  var loyer = TextEditingController();
  var jourPaiement = TextEditingController();
  Appartement? editedItem;
  var formKey = GlobalKey<FormState>();

  FormEditionAppartementVctl({this.editedItem, this.blocAppart});

  Future<void> submit() async {
    if (formKey.currentState!.validate()) {
      if (editedItem?.id == null) {
        Appartement appartement = assignItem(Appartement());
        await pr.show();
        var res = await LoyerApiCtl().createAppartement(appartement);
        await pr.hide();
        if (res.status) {
          Get.back(result: appartement);
        } else {
          Tools.messageBox(message: res.message);
        }
      } else {
        editedItem = assignItem(editedItem!);
        await pr.show();
        var res = await LoyerApiCtl().updateAppartement(editedItem!);
        await pr.hide();
        if (res.status) {
          Get.back(result: editedItem);
        } else {
          Tools.messageBox(message: res.message);
        }
      }
    }
  }

  Appartement assignItem(Appartement item) {
    item.numeroAppartement = numeroAppart.text;
    item.typeAppartement = typeAppartement;
    item.blocAppart = blocAppart;
    item.nbPiece = nbPiece.text.toInt();
    item.loyer = loyer.text.toDouble();
    item.jourMoisPaiement = jourPaiement.text.toInt();
    item.ownerId = appCtl.user.accountId;
    return item;
  }

  Future<List<TypeAppartement>> fetchTypeAppartements() async {
    var res = await LoyerApiCtl().getAllTypeAppartements();
    if (res.status) {
      return res.data!;
    } else {
      return [];
    }
  }

  Future<List<BlocAppartement>> fetchBlockApparts() async {
    var res =
        await LoyerApiCtl().getAllBlocAppartByUser(appCtl.user.accountId!);
    if (res.status) {
      return res.data!;
    } else {
      return [];
    }
  }

  @override
  void onReady() {
    super.onReady();
    if (editedItem?.id != null) {
      numeroAppart.text = editedItem!.numeroAppartement!;
      typeAppartement = editedItem!.typeAppartement;

      // Déjà assigné dans le constructeur
      // blocAppart = editedItem!.blocAppart;

      nbPiece.text = editedItem!.nbPiece.toString();
      loyer.text = editedItem!.loyer.toString();
      jourPaiement.text = editedItem!.jourMoisPaiement.toString();
      update();
    }
  }
}
