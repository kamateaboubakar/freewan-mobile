import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';

import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/views/controllers/paiement/paiement_choix_numero_vctl.dart';
import 'package:wan_mobile/views/static/paiement/paiement_pay_recap.dart';

import 'package:lebedoo_assets/themes/asset_colors.dart';
import '../bills/bills_views.dart';

class PaiementChoixNumero extends StatelessWidget {
  final String motifPaiement;
  final String route;
  final int montant, frais;
  final String service;
  final int? userDestinationId;
  const PaiementChoixNumero({
    required this.route,
    required this.frais,
    required this.motifPaiement,
    required this.montant,
    required this.service,
    this.userDestinationId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaiementChoixNumeroVctl>(
        init: PaiementChoixNumeroVctl(),
        builder: (ctl) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              title: const Text("Choix du numéro"),
            ),
            body: RefreshIndicator(
              onRefresh: ctl.getMobileMoneys,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Column(
                      children: ctl.mobileMoneys
                          .map(
                            (e) => Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                tileColor:
                                    const Color.fromRGBO(237, 242, 249, 1),
                                title: const Text(
                                  "Utiliser mon numéro",
                                  style: TextStyle(
                                    color: Color.fromRGBO(72, 76, 79, 1),
                                    fontSize: 15,
                                  ),
                                ),
                                subtitle: Text(
                                  e.numeroTelephone.value,
                                  style: const TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 12,
                                  color: Color.fromRGBO(7, 21, 60, 1),
                                ),
                                onTap: () => Get.to(
                                  () => PaiementRecap(
                                    motifPaiement: motifPaiement,
                                    route: route,
                                    moyenPaiement: e,
                                    frais: frais,
                                    montant: montant,
                                    service: service,
                                    userDestinationId: userDestinationId,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    AddAccountButton(
                      title: "Ajouter un autre numéro",
                      onTap: () => Tools.openBottomSheet(
                        Container(
                          padding: const EdgeInsets.only(
                            right: 30,
                            left: 30,
                            top: 35,
                            bottom: 19,
                          ),
                          height: 222,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                          ),
                          child: Form(
                            key: ctl.formKey,
                            child: Column(
                              children: [
                                const Text(
                                  "Entrez le numéro de paiement",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                CTextFormField(
                                  controller: ctl.telCtl,
                                  hintText: "Enter your mobile number",
                                  keyboardType: TextInputType.number,
                                  require: true,
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CButton(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          side: const BorderSide(
                                            width: 1,
                                            color: AssetColors.blueButton,
                                          ),
                                        ),
                                        height: 48,
                                        onPressed: () => Get.back(),
                                        child: const Text(
                                          "Annuler",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: AssetColors.blueButton,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: CButton(
                                        borderRadius: 8,
                                        height: 48,
                                        onPressed: ctl.addMobileMoney,
                                        child: const Text(
                                          "Confirmer",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
