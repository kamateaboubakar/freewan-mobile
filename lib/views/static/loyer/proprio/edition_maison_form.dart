import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wan_mobile/models/loyer/maison.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/tools/widgets/c_textform_field.dart';
import 'package:wan_mobile/views/controllers/loyer/edition_maison_form_vctl.dart';
import 'package:wan_mobile/views/static/loyer/proprio/historique_paiement_loyer_page.dart';

class EditionMaisonForm extends StatelessWidget {
  final Maison item;
  const EditionMaisonForm(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Modifier une maison"),
        actions: [
          IconButton(
            onPressed: () =>
                Get.to(() => HistoriquePaiementLoyerPage(item.id!)),
            icon: const Icon(Icons.history),
          )
        ],
      ),
      body: GetBuilder<EditionMaisonFormCtl>(
          init: EditionMaisonFormCtl(item),
          builder: (ctl) {
            return Form(
              key: ctl.formKey,
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Visibility(
                    visible: ctl.item.id != null,
                    child: SizedBox(
                      // height: 200,
                      child: Column(
                        children: [
                          SelectableText(
                            ctl.item.code.value,
                            style: const TextStyle(
                              color: Color.fromRGBO(242, 153, 74, 1),
                              fontSize: 36,
                            ),
                          ),
                          const Text(
                            "Code de maison",
                            style: TextStyle(
                              color: Color.fromRGBO(242, 153, 74, 1),
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: 200,
                            child: CButton(
                              textColor: AssetColors.blueButton,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(9),
                                side: const BorderSide(
                                    color: AssetColors.blueButton),
                              ),
                              color: Colors.transparent,
                              onPressed: () => Share.share(
                                  'Voici le code de la maison : ${ctl.item.code.value}'),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.share),
                                  SizedBox(width: 5),
                                  Text("Partager code"),
                                ],
                              ),
                            ),
                          ),
                          const Divider(),
                          const Gap(20),
                          CTextFormField(
                            controller: ctl.nomLocalCtl,
                            labelText: "Nom",
                            require: true,
                            textCapitalization: TextCapitalization.sentences,
                          ),
                          CTextFormField(
                            controller: ctl.lieuCtl,
                            labelText: "Lieu",
                            require: true,
                            textCapitalization: TextCapitalization.sentences,
                          ),
                          CTextFormField(
                            controller: ctl.nbPieceCtl,
                            labelText: "Nombre de pièces",
                            require: true,
                            keyboardType: TextInputType.datetime,
                          ),
                          CTextFormField(
                            controller: ctl.loyerCtl,
                            labelText: "Loyer",
                            require: true,
                            keyboardType: TextInputType.datetime,
                          ),
                          CTextFormField(
                            controller: ctl.jourPaiement,
                            labelText: "Jour de paiement",
                            hintText: "Jour du mois limit de paiement",
                            require: true,
                            keyboardType: TextInputType.datetime,
                            validator: (value) {
                              if (value != null && value.isNotEmpty) {
                                if (value.isNum) {
                                  if (value.toInt() >= 1 &&
                                      value.toInt() <= 31) {
                                    return null;
                                  } else {
                                    return "Veuillez saisir un nombre entre 1 et 31";
                                  }
                                } else {
                                  return "Veuillez saisir un nombre entre 1 et 31";
                                }
                              } else {
                                return "Ce champs est obligatoire";
                              }
                            },
                          ),
                          const Gap(20),
                          CButton(
                            height: 50,
                            minWidth: double.infinity,
                            onPressed: () => ctl.submit(),
                            child: const Text("Valider"),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),

      // (blocAppartement.appartements.isEmpty)
      //           ? Center(
      //               child: Column(
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 children: [
      //                   Image.asset(
      //                     "assets/images/icons/empty_folder.png",
      //                     height: 200,
      //                   ),
      //                   const SizedBox(height: 20),
      //                   const Text("Aucun appartement"),
      //                 ],
      //               ),
      //             )
      //           : ListView(
      //               padding: const EdgeInsets.all(20),
      //               children: [
      //                 ListView.separated(
      //                   shrinkWrap: true,
      //                   primary: false,
      //                   separatorBuilder: (context, i) => const Divider(),
      //                   itemCount: blocAppartement.appartements.length,
      //                   itemBuilder: (context, i) {
      //                     var appart = blocAppartement.appartements[i];
      //                     return MaterialButton(
      //                       padding: const EdgeInsets.all(5),
      //                       onPressed: () => Get.to(() =>
      //                           FormEditionAppartement(
      //                               item: appart,
      //                               bloc: blocAppartement))?.then((value) {
      //                         if (value is Appartement) {
      //                           appart = value;
      //                           ctl.update();
      //                         }
      //                       }),
      //                       child: Column(
      //                         crossAxisAlignment: CrossAxisAlignment.start,
      //                         children: [
      //                           ListTile(
      //                             leading: Image.asset(
      //                               "assets/images/icons/immeuble.png",
      //                               width: 45,
      //                               height: 65,
      //                             ),
      //                             title: Text(
      //                               "Appartement ${appart.numeroAppartement.value}",
      //                               style: const TextStyle(
      //                                 fontSize: 18,
      //                               ),
      //                             ),
      //                             subtitle: Text(
      //                               "${appart.typeAppartement?.libelle.value}(${appart.loyer.toAmount()})",
      //                               style: const TextStyle(
      //                                 color: Color.fromRGBO(123, 131, 160, 1),
      //                                 fontSize: 13,
      //                               ),
      //                             ),
      //                             trailing: const Icon(
      //                               Icons.arrow_forward_ios,
      //                               size: 15,
      //                             ),
      //                           ),
      //                           MaterialButton(
      //                             elevation: 0,
      //                             shape: RoundedRectangleBorder(
      //                               borderRadius: BorderRadius.circular(7),
      //                             ),
      //                             color: Colors.blue.shade100,
      //                             onPressed: () => Get.to(() =>
      //                                 HistoriquePaiementLoyerPage(appart.id!)),
      //                             child: const Text(
      //                               "Voir l'historique des paiements",
      //                               style: TextStyle(
      //                                 color: AssetColors.blueButton,
      //                                 fontSize: 12,
      //                               ),
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                     );
      //                   },
      //                 ),
    );
  }
}
