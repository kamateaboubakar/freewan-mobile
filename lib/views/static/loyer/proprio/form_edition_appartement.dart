import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wan_mobile/models/loyer/abstracts/bloc_appartement.dart';
import 'package:wan_mobile/models/loyer/appartement.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:module_master/module_master.dart';
import 'package:module_master/module_master.dart';

import 'package:wan_mobile/views/controllers/loyer/form_edition_appartement_ctl.dart';

class FormEditionAppartement extends StatelessWidget {
  final Appartement? item;
  final BlocAppartement? bloc;
  const FormEditionAppartement({this.bloc, this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text((item?.id != null)
            ? "Modififer un appartement"
            : "Ajouter un appartement"),
      ),
      body: GetBuilder<FormEditionAppartementVctl>(
          init: FormEditionAppartementVctl(editedItem: item, blocAppart: bloc),
          builder: (ctl) {
            return Form(
              key: ctl.formKey,
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Visibility(
                    visible: ctl.editedItem?.id != null,
                    child: SizedBox(
                      // height: 200,
                      child: Column(
                        children: [
                          Text(
                            ctl.editedItem?.code?.value ?? "",
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
                                  'Voici le code de la maison : ${item!.code.value}'),
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
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CTextFormField(
                    controller: ctl.numeroAppart,
                    labelText: "Numéro d’appartement",
                    require: true,
                  ),
                  CDropdownField(
                    labelText: "Type d’appartement",
                    asyncItems: (p0) => ctl.fetchTypeAppartements(),
                    itemAsString: (e) => e.libelle.value,
                    selectedItem: ctl.typeAppartement,
                    require: true,
                    onChanged: (value) {
                      ctl.typeAppartement = value;
                      ctl.update();
                    },
                  ),
                  CDropdownField(
                    labelText: "Bloc d’apparts",
                    asyncItems: (e) => ctl.fetchBlockApparts(),
                    itemAsString: (e) => e.libelle.value,
                    selectedItem: ctl.blocAppart,
                    require: true,
                    onChanged: (value) {
                      ctl.blocAppart = value;
                      ctl.update();
                    },
                  ),
                  CTextFormField(
                    controller: ctl.nbPiece,
                    labelText: "Nombre de pièces",
                    keyboardType: TextInputType.datetime,
                    require: true,
                  ),
                  CTextFormField(
                    controller: ctl.loyer,
                    labelText: "Loyer",
                    keyboardType: TextInputType.datetime,
                    require: true,
                  ),
                  CTextFormField(
                    controller: ctl.jourPaiement,
                    labelText: "Jour de paiement",
                    hintText: "Jour du mois limit de paiement",
                    require: true,
                    keyboardType: TextInputType.datetime,
                  ),
                  const SizedBox(height: 20),
                  CButton(
                    height: 50,
                    onPressed: () => ctl.submit(),
                    child: Text((item?.id != null)
                        ? "Modifier cet appart"
                        : "Ajouter cet appart"),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
