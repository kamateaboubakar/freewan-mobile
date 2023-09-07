import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:wan_mobile/api/controllers/auth/user_api_ctl.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';
import 'package:wan_mobile/views/static/paiement/paiement_montant.dart';
// import 'package:qrscan/qrscan.dart' as scanner;

class ScanPayCameraVctl extends ViewController {
  String route;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  QRViewController? controller;

  ScanPayCameraVctl(this.route);

  onQRViewCreated(QRViewController ctl) {
    if (controller == null) {
      controller = ctl;
      update();
    }
    controller?.scannedDataStream.listen((scanData) async {
      if (scanData.code != null) {
        var qrData = scanData.code.value.split(".\$.");
        if (qrData.length > 1) {
          var timeStamp = qrData[1];
          var validDate =
              DateTime.fromMillisecondsSinceEpoch(timeStamp.toInt());

          if (validDate.isAfter(DateTime.now())) {
            await controller!.stopCamera();
            var qrAccount = qrData[0];
            var res = await UserApiCtl().checkUserQrCode(qrAccount: qrAccount);
            if (res.status) {
              Get.off(() => PaiementMontant(route, receiver: res.data!));
            } else {
              await controller!.resumeCamera();
              Tools.showToast(message: res.message);
            }
          } else {
            Tools.showToast(message: "Ce code est invalide.");
          }
        } else {
          await Tools.showToast(message: "Ce code est invalide.");
        }
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
