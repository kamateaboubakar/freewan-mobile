import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            actions: [
              IconButton(
                  onPressed: () => Get.off(
                        () => const PaiementMontant(
                          isForMontant: true,
                        ),
                      ),
                  icon: const Icon(Icons.keyboard)),
              IconButton(
                onPressed: () => Get.off(
                  () => const PaiementMontant(),
                ),
                icon: const Icon(Icons.qr_code),
              ),
              IconButton(
                onPressed: () {
                  ctl.controller?.toggleFlash();
                  ctl.update();
                },
                icon: FutureBuilder<bool?>(
                    future: ctl.controller?.getFlashStatus(),
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        return Icon(
                          snapshot.data! ? Icons.flash_off : Icons.flash_on,
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    }),
              )
            ],
          ),
          extendBodyBehindAppBar: true,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: const Color.fromRGBO(13, 51, 159, 1),
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
          body: QRView(
            key: ctl.qrKey,
            onQRViewCreated: (qrCtl) => ctl.onQRViewCreated(qrCtl),
            overlay: QrScannerOverlayShape(
              borderRadius: 30,
              borderWidth: 30,
              borderColor: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
