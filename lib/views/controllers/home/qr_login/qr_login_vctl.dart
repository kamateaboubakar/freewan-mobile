import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:wan_mobile/api/controllers/qr_login/qr_login_api_ctl.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';

class QrLoginVctl extends ViewController {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  Future<void> onScan(String code) async {
    await pr.show();
    var res = await QrLoginApiCtl()
        .setUser(qrCode: code, userId: appCtl.user.accountId.value);
    await pr.hide();
    if (res.status) {
      Get.back();
    } else {
      await Tools.messageBox(message: res.message);
      if (controller != null) {
        controller!.resumeCamera();
      }
    }
  }

  onQRViewCreated(QRViewController ctl) {
    if (controller == null) {
      controller = ctl;
      update();
    }
    controller?.scannedDataStream.listen((scanData) {
      if (scanData.code != null) {
        controller!.pauseCamera();
        onScan(scanData.code!);
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
