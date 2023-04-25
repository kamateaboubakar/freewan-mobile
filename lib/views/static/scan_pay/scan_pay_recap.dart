import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/views/static/scan_pay/scan_pay_operation_en_cours.dart';

class ScanPayRecap extends StatelessWidget {
  const ScanPayRecap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        foregroundColor: Colors.black,
        title: const Text("Confirmation"),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 34, left: 20, right: 20),
        child: CButton(
          height: 48,
          color: const Color.fromRGBO(13, 51, 159, 1),
          onPressed: () => Get.to(() => const ScanPayOperationEnCours()),
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
                          const Text(
                            "90 000 FCFA",
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
                            "900 FCFA",
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
                          const Text(
                            "90 900 FCFA",
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
}
