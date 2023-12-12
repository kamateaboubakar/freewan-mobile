import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:wan_mobile/tools/widgets/c_outlined_button.dart';
import 'package:wan_mobile/views/controllers/scan_pay/scan_pay_camera_vctl.dart';
import 'package:wan_mobile/views/static/qr_code/qr_code_page.dart';

class ScanPayCamera extends StatelessWidget {
  final String route;
  const ScanPayCamera(this.route, {super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ScanPayCameraVctl>(
      init: ScanPayCameraVctl(route),
      builder: (ctl) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            actions: [
              FutureBuilder<bool?>(
                future: ctl.controller?.getFlashStatus(),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    return IconButton(
                      color: snapshot.data! ? Colors.blue : Colors.white60,
                      onPressed: () {
                        ctl.controller?.toggleFlash();
                        ctl.update();
                      },
                      icon: const Icon(Icons.flash_on),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
          extendBodyBehindAppBar: true,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: Stack(
            children: [
              QRView(
                key: ctl.qrKey,
                onQRViewCreated: (qrCtl) => ctl.onQRViewCreated(qrCtl),
                overlay: QrScannerOverlayShape(
                  borderRadius: 30,
                  borderWidth: 30,
                  cutOutWidth: Get.width - 50,
                  cutOutHeight: Get.width - 50,
                  borderColor: Colors.white,
                ),
              ),
              Align(
                alignment: const Alignment(0, .7),
                child: COutlinedButton(
                  borderColor: Colors.white,
                  onPressed: () => Get.to(() => const QrCodePage()),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.qr_code),
                      Gap(10),
                      Text("Mon QR code"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
