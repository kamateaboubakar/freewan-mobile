import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/widgets/c_textform_field.dart';
import 'package:wan_mobile/views/controllers/auth/phone_auth_vctl.dart';

class BottomSheetPhoneAuth extends StatelessWidget {
  final PhoneAuthVctl ctl;
  const BottomSheetPhoneAuth(this.ctl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 24, right: 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              height: 5,
              width: 50,
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(5),
                  right: Radius.circular(5),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Select country code",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 14),
          const CTextFormField(
            fillColor: Color.fromRGBO(247, 250, 255, 1),
            hintText: "Search for your country code",
          ),
          (ctl.selectedPays != null)
              ? ListTile(
                  leading: (ctl.selectedPays!.flag != null)
                      ? Image.asset(
                          ctl.selectedPays!.flag!,
                          width: 30,
                        )
                      : null,
                  title: Text(
                    ctl.selectedPays?.callingCode ?? "",
                  ),
                  trailing: const Icon(
                    Icons.check_outlined,
                    color: Color.fromRGBO(0, 159, 249, 1),
                  ),
                  onTap: () {
                    ctl.selectedPays = null;
                    ctl.update();
                    Get.back();
                  },
                )
              : const SizedBox.shrink(),
          const Divider(
            thickness: 1,
            color: Color.fromRGBO(237, 242, 249, 1),
          ),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: ctl.pays
                  .map(
                    (e) => ListTile(
                      leading: (e.flag != null)
                          ? Image.asset(
                              e.flag!,
                              width: 30,
                            )
                          : null,
                      title: Text(
                        e.callingCode ?? "",
                      ),
                      onTap: () {
                        ctl.selectedPays = e;
                        ctl.update();
                        Get.back();
                      },
                    ),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
