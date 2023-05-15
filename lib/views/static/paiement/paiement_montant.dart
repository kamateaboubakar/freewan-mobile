import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/views/static/paiement/paiement_mode_paiement.dart';

import '../../../tools/utils/asset_colors.dart';

class PaiementMontant extends StatelessWidget {
  final bool isForMontant;
  const PaiementMontant({this.isForMontant = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text(
          "Montant",
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(right: 19),
        child: SizedBox(
          height: 89,
          child: Row(
            children: [
              Expanded(
                child: Visibility(
                  visible: !isForMontant,
                  child: const ListTile(
                    title: Text(
                      "Total Achat",
                      style: TextStyle(
                        color: Color.fromRGBO(72, 76, 79, 1),
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      "90 000 FCFA",
                      style: TextStyle(
                        color: AssetColors.blueButton,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              CButton(
                height: 48,
                minWidth: 149,
                borderRadius: 8,
                onPressed: () => Get.to(() => const PaiementModePaiement()),
                child: const Text(
                  "Payer",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: (isForMontant)
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 63,
                    ),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "0.00 Fcfa",
                    ),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(24),
                margin: const EdgeInsets.only(top: 26),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 250, 250, 1),
                  borderRadius: BorderRadius.circular(9),
                ),
                width: Get.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/Jumia-logo-696x696 1.png",
                      width: 46,
                      height: 46,
                    ),
                    const SizedBox(height: 16),
                    Column(
                      children: List.generate(
                        6,
                        (index) => Column(
                          children: [
                            ListTile(
                              leading: Image.asset("assets/images/gant.png"),
                              title: const Text("Gants"),
                              trailing: const Text("15 000 FCFA"),
                              subtitle: const Text(
                                "x2",
                                style: TextStyle(
                                  color: Color.fromRGBO(71, 36, 251, 1),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const Divider()
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
