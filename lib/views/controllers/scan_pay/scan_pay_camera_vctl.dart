import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:lebedoo_assets/views/controllers/abstracts/view_controller.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:tools_flutter_project/tools/types/int.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/api/controllers/auth/user_api_ctl.dart';
import 'package:wan_mobile/views/static/paiement/paiement_montant.dart';
// import 'package:qrscan/qrscan.dart' as scanner;

class ScanPayCameraVctl extends ViewController {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  QRViewController? controller;

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
              DateTime.fromMillisecondsSinceEpoch(timeStamp.toInt().value);

          if (validDate.isAfter(DateTime.now())) {
            await controller!.stopCamera();
            var qrAccount = qrData[0];
            var res = await UserApiCtl.checkUserQrCode(qrAccount: qrAccount);
            if (res.status) {
              Get.off(() => PaiementMontant(receiver: res.data!));
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
