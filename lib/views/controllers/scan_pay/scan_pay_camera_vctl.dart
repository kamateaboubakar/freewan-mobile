import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';
// import 'package:qrscan/qrscan.dart' as scanner;

class ScanPayCameraVctl extends ViewController {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  QRViewController? controller;
  // Future<void> onScan() async {
  //   var permission = await Permission.camera.request();
  //   if (permission.isGranted) {
  //     String? cameraScanResult = await scanner.scan();
  //     print(cameraScanResult);
  //   } else {
  //     Tools.messageBox(
  //         message: "Vous devez donner l'autorisation à "
  //             "l'application d'accéder à l'appareil photo");
  //   }
  // }

  // @override
  // void onInit() {
  //   super.onInit();
  //   // onScan();
  // }

  onQRViewCreated(QRViewController ctl) {
    if (controller == null) {
      controller = ctl;
      update();
    }
    controller?.scannedDataStream.listen((scanData) {
      // if (scanData.code != null) {
      //   controller!.dispose();

      //   // await controller!.stopCamera();
      //   Get.to(() => const ScanPayMontant());
      //   // await controller!.resumeCamera();
      // }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
