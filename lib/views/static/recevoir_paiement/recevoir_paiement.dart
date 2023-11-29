import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lebedoo_assets/themes/asset_colors.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/tools/const/const.dart';

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
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Powered by", style: TextStyle(color: Colors.white)),
            Container(
              height: 50,
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(
                "assets/images/logo_freewan.png",
                height: 80,
              ),
            ),
          ],
        ),
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
                      padding: const EdgeInsets.all(15),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: (ctl.qrData == null)
                          ? const Center(child: CircularProgressIndicator())
                          : QrImageView(data: ctl.qrData.value),
                    ),
                    const Gap(10),
                    Image.asset(
                      Const.inLineAppLogo,
                      height: 35,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
