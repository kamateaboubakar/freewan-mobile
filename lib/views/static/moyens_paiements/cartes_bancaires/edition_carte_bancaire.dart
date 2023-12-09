import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/tools/widgets/c_outlined_button.dart';
import 'package:wan_mobile/views/controllers/paiement/edition_card_bank_vctl.dart';

class EditionCarteBancaire extends StatelessWidget {
  const EditionCarteBancaire({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edition carte bancaire"),
      ),
      body: GetBuilder<EditionCardBankVctl>(
          init: EditionCardBankVctl(),
          builder: (ctl) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
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
                      borderColor: AssetColors.blue,
                      textColor: AssetColors.blue,
                      height: 40,
                      minWidth: 200,
                      onPressed: ctl.scanCard,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.document_scanner_rounded,
                            color: AssetColors.blue,
                          ),
                          Gap(10),
                          Text("Scanner la carte"),
                        ],
                      ),
                    ),
                    const Gap(20),
                    const TextDivider(
                      text: Text(
                        "Saisir les informations de la carte",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
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
                    CButton(
                      color: AssetColors.blue,
                      borderRadius: 8,
                      height: 50,
                      minWidth: double.infinity,
                      onPressed: ctl.addCard,
                      child: const Text(
                        "Confirmer",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
