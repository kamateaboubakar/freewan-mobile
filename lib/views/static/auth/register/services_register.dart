import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:wan_mobile/models/service.dart';
import 'package:wan_mobile/tools/const/const.dart';
import 'package:wan_mobile/views/controllers/auth/register_page_vctl.dart';

class ServiceRegister extends StatelessWidget {
  final RegisterPageVctl ctl;
  const ServiceRegister(this.ctl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      // key: ctl.passFormKey,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            "Services",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(7, 21, 60, 1),
            ),
          ),
          const Text(
            "Choisissez les services qui vous intéresseraient",
            style: TextStyle(
              fontSize: 13,
              color: Color.fromRGBO(38, 82, 140, 1),
            ),
          ),
          const SizedBox(height: 30),
          Wrap(
            spacing: 10,
            runSpacing: 12,
            children: [
              Service(label: "Restaurant", icon: ""),
              Service(label: "Unités", icon: ""),
              Service(label: "Achat ticket", icon: ""),
              Service(label: "Canal+", icon: ""),
              Service(label: "CIE/SODECI", icon: ""),
              Service(label: "Loyer", icon: ""),
              Service(label: "Fibre", icon: ""),
              Service(label: "Pass Mobile", icon: ""),
              Service(label: "Pont à péage", icon: ""),
            ]
                .map(
                  (e) => ChoiceChip(
                    onSelected: (value) {},
                    selected: ["Restaurant", "Unités"].contains(e.label),
                    backgroundColor: const Color.fromRGBO(237, 242, 249, 1),
                    labelStyle: TextStyle(
                      color: ["Restaurant", "Unités"].contains(e.label)
                          ? Colors.white
                          : const Color.fromRGBO(38, 82, 140, 1),
                    ),
                    avatar: Icon(
                      ["Restaurant", "Unités"].contains(e.label)
                          ? Icons.check
                          : Icons.add,
                      color: ["Restaurant", "Unités"].contains(e.label)
                          ? Colors.white
                          : const Color.fromRGBO(38, 82, 140, 1),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    label: SizedBox(
                      height: 48,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.category,
                            size: 15,
                            color: ["Restaurant", "Unités"].contains(e.label)
                                ? Colors.white
                                : null,
                          ),
                          const SizedBox(width: 5),
                          Text(e.label),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
