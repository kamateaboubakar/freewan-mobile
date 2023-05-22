import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/views/static/paiement/paiement_operation_success.dart';
import 'package:wan_mobile/views/static/scan_pay/scan_pay_operation_en_cours.dart';

import '../../../controllers/gaz/gas_shop_vctl.dart';
import '../../../controllers/gaz/gas_vctl.dart';

class GazPaymentRecapPage extends StatefulWidget {
  const GazPaymentRecapPage({super.key});

  @override
  State<GazPaymentRecapPage> createState() => _GazPaymentRecapPageState();
}

class _GazPaymentRecapPageState extends State<GazPaymentRecapPage> {
  GasController _gasController = Get.put(GasController());
  GasShopController _gasShopController = Get.put(GasShopController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text("Confirmation"),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 34, left: 20, right: 20),
        child: CButton(
          height: 48,
          onPressed: () {
            _submitOrder();
          },
          child: const Text(
            "Confirmer",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/Orange-Money-logo-2048x1375_1.png",
                height: 45,
              ),
              const SizedBox(height: 13),
              const Text(
                "07 07 45 25 23",
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 28),
              Stack(alignment: Alignment.center, children: [
                Image.asset("assets/images/Rectangle_39.png"),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  "assets/images/chariot.png",
                                  width: 17,
                                  height: 17,
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  "Montant",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "${_gasShopController.gasSize!.price!} FCFA",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Divider(color: Color.fromRGBO(71, 36, 251, 1)),
                    const SizedBox(height: 13),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  "assets/images/Vector_frais.png",
                                  width: 17,
                                  height: 17,
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  "Frais",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Text(
                            "0 FCFA",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 13),
                    const Divider(color: Color.fromRGBO(45, 128, 236, 1)),
                    const SizedBox(height: 27),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  "assets/images/portefeuil.png",
                                  width: 17,
                                  height: 17,
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  "Total à payer",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "${_gasShopController.gasSize!.price!} FCFA",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ]),
            ],
          ),
        ),
      ),
    );
  }

  void _submitOrder() async {
    var pr = Tools.progressDialog();
    pr.show();
    var response = await _gasController.submitOrder(
      gasSize: _gasShopController.gasSize!,
      shop: _gasShopController.shop,
      userlocation:
          _gasController.deliveryLocation ?? _gasController.userLocation!,
    );
    Get.back();
    if (!response.status) {
      Tools.messageBox(message: response.message!);
      return;
    }

    Get.to(
      () => const PaiementOperationSucess(
        animationAsset: "assets/lotties/88063-delivery-icon.json",
        description: "Vous serez livrés dans les plus\nbrefs délais",
      ),
    );
  }
}
