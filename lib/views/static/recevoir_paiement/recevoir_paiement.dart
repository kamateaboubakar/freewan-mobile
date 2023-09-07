import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/views/controllers/recevoir_paiement/recevoir_paiement_vctl.dart';

class RecevoirPaiement extends StatelessWidget {
  const RecevoirPaiement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AssetColors.blueButton,
      appBar: AppBar(
        title: const Text("Réception d’argent"),
      ),
      body: GetBuilder<RecevoirPaiementVctl>(
          init: RecevoirPaiementVctl(),
          builder: (ctl) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      height: Get.height / 2,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Column(
                        children: [
                          const ListTile(
                            title: Text(
                              "Faites scanner le qr code",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Expanded(
                            child: (ctl.qrData == null)
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : QrImageView(data: ctl.qrData.value),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
