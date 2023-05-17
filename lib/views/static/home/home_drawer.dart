import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/const/const.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/views/controllers/home/home_page_vctl.dart';
import 'package:wan_mobile/views/static/auth/phone_auth/phone_auth.dart';

class HomeDrawer extends StatelessWidget {
  final HomePageVctl ctl;
  const HomeDrawer(this.ctl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: Get.width - 40,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            splashRadius: 20,
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Get.back(),
          ),
          title: Image.asset(
            Const.appLogo,
            width: 100,
          ),
        ),
        bottomNavigationBar: const SizedBox(
          height: 30,
          child: Center(
            child: Text(
              "Wan © 2023 - V${Const.appVersion}",
              style: TextStyle(
                fontSize: 12,
                color: Colors.black26,
              ),
            ),
          ),
        ),
        body: (ctl.appCtl.user.email != null)
            ? ListView(
                children: [
                  ListTile(
                    title: const Text("Bienvenue"),
                    subtitle: Text(ctl.appCtl.user.firstName.value),
                  ),
                  ListTile(
                    title: const Text("Email"),
                    subtitle: Text(ctl.appCtl.user.email.value),
                  ),
                  ListTile(
                    title: const Text("Téléphone"),
                    subtitle: Text(ctl.appCtl.user.phoneNumber.value),
                  ),
                  ListTile(
                    title: const Text("Déconnexion"),
                    trailing: const Icon(Icons.logout),
                    onTap: () => ctl.logout(),
                  ),
                ],
              )
            : ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    "Welcome to Wan",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 8),
                  const Text("Unlock the full Paytm Experience by"
                      " logging into your account"),
                  const SizedBox(height: 30),
                  CButton(
                    borderRadius: 3,
                    height: 45,
                    onPressed: () => Get.to(() => const PhoneAuth()),
                    child: const Text("Login"),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                    padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
                    child: Column(
                      children: [
                        const ListTile(
                          leading: Icon(Icons.tire_repair),
                          title: Text("24x7 Help & Support"),
                          subtitle: Text(
                            "Customer support, Your Queries, Frequenlty asked Questions",
                            style: TextStyle(fontSize: 11),
                          ),
                        ),
                        Divider(
                          indent: 80,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        const ListTile(
                          leading: Icon(Icons.translate),
                          title: Text("24x7 Help & Support"),
                          subtitle: Text(
                            "Use Wan in your prefered language",
                            style: TextStyle(fontSize: 11),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
