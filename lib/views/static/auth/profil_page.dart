import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
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
              const Gap(20),
              CircleAvatar(
                radius: 50,
                child: Image.asset(
                  "assets/images/icons/user_profil.png",
                  color: Colors.white,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text("Nom"),
                subtitle: Text(ctl.appCtl.user.lastName.value),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text("Prénoms"),
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
                subtitle: Text("+225 ${ctl.appCtl.user.phoneNumber.value}"),
              ),
            ],
          ),
        );
      },
    );
  }
}
