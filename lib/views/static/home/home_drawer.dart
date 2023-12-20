import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wan_mobile/tools/const/const.dart';
import 'package:wan_mobile/views/controllers/home/home_page_vctl.dart';
import 'package:wan_mobile/views/static/adresse/adresse_list_page.dart';
import 'package:wan_mobile/views/static/agence_a_proximite/agence_a_proximite.dart';
import 'package:wan_mobile/views/static/auth/profil_page.dart';
import 'package:wan_mobile/views/static/cgu_page.dart';
import 'package:wan_mobile/views/static/home/qr_login/qr_login.dart';
import 'package:wan_mobile/views/static/moyens_paiements/moyens_paiements_page.dart';

class HomeDrawer extends StatelessWidget {
  final HomePageVctl ctl;
  const HomeDrawer(this.ctl, {super.key});

  @override
  Widget build(BuildContext context) {
    if (ctl.appCtl.user.phoneNumber != null) {
      return Drawer(
        width: Get.width - 80,
        child: Column(
          children: [
            Container(
              height: 200,
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: Image.asset("assets/images/image_pont.jpeg").image,
                  fit: BoxFit.cover,
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    child: Image.asset(
                      "assets/images/icons/user_profil.png",
                      height: 45,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: ListTile(
                        title: Text(
                          ctl.user.fullName,
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // UserAccountsDrawerHeader(
            //   margin: EdgeInsets.zero,
            //   decoration: BoxDecoration(
            //     image: DecorationImage(
            //       fit: BoxFit.cover,
            //       opacity: .78,
            //       image: Image.asset("assets/images/image_pont.jpeg").image,
            //       // colorFilter: const ColorFilter.mode(
            //       //   AssetColors.blue,
            //       //   BlendMode.exclusion,
            //       // ),
            //     ),
            //   ),
            //   currentAccountPicture: CircleAvatar(
            //     backgroundColor: AssetColors.blue,
            //     child: Image.asset(
            //       "assets/images/icons/user_profil.png",
            //       height: 45,
            //       color: Colors.white,
            //     ),
            //   ),
            //   accountName: const Text(
            //     "",
            //     maxLines: 1,
            //     style: TextStyle(
            //       fontSize: 22,
            //       fontWeight: FontWeight.bold,
            //       color: Colors.black,
            //     ),
            //   ),
            //   accountEmail: Text(
            //     ctl.appCtl.user.fullName,
            //     style: const TextStyle(
            //       fontSize: 20,
            //       fontWeight: FontWeight.bold,
            //       color: Colors.black,
            //     ),
            //   ),
            //   // otherAccountsPictures: [
            //   //   IconButton(
            //   //     tooltip: "Déconnexion",
            //   //     onPressed: ctl.logout,
            //   //     color: Colors.white,
            //   //     icon: const Icon(Icons.logout),
            //   //   ),
            //   // ],
            // ),
            Expanded(
              child: Stack(
                children: [
                  const SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                  ),
                  ListView(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      ListTile(
                        style: ListTileStyle.drawer,
                        leading: CircleAvatar(
                          child: Image.asset(
                            "assets/images/icons/user_profil.png",
                            height: 30,
                            color: Colors.white,
                          ),
                        ),
                        title: const Text("Mon profil"),
                        onTap: () => Get.to(() => const ProfilPage()),
                      ),
                      ListTile(
                        style: ListTileStyle.drawer,
                        leading: CircleAvatar(
                          child: Image.asset(
                            "assets/images/icons/iportefeuille.png",
                            height: 25,
                          ),
                        ),
                        title: const Text("Mes moyens de paiement"),
                        onTap: () => Get.to(() => const MoyensPaiementsPage()),
                      ),
                      ListTile(
                        style: ListTileStyle.drawer,
                        leading: CircleAvatar(
                          child: Image.asset(
                            "assets/images/icons/qr_code.png",
                            height: 30,
                            color: Colors.white,
                          ),
                        ),
                        title: const Text("Se connecter sur le web"),
                        onTap: () => Get.to(() => const QrLogin()),
                      ),
                      ListTile(
                        style: ListTileStyle.drawer,
                        leading: CircleAvatar(
                          child: Image.asset(
                            "assets/images/icons/adresse.png",
                            height: 30,
                          ),
                        ),
                        title: const Text("Mes adresses"),
                        onTap: () => Get.to(() => const AdresseListPage()),
                      ),
                      ListTile(
                        style: ListTileStyle.drawer,
                        leading: CircleAvatar(
                          child: Image.asset(
                            "assets/images/icons/agence_a_proximite.png",
                            height: 30,
                          ),
                        ),
                        title: const Text("Agences à proximité"),
                        onTap: () => Get.to(() => const AgenceAProximite()),
                      ),
                      ListTile(
                        style: ListTileStyle.drawer,
                        leading: CircleAvatar(
                          child: Image.asset(
                            "assets/images/icons/assistant.png",
                            height: 25,
                            color: Colors.white,
                          ),
                        ),
                        title: const Text("Contactez-nous"),
                        onTap: () => launchUrl(
                          Uri.parse("https://wa.me/${Const.supportWhatsapp}"),
                          mode: LaunchMode.externalApplication,
                        ),
                      ),
                      ListTile(
                        style: ListTileStyle.drawer,
                        leading: CircleAvatar(
                          child: Image.asset(
                            "assets/images/icons/partager.png",
                            height: 30,
                            color: Colors.white,
                          ),
                        ),
                        title: const Text("Partager l'application"),
                        onTap: () => ctl.shareAppText(
                            codeParrain: ctl.appCtl.user.ownerCode.value),
                      ),
                      ListTile(
                        style: ListTileStyle.drawer,
                        leading: CircleAvatar(
                          child: Image.asset(
                            "assets/images/icons/cgu.png",
                            height: 30,
                            color: Colors.white,
                          ),
                        ),
                        title: const Text("Conditions d'utilisation"),
                        onTap: () => Get.to(() => const CGUPage()),
                      ),
                      ListTile(
                        style: ListTileStyle.drawer,
                        leading: const CircleAvatar(
                          child: Icon(Icons.logout_sharp),
                        ),
                        title: const Text("Déconnexion"),
                        onTap: ctl.logout,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Image.asset(
              "assets/images/abidjan-vectoriel.png",
              // color: AssetColors.blue.withOpacity(.5),
              // colorBlendMode: BlendMode.srcATop,
            ),
            const ListTile(
              style: ListTileStyle.drawer,
              dense: true,
              contentPadding: EdgeInsets.zero,
              title: Text(
                "${Const.appName} © 2023 - V${Const.appVersion}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      );
    }
    return const Drawer();
  }
}
