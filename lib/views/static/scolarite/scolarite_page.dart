import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/views/controllers/scolarite/scolarite_page_vctl.dart';

class ScolaritePage extends StatelessWidget {
  const ScolaritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ScolaritePageVctl>(
        init: ScolaritePageVctl(),
        builder: (ctl) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Scolarité"),
            ),
            body: Form(
              key: ctl.formKey,
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  const ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text("Veuillez entrer les informations"
                        " suivantes pour retrouver l'étudiant"),
                  ),
                  const Gap(10),
                  CTextFormField(
                    require: true,
                    controller: ctl.numIdCtl,
                    labelText: "Numéro d'identification",
                  ),
                  const Gap(10),
                  const Text("Année académique"),
                  const Gap(10),
                  Row(children: [
                    Expanded(
                      child: CTextFormField(
                        controller: ctl.anneeDebut,
                        labelText: "Début",
                        hintText: "2022",
                        require: true,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const Gap(10),
                    const Text("-"),
                    const Gap(10),
                    Expanded(
                      child: CTextFormField(
                        controller: ctl.anneeFin,
                        labelText: "Fin",
                        hintText: "2023",
                        require: true,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ]),
                  const Gap(10),
                  CButton(
                    height: 50,
                    onPressed: ctl.submit,
                    child: const Text("Valider"),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
