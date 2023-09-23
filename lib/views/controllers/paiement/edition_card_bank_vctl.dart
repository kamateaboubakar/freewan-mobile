// import 'package:credit_card_scanner/credit_card_scanner.dart';
import 'package:credit_card_scanner/credit_card_scanner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/api/controllers/paiement/wallet_api_ctl.dart';
import 'package:wan_mobile/models/paiement/carte_bancaire.dart';
import 'package:wan_mobile/tools/const/paiement/wallet_account_typ.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';

class EditionCardBankVctl extends ViewController {
  var numCardCtl = TextEditingController();
  var ownerNameCtl = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var cvcCtl = TextEditingController();
  var monthExpireDateCtl = TextEditingController();
  var yearExpireDateCtl = TextEditingController();

  Future<void> addCard() async {
    if (formKey.currentState!.validate()) {
      await pr.show();
      var item = CarteBancaire();
      item.owerName = ownerNameCtl.text;
      item.numeroCarte = numCardCtl.text;
      item.dateExpiration = "$monthExpireDateCtl/$yearExpireDateCtl";
      item.cvc = cvcCtl.text;
      item.categorieId = WalletAccountType.catBankCard;
      item.idUser = appCtl.user.id.value.toString();
      item.userId = 1;

      var res = await WalletApiCtl().addCarteBancaire(carteBancaire: item);
      await pr.hide();
      if (res.status) {
        update();
        Get.back(result: res.data!);
      } else {
        Tools.messageBox(message: res.message);
      }
    }
  }

  Future<void> scanCard() async {
    var cardDetails = await CardScanner.scanCard(
        scanOptions: const CardScanOptions(scanCardHolderName: true));
    if (cardDetails != null) {
      numCardCtl.text = cardDetails.cardNumber;
      ownerNameCtl.text = cardDetails.cardHolderName;
      monthExpireDateCtl.text = cardDetails.expiryDate.split("/")[0];
      yearExpireDateCtl.text = cardDetails.expiryDate.split("/")[1];
      update();
    }
  }
}
