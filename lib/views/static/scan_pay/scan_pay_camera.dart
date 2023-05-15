import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/_http/_stub/_file_decoder_stub.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:wan_mobile/views/controllers/scan_pay/scan_pay_camera_vctl.dart';
import 'package:wan_mobile/views/static/paiement/paiement_montant.dart';

import '../../../tools/utils/asset_colors.dart';

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
            onPressed: () {},
            label: Row(
              children: const [
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
                        shape: const CircleBorder(),
                        height: 50,
                        minWidth: 50,
                        color: Colors.white,
                        textColor: AssetColors.blueButton,
                        onPressed: () {
                          ctl.controller?.toggleFlash();
                          ctl.update();
                        },
                        child: Icon(
                          snapshot.data! ? Icons.flash_off : Icons.flash_on,
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
