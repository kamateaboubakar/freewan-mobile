import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:tools_flutter_project/tools/types/int.dart';
import 'package:wan_mobile/models/scolarite/search_etudiant_result.dart';

import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/views/static/scolarite/edition_paiement_scolarite_page.dart';

class DetailsEtudiantPage extends StatelessWidget {
  final SearchEtudiantResult result;
  const DetailsEtudiantPage(this.result, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Informations de l'étudiant"),
      ),
      bottomNavigationBar: Visibility(
        visible: result.resteAPayer.value > 0,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: CButton(
            height: 50,
            onPressed: () {
              var initialPage = Get.currentRoute;
              Get.to(
                () => EditionPaiementScolaritePage(result,
                    initialPage: initialPage),
              );
            },
            child: const Text("Effectuer un paiement >"),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Gap(20),
          Center(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 40,
                  child: Icon(Icons.person),
                ),
                const Gap(10),
                CTextFormField(
                  readOnly: true,
                  initialValue: result.etudiant!.numeroIdentification.value,
                  labelText: "Numéro d'identification",
                ),
                CTextFormField(
                  readOnly: true,
                  initialValue: result.etudiant!.nom.value,
                  labelText: "Nom",
                ),
                CTextFormField(
                  readOnly: true,
                  initialValue: result.etudiant!.prenoms.value,
                  labelText: "Prénoms",
                ),
                CTextFormField(
                  readOnly: true,
                  initialValue: result.etudiant!.sexe.value,
                  labelText: "Sexe",
                ),
                CTextFormField(
                  readOnly: true,
                  initialValue:
                      result.etudiant!.dateNaissance.toDateTime().toFrenchDate,
                  labelText: "Date de naissance",
                ),
                CTextFormField(
                  readOnly: true,
                  initialValue: result.etudiant!.lieuNaissance.value,
                  labelText: "Lieu de naissance",
                ),
              ],
            ),
          ),
          const TextDivider(text: Text("Informations académiques")),
          Column(
            children: [
              const Gap(10),
              CTextFormField(
                readOnly: true,
                labelText: "Ecole",
                initialValue:
                    result.classe!.niveauScolaire!.ecole!.libelle.value,
              ),
              CTextFormField(
                readOnly: true,
                labelText: "Classe",
                initialValue: result.classe!.niveauScolaire!.libelle.value,
              ),
              CTextFormField(
                readOnly: true,
                labelText: "Frais scolarité",
                initialValue: result.classe!.montantFraisScolarite.toAmount(),
              ),
              CTextFormField(
                readOnly: true,
                labelText: "Paiement effectué",
                initialValue: result.totalPaiement.toAmount(),
              ),
              CTextFormField(
                readOnly: true,
                labelText: "Reste à payer",
                initialValue: result.resteAPayer.toAmount(),
              ),
              CTextFormField(
                readOnly: true,
                labelText: "Année académique",
                initialValue: result.classe!.anneeScolaire.value,
              ),
            ],
          ),

          // const Gap(10),
          // CButton(
          //   height: 50,
          //   onPressed: () {},
          //   child: const Text("Anciens paiements"),
          // ),
          const Gap(20),
        ],
      ),
    );
  }
}
