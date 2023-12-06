import 'dart:async';

import 'package:lebedoo_assets/views/controllers/abstracts/view_controller.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';

class CodeQRGeneratorVctl extends ViewController {
  String? qrData;
  Timer? timer;

  void _getQrCodeValue() {
    timer = Timer.periodic(const Duration(seconds: 20), (timer) {
      qrData = _buildQrData();
      update();
    });
  }

  @override
  void onInit() {
    super.onInit();
    qrData = _buildQrData();
    update();
  }

  String _buildQrData() {
    var timeStamp = DateTime.now().add(const Duration(seconds: 20));
    return "${appCtl.user.qrAccount.value}.\$.${timeStamp.millisecondsSinceEpoch}";
  }

  @override
  void onReady() {
    super.onReady();
    _getQrCodeValue();
  }

  @override
  void onClose() {
    if (timer != null) {
      timer!.cancel();
    }
    super.onClose();
  }
}
