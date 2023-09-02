import 'package:get/get.dart';
import 'package:wan_mobile/api/controllers/account_transaction/account_transaction_api_ctl.dart';
import 'package:wan_mobile/models/paiement/mobile_money.dart';
import 'package:wan_mobile/models/paiement/mode_paiement.dart';
import 'package:wan_mobile/models/solde_historique/account_transaction.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';

class PaiementRecapVctl extends ViewController {
  MoyenPaiements moyenPaiement;
  String motifPaiement;
  String route;
  int montant, frais;
  String service;

  PaiementRecapVctl(
      {required this.moyenPaiement,
      required this.frais,
      required this.montant,
      required this.motifPaiement,
      required this.route,
      required this.service});

  Future<void> submit() async {
    await pr.show();
    var trx = AccountTransaction();

    trx.idUsers = appCtl.user.accountId;
    trx.libele = motifPaiement;
    trx.amount = montant.toString();
    trx.frais = frais.toString();
    trx.service = service;
    trx.modePayment = moyenPaiement.typePaiment;
    if (moyenPaiement is MobileMoney) {
      trx.mobileMoneyId = moyenPaiement.id.toString();
    } else {
      trx.bankcardId = moyenPaiement.id.toString();
    }

    var res = await AccountTransactionApiCtl().makePaiement(trx);
    await pr.hide();
    if (res.status) {
      Get.parameters['paiementResult'] = "true";
    } else {
      Get.parameters['paiementResult'] = "false";
    }
    Get.until((route) => Get.currentRoute == this.route);
  }
}
