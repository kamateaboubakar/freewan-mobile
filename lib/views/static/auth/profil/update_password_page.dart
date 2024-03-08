import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/views/controllers/auth/profil/update_password_page_vctl.dart';

class UpdatePasswordPage extends StatelessWidget {
  const UpdatePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UpdatePasswordPageVctl>(
      init: UpdatePasswordPageVctl(),
      builder: (ctl) {
        return Scaffold(
          appBar: AppBar(title: const Text("Modification du mot de passe")),
          body: Form(
            key: ctl.formKey,
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                CTextFormField(
                  require: true,
                  obscureText: true,
                  controller: ctl.oldPassCtl,
                  labelText: "Ancien mot de passe",
                  keyboardType: TextInputType.number,
                  maxLength: 5,
                ),
                CTextFormField(
                  require: true,
                  obscureText: true,
                  controller: ctl.newPassCtl,
                  labelText: "Nouveau mot de passe",
                  keyboardType: TextInputType.number,
                  maxLength: 5,
                ),
                CTextFormField(
                  require: true,
                  obscureText: true,
                  controller: ctl.confirmPassCtl,
                  labelText: "Confirmez le nouveau mot de passe",
                  keyboardType: TextInputType.number,
                  maxLength: 5,
                ),
                const Gap(10),
                CButton(
                  height: 50,
                  color: AssetColors.blue,
                  minWidth: double.infinity,
                  onPressed: ctl.submit,
                  child: const Text("Valider"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
