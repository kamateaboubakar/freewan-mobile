import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:wan_mobile/tools/const/const.dart';

abstract class ShareApp {
  static Future<void> share({required String codeParrain}) => Share.share(
      """😀 hey, inscris-toi sur *${AppConst.appName}* avec mon code de parrain : *$codeParrain*

Le premier Hub de service ivoirien totalement digital.

Téléchargez directement l'application sur :
AppStore : ${Const.appStoreLink}
PlayStore : ${Const.playStoreLink}

🥳🥳 ${Const.appSlogan}""");
}
