import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/tools/const/const.dart';
import 'package:wan_mobile/tools/services/share_app.dart';
import 'package:wan_mobile/views/controllers/auth/profil_page_vctl.dart';
import 'package:wan_mobile/views/static/auth/profil/carte_identite_page.dart';
import 'package:wan_mobile/views/static/auth/profil/security_questions/securite_question_user_page.dart';
import 'package:wan_mobile/views/static/auth/profil/update_password_page.dart';
import 'package:wan_mobile/views/static/auth/profil/update_profil_page.dart';
import 'package:wan_mobile/views/static/cgu_page.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfilPageVctl>(
      init: ProfilPageVctl(),
      builder: (ctl) {
        return Scaffold(
          appBar: AppBar(title: const Text("Profil")),
          body: ListView(
            children: [
              const Gap(20),
              Center(
                child: Badge(
                  position: BadgePosition.bottomEnd(bottom: -3, end: -3),
                  badgeStyle: const BadgeStyle(
                    badgeColor: Colors.white,
                    padding: EdgeInsets.all(2),
                  ),
                  badgeContent: const CircleAvatar(
                    backgroundColor: AssetColors.blue,
                    foregroundColor: Colors.white,
                    radius: 16,
                    child: Icon(
                      Icons.edit,
                      size: 17,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 50,
                    child: Image.asset(
                      "assets/images/icons/user_profil.png",
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  ctl.user.fullName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  children: [
                    const Gap(5),
                    Text(
                      ctl.user.fullPhone,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      ctl.user.email.value,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const Gap(10),
              Center(
                child: CButton(
                  color: AssetColors.blue,
                  onPressed: () => Get.to(() => const UpdateProfilPage())
                      ?.then((value) => ctl.update()),
                  borderRadius: 10,
                  minWidth: 250,
                  height: 40,
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.edit),
                      Gap(10),
                      Text(
                        "Modifier le profil",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: SettingsGroup(
                  items: [
                    SettingsItem(
                      onTap: () => Get.to(() => const CarteIdentitePage()),
                      icons: Icons.chrome_reader_mode_rounded,
                      iconStyle: IconStyle(
                        backgroundColor: AssetColors.blue,
                      ),
                      title: "Ma carte d'identité",
                    ),
                    SettingsItem(
                      onTap: () => Get.to(() => const UpdatePasswordPage()),
                      icons: Icons.lock,
                      iconStyle: IconStyle(backgroundColor: Colors.red),
                      title: 'Modifier mon mot de passe',
                    ),
                    SettingsItem(
                      onTap: () =>
                          Get.to(() => const SecuriteQuestionUserPage()),
                      icons: Icons.question_answer,
                      iconStyle: IconStyle(backgroundColor: Colors.red),
                      title: 'Questions de sécurité',
                      subtitle: "Modifier mes questions de sécurité",
                    ),
                    SettingsItem(
                      onTap: () {},
                      icons: Icons.fingerprint,
                      iconStyle: IconStyle(
                        iconsColor: Colors.white,
                        withBackground: true,
                        backgroundColor: Colors.green,
                      ),
                      title: "Authentification biométrique",
                      trailing: Switch(
                        value: ctl.biometricAuthStatus,
                        onChanged: ctl.updateBiometricAuthStatus,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: SettingsGroup(
                  settingsGroupTitle: "Contacts & Divers",
                  items: [
                    SettingsItem(
                      onTap: () => launchUrl(
                        Uri.parse("https://wa.me/${Const.supportWhatsapp}"),
                        mode: LaunchMode.externalApplication,
                      ),
                      icons: FontAwesomeIcons.whatsapp,
                      iconStyle: IconStyle(backgroundColor: Colors.green),
                      title: 'Contactez-nous',
                    ),
                    SettingsItem(
                      onTap: () => Get.to(() => const CGUPage()),
                      icons: FontAwesomeIcons.scaleBalanced,
                      iconStyle: IconStyle(backgroundColor: Colors.red),
                      title: "Conditions d'utilisation",
                    ),
                    SettingsItem(
                      onTap: () {},
                      icons: Icons.star,
                      iconStyle: IconStyle(backgroundColor: Colors.amber),
                      title: "Notez l'application",
                    ),
                    SettingsItem(
                      onTap: () => ShareApp.share(
                        codeParrain: ctl.appCtl.user.ownerCode.value,
                      ),
                      icons: Icons.share_sharp,
                      iconStyle: IconStyle(backgroundColor: Colors.deepOrange),
                      title: "Inviter des amis",
                    ),
                    SettingsItem(
                      onTap: () {},
                      icons: Icons.update,
                      iconStyle: IconStyle(backgroundColor: Colors.deepOrange),
                      title: "Version actuelle",
                      subtitle: Const.appVersion,
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
