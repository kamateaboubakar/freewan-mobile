import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/views/static/paiement/paiement_mode_paiement.dart';

import '../../../../tools/utils/asset_colors.dart';
import '../../../../tools/widgets/c_button.dart';

class BillsListPage extends StatefulWidget {
  @override
  State<BillsListPage> createState() => _BillsListPageState();
}

class _BillsListPageState extends State<BillsListPage> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text("Factures"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/cie.png',
                    height: 50,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Choisissez la facture que vous souhaitez\npayer',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        var selected = selectedIndex == index;
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: selected
                                  ? Color(0xff4724FB).withOpacity(0.1)
                                  : Colors.white,
                              border: Border.all(
                                color: selected
                                    ? Color(0xff0D339F)
                                    : Color(0xffB5C4D8),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 32),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Fac 452523',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                          style: TextStyle(
                                            color: Color(0xff7B83A0),
                                            fontSize: 16,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: '\$ ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: Color(0xff4724FB)),
                                            ),
                                            TextSpan(text: '45 000 FCFA'),
                                          ]),
                                    )
                                  ],
                                ),
                                SizedBox(height: 10),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xff4724FB).withOpacity(.10),
                                  ),
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'A payer avant le 5 mai 2023',
                                    style: TextStyle(
                                      color: Color(0xff4724FB),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 20);
                      },
                      itemCount: 2,
                    ),
                  )
                ],
              ),
            ),
            CButton(
              height: 50,
              onPressed: () {
                if (hasBillSelected()) {
                  Get.to(PaiementModePaiement());
                }
              },
              color: hasBillSelected()
                  ? AssetColors.blueButton
                  : Color(0xffEDF2F9),
              child: Text(
                "Continuer",
                style: TextStyle(
                  color: hasBillSelected() ? Colors.white : Color(0xffB5C4D8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool hasBillSelected() => selectedIndex != -1;
}
