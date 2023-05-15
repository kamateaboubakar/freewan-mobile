import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/widgets/c_button.dart';
import 'package:wan_mobile/tools/widgets/c_dropdown_field.dart';
import 'package:wan_mobile/tools/widgets/c_textform_field.dart';

class FormEditionAppartement extends StatelessWidget {
  const FormEditionAppartement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajouter un appartement"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          CTextFormField(
            labelText: "Numéro d’appartement",
          ),
          CDropdownField(
            labelText: "Type d’appartement",
          ),
          CDropdownField(
            labelText: "Bloc d’apparts",
          ),
          CTextFormField(
            labelText: "Loyer",
          ),
          CTextFormField(
            labelText: "Date de paiement",
            suffixIcon: const Icon(Icons.calendar_month),
            onTap: () async {
              var date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2023),
                  lastDate: DateTime(3000));
            },
          ),
          CTextFormField(
            labelText: "Nom du Locataire",
          ),
          CTextFormField(
            labelText: "Numéro du Locataire",
          ),
          const SizedBox(height: 20),
          CButton(
            height: 50,
            onPressed: () => Get.back(),
            child: const Text("Ajouter cet appart"),
          ),
        ],
      ),
    );
  }
}
