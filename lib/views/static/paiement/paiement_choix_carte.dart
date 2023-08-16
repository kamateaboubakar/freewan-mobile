import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';

import 'package:module_master/module_master.dart';

import 'package:wan_mobile/views/static/paiement/paiement_pay_recap.dart';

import '../bills/bills_views.dart';

class PaiementChoixCart extends StatelessWidget {
  const PaiementChoixCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text("Choix de la carte"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Column(
                children: ["**** **** **** 8357"]
                    .map(
                      (e) => Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                          tileColor: const Color.fromRGBO(237, 242, 249, 1),
                          title: const Text(
                            "Utiliser cette carte",
                            style: TextStyle(
                              color: Color.fromRGBO(72, 76, 79, 1),
                              fontSize: 15,
                            ),
                          ),
                          subtitle: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                "assets/images/master_card.png",
                                width: 32,
                                height: 29,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                e,
                                style: const TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 12,
                            color: Color.fromRGBO(7, 21, 60, 1),
                          ),
                          onTap: () => Get.to(
                            () => const PaiementRecap(
                              description: "Paiement par carte bancaire",
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList()),
            AddAccountButton(
              title: "Ajouter un autre carte bancaire",
              onTap: () => Tools.openBottomSheet(
                Container(
                  padding: const EdgeInsets.only(
                    right: 30,
                    left: 30,
                    top: 35,
                    bottom: 19,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Text(
                          "Enregistrez une carte bancaire",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        CreditCardWidget(
                          isChipVisible: false,
                          cardNumber: "",
                          expiryDate: "",
                          cardHolderName: "",
                          cvvCode: "",
                          showBackView: false,
                          onCreditCardWidgetChange: (creditCardBrand) {},
                        ),
                        const SizedBox(height: 26),
                        const CTextFormField(
                          hintText: "Nom sur la Carte",
                          keyboardType: TextInputType.number,
                        ),
                        CTextFormField(
                          hintText: "Numéro de Carte",
                          keyboardType: TextInputType.number,
                          suffixIcon: Image.asset(
                            "assets/images/master_card.png",
                            width: 32,
                            height: 29,
                          ),
                        ),
                        const Row(
                          children: [
                            Expanded(
                              child: CTextFormField(
                                hintText: "Date d’expiration",
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: CTextFormField(
                                hintText: "Code de Sécurité",
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: CButton(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: const BorderSide(
                                    width: 1,
                                    color: AssetColors.blueButton,
                                  ),
                                ),
                                height: 48,
                                onPressed: () {},
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
                                onPressed: () => Get.back(),
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
    );
  }
}
