import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/views/controllers/auth/profil_page_vctl.dart';

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
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text("Nom complet"),
                  subtitle: Text(ctl.appCtl.user.firstName.value),
                ),
                ListTile(
                  leading: const Icon(Icons.email),
                  title: const Text("Email"),
                  subtitle: Text(ctl.appCtl.user.email.value),
                ),
                ListTile(
                  leading: const Icon(Icons.phone),
                  title: const Text("Téléphone"),
                  subtitle: Text(ctl.appCtl.user.phoneNumber.value),
                ),
              ],
            ),
          );
        });
  }
}
