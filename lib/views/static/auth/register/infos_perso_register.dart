import 'package:flutter/material.dart';
import 'package:module_master/module_master.dart';

import 'package:wan_mobile/views/controllers/auth/register_page_vctl.dart';

class InfosPersoRegister extends StatelessWidget {
  final RegisterPageVctl ctl;

  const InfosPersoRegister(this.ctl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: ctl.infoUserFormkey,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            "Informations Personnelles",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(7, 21, 60, 1),
            ),
          ),
          const SizedBox(height: 30),
          CTextFormField(
              keyboardType: TextInputType.emailAddress,
              require: true,
              controller: ctl.nomCtl,
              labelText: "Nom de famille",
              textCapitalization: TextCapitalization.sentences),
          CTextFormField(
            keyboardType: TextInputType.emailAddress,
            require: true,
            controller: ctl.prenomCtl,
            labelText: "Prénoms",
            textCapitalization: TextCapitalization.words,
          ),
          CTextFormField(
            keyboardType: TextInputType.emailAddress,
            require: true,
            controller: ctl.dateNaissanceCtl.textController,
            labelText: "Date de naissance",
            hintText: "JJ/MM/AAAA",
            readOnly: true,
            onTap: () async {
              var date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1940),
                  lastDate: DateTime(3000));
              if (date != null) {
                ctl.dateNaissanceCtl.date = date;
                ctl.update();
              }
            },
            suffixIcon: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.calendar_month,
              ),
            ),
          ),
          CTextFormField(
            keyboardType: TextInputType.emailAddress,
            require: true,
            controller: ctl.emailCtl,
            hintText: "Enter your email address",
          ),
        ],
      ),
    );
  }
}
