import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/views/controllers/marchand/marchand_register_page_vctl.dart';

class MarchandRegisterPage extends StatelessWidget {
  const MarchandRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MarchandRegisterPageVctl>(
      init: MarchandRegisterPageVctl(),
      builder: (ctl) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Devenir Marchand"),
          ),
          body: Form(
            key: ctl.formKey,
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                CDropdownField(
                  require: true,
                  labelText: "Pays",
                  asyncItems: (e) => ctl.getPays(),
                  selectedItem: ctl.selectedPays,
                  itemAsString: (e) => e.label.value,
                  onChanged: (e) {
                    ctl.selectedPays = e;
                    ctl.update();
                  },
                ),
                CTextFormField(
                  require: true,
                  controller: ctl.nomCtl,
                  textCapitalization: TextCapitalization.words,
                  labelText: "Nom",
                ),
                CTextFormField(
                  controller: ctl.prenomCtl,
                  labelText: "Prénom(s)",
                  require: true,
                  textCapitalization: TextCapitalization.words,
                ),
                CTextFormField(
                  require: true,
                  controller: ctl.emailCtl,
                  keyboardType: TextInputType.emailAddress,
                  labelText: "Email",
                ),
                CTextFormField(
                  maxLength: ctl.selectedPays?.phoneNumberLength,
                  minLength: ctl.selectedPays?.phoneNumberLength,
                  require: true,
                  controller: ctl.telCtl,
                  labelText: "Téléphone",
                  keyboardType: TextInputType.number,
                ),
                const Gap(10),
                const TextDivider(text: Text("Mot de passe")),
                const Gap(10),
                CTextFormField(
                  require: true,
                  controller: ctl.passwordCtl,
                  obscureText: ctl.hidePass,
                  labelText: "Mot de passe",
                  maxLength: 4,
                  minLength: 4,
                ),
                CTextFormField(
                  require: true,
                  controller: ctl.confirmPasswordCtl,
                  labelText: "Confirmation du mot de passe",
                  obscureText: ctl.hidePass,
                  maxLength: 4,
                  minLength: 4,
                  validator: (value) {
                    if (value.value.isEmpty) {
                      return "Ce champ est obligatoire";
                    } else {
                      if (value != ctl.passwordCtl.text) {
                        return "Les mots de passe ne sont pas identiques";
                      }
                      return null;
                    }
                  },
                ),
                const Gap(10),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text("Cacher les mots de passe"),
                  value: ctl.hidePass,
                  onChanged: (e) {
                    ctl.hidePass = e;
                    ctl.update();
                  },
                ),
                const Gap(20),
                CButton(
                  height: 50,
                  color: AssetColors.blue,
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
