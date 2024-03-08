import 'package:lebedoo_assets/views/controllers/abstracts/view_controller.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/tools/cache/cache_keys.dart';

class ProfilPageVctl extends ViewController {
  bool biometricAuthStatus = true;

  Future<void> _getbiometricAuthStatus() async {
    var res = await Cache.getBool(CacheKey.biometricAuthStatus.name);
    biometricAuthStatus = res ?? false;
    update();
  }

  @override
  void onReady() {
    _getbiometricAuthStatus();
    super.onReady();
  }

  Future<void> updateBiometricAuthStatus(bool status) async {
    biometricAuthStatus = status;
    await Cache.setBool(CacheKey.biometricAuthStatus.name, biometricAuthStatus);
    update();
  }
}
