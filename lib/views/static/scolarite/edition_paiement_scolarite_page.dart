import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/models/scolarite/search_etudiant_result.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/tools/widgets/c_textform_field.dart';
import 'package:wan_mobile/views/controllers/scolarite/edition_paiement_page_vctl.dart';

class EditionPaiementScolaritePage extends StatelessWidget {
  final SearchEtudiantResult result;
  final String initialPage;
  const EditionPaiementScolaritePage(this.result,
      {required this.initialPage, super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditionPaiementScolaritePageVctl>(
        init:
            EditionPaiementScolaritePageVctl(result, initialPage: initialPage),
        builder: (ctl) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Paiement scolarité"),
            ),
            body: Form(
              key: ctl.formKey,
              child: ListView(
                padding: const EdgeInsets.all(10),
                children: [
                  const Gap(10),
                  CTextFormField(
                    initialValue: result.etudiant!.fullName,
                    labelText: "Etudiant",
                    enabled: false,
                  ),
                  CTextFormField(
                    initialValue: result.classe!.niveauScolaire!.libelle,
                    labelText: "Classe",
                    enabled: false,
                  ),
                  const Divider(),
                  const Gap(20),
                  CTextFormField(
                    require: true,
                    controller: ctl.montantCtl,
                    labelText: "Montant",
                    validator: (value) {
                      if (value.toInt().value == 0) {
                        return "Le montant doit être supérieur à 0";
                      } else {
                        if (value.toInt().value >
                            result.classe!.montantFraisScolarite.toInt()) {
                          return "Le montant doit être inférieur ou égal à ${result.resteAPayer.toAmount()}";
                        } else {
                          return null;
                        }
                      }
                    },
                  ),
                  const Gap(20),
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
