import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wan_mobile/tools/const/const.dart';

import 'package:wan_mobile/views/controllers/home/home_page_vctl.dart';
import 'package:wan_mobile/views/static/adresse/adresse_list_page.dart';
import 'package:wan_mobile/views/static/auth/profil_page.dart';
import 'package:wan_mobile/views/static/cgu_page.dart';
import 'package:wan_mobile/views/static/home/qr_login/qr_login.dart';

class HomeDrawer extends StatelessWidget {
  final HomePageVctl ctl;
  const HomeDrawer(this.ctl, {super.key});

  @override
  Widget build(BuildContext context) {
    if (ctl.appCtl.user.phoneNumber != null) {
      return Drawer(
        width: Get.width - 40,
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: Colors.blue.shade900,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  opacity: .8,
                  image: Image.asset("assets/images/pont-cocody.jpg").image,
                ),
              ),
              currentAccountPicture: CircleAvatar(
                child: Image.asset(
                  "assets/images/icons/user_profil.png",
                  height: 45,
                  color: Colors.white,
                ),
              ),
              accountName: Text(
                "Akwaba, ${ctl.appCtl.user.firstPrenom}",
                style: const TextStyle(
                  fontSize: 20,
                  // color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: Text(
                ctl.appCtl.user.phoneNumber.value,
                style: const TextStyle(
                  fontSize: 18,
                  // color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              otherAccountsPictures: [
                IconButton(
                  tooltip: "Déconnexion",
                  onPressed: ctl.logout,
                  color: Colors.white,
                  icon: const Icon(Icons.logout),
                ),
              ],
            ),
            Expanded(
              child: Stack(
                children: [
                  // Opacity(
                  //   opacity: .3,
                  //   child: Image.asset(
                  //     "assets/images/pont_ado_carre.jpeg",
                  //   ),
                  // ),
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          // end: Alignment.bottomCenter,
                          colors: [
                            Colors.blue.shade700,
                            Colors.white,
                          ]),
                    ),
                  ),
                  ListView(
                    padding: EdgeInsets.zero,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      ListTile(
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
                        leading: CircleAvatar(
                          child: Image.asset(
                            "assets/images/icons/iportefeuille.png",
                            height: 25,
                          ),
                        ),
                        title: const Text("Mes moyens de paiement"),
                        onTap: () => Get.to(() => const CGUPage()),
                      ),
                      ListTile(
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
                        leading: CircleAvatar(
                          child: Image.asset(
                            "assets/images/icons/agence_a_proximite.png",
                            height: 30,
                          ),
                        ),
                        title: const Text("Agences à proximité"),
                        onTap: () => Get.to(() => const AdresseListPage()),
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          child: Image.asset(
                            "assets/images/icons/whatsapp.png",
                            height: 35,
                          ),
                        ),
                        title: const Text("Contactez-nous"),
                        onTap: () => launchUrl(
                          Uri.parse("https://wa.me/${Const.supportWhatsapp}"),
                          mode: LaunchMode.externalApplication,
                        ),
                      ),
                      ListTile(
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
                    ],
                  ),
                ],
              ),
            ),
            Image.asset("assets/images/abidjan-vectoriel.png"),
            const ListTile(
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
        // Scaffold(
        //   appBar: AppBar(
        //     backgroundColor: Colors.transparent,
        //     leading: IconButton(
        //       splashRadius: 20,
        //       icon: const Icon(
        //         Icons.arrow_back,
        //         color: Colors.black,
        //       ),
        //       onPressed: () => Get.back(),
        //     ),
        //     title: Image.asset(
        //       Const.appLogo,
        //       width: 100,
        //     ),
        //   ),
        //   bottomNavigationBar: const SizedBox(
        //     height: 30,
        //     child: Center(
        //       child: Text(
        //         "${Const.appName} © 2023 - V${Const.appVersion}",
        //         style: TextStyle(
        //           fontSize: 12,
        //           color: Colors.black26,
        //         ),
        //       ),
        //     ),
        //   ),
        //   body: (ctl.appCtl.user.email != null)
        //       ? ListView(
        //           children: [
        //             ListTile(
        //               title: const Text("Bienvenue"),
        //               subtitle: Text(ctl.appCtl.user.firstName.value),
        //             ),
        //             ListTile(
        //               title: const Text("Email"),
        //               subtitle: Text(ctl.appCtl.user.email.value),
        //             ),
        //             ListTile(
        //               title: const Text("Téléphone"),
        //               subtitle: Text(ctl.appCtl.user.phoneNumber.value),
        //             ),
        //             ListTile(
        //               title: const Text("Déconnexion"),
        //               trailing: const Icon(Icons.logout),
        //               onTap: () => ctl.logout(),
        //             ),
        //           ],
        //         )
        //       : ListView(
        //           padding: const EdgeInsets.all(20),
        //           children: [
        //             const SizedBox(height: 20),
        //             const Text(
        //               "Welcome to Wan",
        //               style: TextStyle(fontSize: 20),
        //             ),
        //             const SizedBox(height: 8),
        //             const Text("Unlock the full Paytm Experience by"
        //                 " logging into your account"),
        //             const SizedBox(height: 30),
        //             CButton(
        //               borderRadius: 3,
        //               height: 45,
        //               onPressed: () => Get.to(() => const PhoneAuth()),
        //               child: const Text("Login"),
        //             ),
        //             const SizedBox(height: 40),
        //             Container(
        //               decoration: BoxDecoration(
        //                 borderRadius: BorderRadius.circular(10),
        //                 border: Border.all(
        //                   color: Colors.grey.withOpacity(0.5),
        //                 ),
        //               ),
        //               padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
        //               child: Column(
        //                 children: [
        //                   const ListTile(
        //                     leading: Icon(Icons.tire_repair),
        //                     title: Text("24x7 Help & Support"),
        //                     subtitle: Text(
        //                       "Customer support, Your Queries, Frequenlty asked Questions",
        //                       style: TextStyle(fontSize: 11),
        //                     ),
        //                   ),
        //                   Divider(
        //                     indent: 80,
        //                     color: Colors.grey.withOpacity(0.5),
        //                   ),
        //                   const ListTile(
        //                     leading: Icon(Icons.translate),
        //                     title: Text("24x7 Help & Support"),
        //                     subtitle: Text(
        //                       "Use Wan in your prefered language",
        //                       style: TextStyle(fontSize: 11),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             )
        //           ],
        //         ),
        // ),
      );
    }
    return const Drawer();
  }
}
