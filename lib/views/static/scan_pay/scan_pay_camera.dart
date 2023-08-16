import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:module_master/utils/asset_colors.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:wan_mobile/views/controllers/scan_pay/scan_pay_camera_vctl.dart';
import 'package:wan_mobile/views/static/paiement/paiement_montant.dart';

class ScanPayCamera extends StatelessWidget {
  const ScanPayCamera({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ScanPayCameraVctl>(
      init: ScanPayCameraVctl(),
      builder: (ctl) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            // actions: [
            //   IconButton(
            //       onPressed: () => Get.off(
            //             () => const PaiementMontant(
            //               isForMontant: true,
            //             ),
            //           ),
            //       icon: const Icon(Icons.keyboard)),
            //   IconButton(
            //     onPressed: () => Get.off(
            //       () => const PaiementMontant(),
            //     ),
            //     icon: const Icon(Icons.qr_code),
            //   ),
            // ],
          ),
          extendBodyBehindAppBar: true,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: AssetColors.blueButton,
            onPressed: () => Get.to(() => PaiementMontant()),
            label: const Row(
              children: [
                Icon(Icons.keyboard_alt, size: 19),
                SizedBox(width: 10),
                Text(
                  "Pas de QR, Payez via ID",
                  style: TextStyle(),
                )
              ],
            ),
          ),
          body: Stack(
            children: [
              QRView(
                key: ctl.qrKey,
                onQRViewCreated: (qrCtl) => ctl.onQRViewCreated(qrCtl),
                overlay: QrScannerOverlayShape(
                  borderRadius: 30,
                  borderWidth: 30,
                  borderColor: Colors.white,
                ),
              ),
              Align(
                alignment: const Alignment(0, .5),
                child: FutureBuilder<bool?>(
                  future: ctl.controller?.getFlashStatus(),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return MaterialButton(
                        elevation: 5,
                        shape: const CircleBorder(),
                        height: 50,
                        minWidth: 50,
                        color: snapshot.data! ? Colors.white : Colors.white60,
                        textColor: AssetColors.blueButton,
                        onPressed: () {
                          ctl.controller?.toggleFlash();
                          ctl.update();
                        },
                        child: const Icon(
                          Icons.flash_on,
                          size: 35,
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
