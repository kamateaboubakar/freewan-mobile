import 'package:flutter/material.dart';
import 'package:tools_flutter_project/widgets/c_textform_field.dart';
import 'package:wan_mobile/views/controllers/auth/register_page_vctl.dart';

class InfosPersoRegister extends StatelessWidget {
  final RegisterPageVctl ctl;

  const InfosPersoRegister(this.ctl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: ctl.infoUserFormkey,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            CTextFormField(
              require: true,
              controller: ctl.nomCtl,
              labelText: "Nom de famille",
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.next,
            ),
            CTextFormField(
              require: true,
              controller: ctl.prenomCtl,
              labelText: "Prénoms",
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
            ),
            CTextFormField(
              require: true,
              controller: ctl.dateNaissanceCtl.textController,
              labelText: "Date de naissance",
              hintText: "JJ/MM/AAAA",
              readOnly: true,
              onTap: () async {
                var date = await showDatePicker(
                  context: context,
                  initialDate: DateTime(2006),
                  firstDate: DateTime(1940),
                  lastDate: DateTime(2006),
                );
                if (date != null) {
                  ctl.dateNaissanceCtl.date = date;
                  ctl.update();
                }
              },
              suffixIcon: const Icon(Icons.calendar_month),
            ),
            CTextFormField(
              keyboardType: TextInputType.emailAddress,
              require: true,
              controller: ctl.emailCtl,
              labelText: "Adresse email",
            ),
          ],
        ),
      ),
    );
  }
}
