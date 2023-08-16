import 'package:flutter/material.dart';

import 'package:module_master/module_master.dart';
import 'package:module_master/module_master.dart';

import 'package:wan_mobile/views/controllers/donation/edition_donation_page_vctl.dart';

class BesoinFinanceCampagnePage extends StatelessWidget {
  final EditionDonationVctl ctl;
  const BesoinFinanceCampagnePage(this.ctl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: CButton(
                height: 50,
                onPressed: () => ctl.pageCtl.jumpToPage(0),
                child: const Text("Précédent"),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: CButton(
                height: 50,
                onPressed: ctl.submit,
                child: Text((ctl.editedItem?.id != null)
                    ? "Modifier ma campagne"
                    : "Créer ma campagne"),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: ctl.formKey2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ListTile(
                title: Text(
                  "Besoins en financement",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AssetColors.blue,
                  ),
                ),
                trailing: Text("2/2"),
              ),
              const SizedBox(height: 20),
              const Text(
                "Ces informations permettront aux donateurs"
                " de mieux comprendre votre campagne",
                style: TextStyle(
                  fontSize: 13,
                  color: AssetColors.blue,
                ),
              ),
              const SizedBox(height: 20),
              CTextFormField(
                controller: ctl.montantCtl,
                labelText: "Montant demandé",
                require: true,
                keyboardType: TextInputType.number,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AssetColors.grey7,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    SwitchListTile(
                        title: const Text("Délai"),
                        value: ctl.withDateButoire,
                        onChanged: (value) {
                          ctl.withDateButoire = value;
                          ctl.dateButoireCtl.date = null;
                          ctl.update();
                        }),
                    const SizedBox(height: 20),
                    Visibility(
                      visible: ctl.withDateButoire,
                      child: CTextFormField(
                        controller: ctl.dateButoireCtl.textController,
                        suffixIcon: const Icon(Icons.calendar_month),
                        labelText: "Date butoire",
                        require: true,
                        readOnly: true,
                        onTap: () async {
                          var date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(3000));
                          if (date != null) {
                            ctl.dateButoireCtl.date = date;
                            ctl.update();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
