import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lebedoo_assets/themes/asset_colors.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:wan_mobile/views/controllers/home/qr_login/qr_login_vctl.dart';

class QrLogin extends StatelessWidget {
  const QrLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QrLoginVctl>(
        init: QrLoginVctl(),
        builder: (ctl) {
          return Scaffold(
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
        });
  }
}
