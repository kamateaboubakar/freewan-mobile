import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:get/get.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:lebedoo_assets/themes/asset_colors.dart';
import 'package:wan_mobile/tools/widgets/c_outlined_button.dart';
import 'package:wan_mobile/views/controllers/paiement/edition_card_bank_vctl.dart';

class EditionCardBank extends StatelessWidget {
  const EditionCardBank({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditionCardBankVctl>(
        init: EditionCardBankVctl(),
        builder: (ctl) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Enregistrez une carte bancaire"),
            ),
            body: Container(
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
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: ctl.formKey,
                  child: Column(
                    children: [
                      CreditCardWidget(
                        cardNumber: ctl.numCardCtl.text,
                        expiryDate:
                            "${ctl.monthExpireDateCtl.text}/${ctl.yearExpireDateCtl.text}",
                        labelCardHolder: "Nom sur la Carte",
                        cardHolderName: ctl.ownerNameCtl.text,
                        isHolderNameVisible: true,
                        isChipVisible: false,
                        cvvCode: ctl.cvcCtl.text,
                        showBackView: false,
                        onCreditCardWidgetChange: (creditCardBrand) {},
                      ),
                      COutlinedButton(
                        onPressed: ctl.scanCard,
                        child: const Text("Scanner la carte"),
                      ),
                      const Gap(10),
                      const TextDivider(
                        text: Text("Saisir les informations de la carte"),
                      ),
                      const Gap(30),
                      CTextFormField(
                        controller: ctl.ownerNameCtl,
                        require: true,
                        hintText: "Nom sur la Carte",
                        onChanged: (value) {
                          ctl.ownerNameCtl.text = value;
                          ctl.update();
                        },
                      ),
                      CTextFormField(
                        controller: ctl.numCardCtl,
                        require: true,
                        maxLength: 16,
                        hintText: "Numéro de Carte",
                        keyboardType: TextInputType.number,
                        suffixIcon: Image.asset(
                          "assets/images/master_card.png",
                          width: 32,
                          height: 29,
                        ),
                        onChanged: (value) {
                          ctl.numCardCtl.text = value;
                          ctl.update();
                        },
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CTextFormField(
                              controller: ctl.monthExpireDateCtl,
                              require: true,
                              maxLength: 2,
                              hintText: "mois d’expiration",
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                ctl.monthExpireDateCtl.text = value;
                                ctl.update();
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CTextFormField(
                              controller: ctl.yearExpireDateCtl,
                              require: true,
                              maxLength: 4,
                              hintText: "Année d’expiration",
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                ctl.yearExpireDateCtl.text = value;
                                ctl.update();
                              },
                            ),
                          ),
                        ],
                      ),
                      CTextFormField(
                        controller: ctl.cvcCtl,
                        require: true,
                        maxLength: 3,
                        hintText: "CVC",
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          ctl.cvcCtl.text = value;
                          ctl.update();
                        },
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
                              onPressed: ctl.addCard,
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
          );
        });
  }
}
