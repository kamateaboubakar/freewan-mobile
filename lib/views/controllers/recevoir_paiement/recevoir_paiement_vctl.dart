import 'dart:async';

import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';

class RecevoirPaiementVctl extends ViewController {
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
