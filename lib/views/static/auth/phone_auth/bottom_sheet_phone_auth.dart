import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/widgets/c_textform_field.dart';
import 'package:wan_mobile/tools/widgets/wrapper_body.dart';
import 'package:wan_mobile/tools/widgets/wrapper_body_listview.dart';
import 'package:wan_mobile/views/controllers/auth/bottom_sheet_phone_auth_vctl.dart';
import 'package:wan_mobile/views/controllers/auth/phone_auth_vctl.dart';

class BottomSheetPhoneAuth extends StatelessWidget {
  final PhoneAuthVctl pCtl;
  const BottomSheetPhoneAuth(this.pCtl, {super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomSheetPhoneAuthVctl>(
        init: BottomSheetPhoneAuthVctl(pCtl),
        builder: (ctl) {
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
                  "Sélectionnez le code du pays",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 14),
                const CTextFormField(
                  fillColor: Color.fromRGBO(247, 250, 255, 1),
                  hintText: "Recherchez votre code pays",
                ),
                (pCtl.selectedPays != null)
                    ? ListTile(
                        leading: (pCtl.selectedPays!.flag != null)
                            ? Image.asset(
                                pCtl.selectedPays!.flag!,
                                width: 30,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.flag),
                              )
                            : null,
                        title: Text(
                          pCtl.selectedPays?.libelle ?? "",
                        ),
                        trailing: const Icon(
                          Icons.check_outlined,
                          color: Color.fromRGBO(0, 159, 249, 1),
                        ),
                        onTap: () {
                          pCtl.selectedPays = null;
                          pCtl.update();
                          Get.back();
                        },
                      )
                    : const SizedBox.shrink(),
                const Divider(
                  thickness: 1,
                  color: Color.fromRGBO(237, 242, 249, 1),
                ),
                Expanded(
                  child: WrapperBodyListView(
                    loading: ctl.loading,
                    onRefresh: () => ctl.fetchPays(force: true),
                    lottieEmptyImage:
                        "assets/lotties/131585-blue-pinging-map-edit-no-australia.json",
                    emptyText: "Aucun pays à afficher",
                    children: pCtl.pays
                        .map(
                          (e) => ListTile(
                            leading: (e.flag != null)
                                ? Image.asset(
                                    e.flag!,
                                    width: 30,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(Icons.flag),
                                  )
                                : null,
                            title: Text(e.libelle),
                            onTap: () {
                              pCtl.selectedPays = e;
                              ctl.update();
                              pCtl.update();
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
        });
  }
}
