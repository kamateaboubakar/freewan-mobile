import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/api/controllers/paiement/wallet_api_ctl.dart';
import 'package:wan_mobile/models/paiement/mobile_money.dart';
import 'package:wan_mobile/tools/const/paiement/wallet_account_typ.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';

class PaiementChoixNumeroVctl extends ViewController {
  List<MobileMoney> mobileMoneys = [];
  var telCtl = TextEditingController();
  var formKey = GlobalKey<FormState>();

  Future<void> getMobileMoneys() async {
    await pr.show();
    var res = await WalletApiCtl()
        .getUserMobileMoneys(userId: appCtl.user.accountId.value);
    await pr.hide();
    if (res.status) {
      mobileMoneys = res.data!;
      update();
    } else {
      Tools.messageBox(message: res.message);
    }
  }

  Future<void> addMobileMoney() async {
    if (formKey.currentState!.validate()) {
      await pr.show();
      var item = MobileMoney();
      item.numeroTelephone = appCtl.user.countryCallingCode.value + telCtl.text;
      item.idUser = appCtl.user.accountId.value;
      item.categorieId = WalletAccountType.catMobileMoney;
      item.userId = 1;

      var res = await WalletApiCtl().addMobileMoney(mobileMoney: item);
      await pr.hide();
      if (res.status) {
        mobileMoneys.add(res.data!);
        update();
        telCtl.clear();
        Get.back();
      } else {
        Tools.messageBox(message: res.message);
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
    getMobileMoneys();
  }
}
