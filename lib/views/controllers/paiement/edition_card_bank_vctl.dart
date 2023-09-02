import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/api/controllers/paiement/paiement_api_ctl.dart';
import 'package:wan_mobile/models/paiement/carte_bancaire.dart';
import 'package:wan_mobile/tools/const/paiement/wallet_account_typ.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';

class EditionCardBankVctl extends ViewController {
  var numCard = "";
  var ownerName = "";
  var formKey = GlobalKey<FormState>();
  var cvc = "";
  var monthExpireDate = "";
  var yearExpireDate = "";

  Future<void> addCard() async {
    if (formKey.currentState!.validate()) {
      await pr.show();
      var item = CarteBancaire();
      item.owerName = ownerName;
      item.numeroCarte = numCard;
      item.dateExpiration = "$monthExpireDate/$yearExpireDate";
      item.cvc = cvc;
      item.categorieId = WalletAccountType.catBankCard;
      item.idUser = appCtl.user.accountId.value;
      item.userId = 1;

      var res = await PaiementApiCtl().addCarteBancaire(carteBancaire: item);
      await pr.hide();
      if (res.status) {
        update();
        Get.back(result: res.data!);
      } else {
        Tools.messageBox(message: res.message);
      }
    }
  }
}
