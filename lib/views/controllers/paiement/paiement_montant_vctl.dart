import 'package:flutter/material.dart';
import 'package:lebedoo_assets/const/feature_dictionnary.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:lebedoo_assets/models/transaction/post_reques_operations/simple_operation.dart';
import 'package:lebedoo_assets/models/transaction/service_transaction.dart';
import 'package:lebedoo_assets/models/transaction/transaction_param.dart';
import 'package:lebedoo_assets/models/transaction/user_transaction.dart';

import 'package:lebedoo_assets/views/controllers/abstracts/view_controller.dart';
import 'package:lebedoo_wallets_transactions/views/static/parcours_paiement/parcours_paiement_home.dart';
import 'package:tools_flutter_project/tools/types/double.dart';
import 'package:tools_flutter_project/tools/types/int.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';

class PaiementMontantVctl extends ViewController {
  int userDestinationId;

  PaiementMontantVctl(this.userDestinationId);

  var montantCtl = TextEditingController();
  void submit() {
    if (montantCtl.text.isNumericOnly) {
      var paiement = TransactionParam(
        sender: UserTransaction(user.id.value),
        receiver: UserTransaction(userDestinationId),
        montant: montantCtl.text.toDouble().value,
        devise: AppConst.defaultDevise,
        operation: SimpleOperation(
          service: ServiceTransaction(
            id: FeatureDictionnary.transfertArgent,
            nom: "Transfert d'argent",
          ),
        ),
      );
      Get.to(() => ParcoursPaiementHome(paiement));
    }
  }
}
