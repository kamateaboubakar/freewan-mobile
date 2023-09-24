import 'package:get/get.dart';
import 'package:wan_mobile/models/user.dart';

class AppCtl extends GetxController {
  User _user = User();
  String _jwtToken = "";
  var notifAccount = RxInt(0);

  set jwtToken(String value) {
    _jwtToken = value;
    update();
  }

  String get jwtToken => _jwtToken;

  User get user => _user;

  set user(User value) {
    _user = value;
    update();
  }
}
