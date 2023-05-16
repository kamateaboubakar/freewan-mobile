import 'package:get/get.dart';
import 'package:wan_mobile/models/user.dart';

class AppCtl extends GetxController {
  User _user = User();

  User get user => _user;

  set user(User value) {
    _user = value;
    update();
  }
}
