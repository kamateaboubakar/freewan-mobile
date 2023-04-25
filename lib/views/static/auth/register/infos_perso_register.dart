import 'package:flutter/material.dart';
import 'package:wan_mobile/tools/widgets/c_textform_field.dart';
import 'package:wan_mobile/views/controllers/auth/register_page_vctl.dart';

class InfosPersoRegister extends StatelessWidget {
  final RegisterPageVctl ctl;
  const InfosPersoRegister(this.ctl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      // key: ctl.emailFormKey,
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
            controller: ctl.emailCtl,
            labelText: "Nom de famille",
          ),
          CTextFormField(
            keyboardType: TextInputType.emailAddress,
            require: true,
            controller: ctl.emailCtl,
            labelText: "Prénoms",
          ),
          CTextFormField(
            keyboardType: TextInputType.emailAddress,
            require: true,
            controller: ctl.emailCtl,
            labelText: "Date de naissance",
            hintText: "JJ/MM/AAAA",
            suffixIcon: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.calendar_month,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
