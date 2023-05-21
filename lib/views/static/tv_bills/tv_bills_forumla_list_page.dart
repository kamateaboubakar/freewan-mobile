import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/views/static/paiement/paiement_mode_paiement.dart';

import '../../../../tools/utils/asset_colors.dart';
import '../../../../tools/widgets/c_button.dart';

class TvBillsFormulaListPage extends StatefulWidget {
  final bool newSubscription;

  TvBillsFormulaListPage({this.newSubscription = true});

  @override
  State<TvBillsFormulaListPage> createState() => _TvBillsFormulaListPageState();
}

class _TvBillsFormulaListPageState extends State<TvBillsFormulaListPage> {
  int selectedIndex = -1;

  late List<String> formula;

  @override
  void initState() {
    formula = [
      "Access",
      if (widget.newSubscription) ...[
        "Essentiel +",
        "Access +",
        "Evasion +",
        "Tout Canal +",
      ],
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text("Formule"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                children: [
                  if (widget.newSubscription) ...[
                    Text(
                      'Sélectionnez votre nouvelle formule',
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                  ],
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
                                  ? AssetColors.purple.withOpacity(0.20)
                                  : AssetColors.lightGrey,
                              borderRadius: BorderRadius.circular(10),
                              border: selected
                                  ? Border.all(color: AssetColors.blue)
                                  : null,
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 24),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/images/canal+2.png",
                                  width: 50,
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    formula[index],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                  size: 14,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 20);
                      },
                      itemCount: formula.length,
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