import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:lebedoo_wallets_transactions/models/carte_bancaire.dart';
import 'package:lebedoo_wallets_transactions/models/mobile_money.dart';
import 'package:lebedoo_wallets_transactions/models/moyen_paiements.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/api/controllers/account_transaction/account_transaction_api_ctl.dart';
import 'package:wan_mobile/models/solde_historique/account_transaction.dart';
import 'package:wan_mobile/tools/const/paiement/account_transaction_status.dart';
import 'package:wan_mobile/tools/services/notification_service.dart';

import 'package:lebedoo_assets/views/controllers/abstracts/view_controller.dart';
import 'package:wan_mobile/views/static/paiement/webview_paiement_page.dart';

class PaiementRecapVctl extends ViewController {
  MoyenPaiements moyenPaiement;
  String motifPaiement;
  String route;
  int montant, frais;
  String service;
  int? userDestinationId;

  PaiementRecapVctl(
      {required this.moyenPaiement,
      required this.frais,
      required this.montant,
      required this.motifPaiement,
      required this.route,
      required this.service,
      this.userDestinationId});

  Future<void> submit() async {
    var rep = await Tools.showChoiceMessage(
      title: AppConst.appName,
      message: "Confirmer-vous le paiement ?",
    );
    if (rep == true) {
      await pr.show();
      var trx = AccountTransaction();

      trx.userId = appCtl.user.id;
      trx.libele = motifPaiement;
      trx.amount = montant.toString();
      trx.frais = frais.toString();
      trx.service = service;
      trx.recevedId = userDestinationId;
      // trx.modePayment = moyenPaiement.typePaiment;
      if (moyenPaiement is MobileMoney) {
        var moyPaie = (moyenPaiement as MobileMoney);
        if (!moyPaie.numero.value.contains("+")) {
          trx.numberPayment = "+225${moyPaie.numero.value}";
        }
      } else {
        trx.numberPayment = (moyenPaiement as CarteBancaire).numeroCarte;
      }

      var res = await AccountTransactionApiCtl().makePaiement(trx);
      await pr.hide();
      if (res.status) {
        Get.to(() => WebviewPaiementPage(url: res.data!.paymentUrl.value));

        onListenTransactionStatus();
      } else {
        // Get.parameters['paiementResult'] = "false";
        await Tools.messageBox(message: res.message);
      }
    }
  }

  Future<void> onListenTransactionStatus() =>
      NotificationService.listNotification(
        handler: (message) async {
          int? trxStatus = message!.data["status"].toString().toInt();
          if (trxStatus == TransactionStatus.success) {
            Get.parameters['paiementResult'] = "true";
            Get.until((route) => Get.currentRoute == this.route);
          } else {
            await Tools.messageBox(
                message: "La transaction a échoué. Veuillez reessayer.");
            Get.back();
          }
        },
      );
}
