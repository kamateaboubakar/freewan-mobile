import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/tools/widgets/c_textform_field.dart';
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
                        cardNumber: ctl.numCard,
                        expiryDate:
                            "${ctl.monthExpireDate}/${ctl.yearExpireDate}",
                        labelCardHolder: "Nom sur la Carte",
                        cardHolderName: ctl.ownerName,
                        isHolderNameVisible: true,
                        isChipVisible: false,
                        cvvCode: ctl.cvc,
                        showBackView: false,
                        onCreditCardWidgetChange: (creditCardBrand) {},
                      ),
                      const SizedBox(height: 26),
                      CTextFormField(
                        require: true,
                        hintText: "Nom sur la Carte",
                        onChanged: (value) {
                          ctl.ownerName = value;
                          ctl.update();
                        },
                      ),
                      CTextFormField(
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
                          ctl.numCard = value;
                          ctl.update();
                        },
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CTextFormField(
                              require: true,
                              maxLength: 2,
                              hintText: "mois d’expiration",
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                ctl.monthExpireDate = value;
                                ctl.update();
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CTextFormField(
                              require: true,
                              maxLength: 4,
                              hintText: "Année d’expiration",
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                ctl.yearExpireDate = value;
                                ctl.update();
                              },
                            ),
                          ),
                        ],
                      ),
                      CTextFormField(
                        require: true,
                        maxLength: 3,
                        hintText: "CVC",
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          ctl.cvc = value;
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
