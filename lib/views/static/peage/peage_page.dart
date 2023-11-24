import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:tools_flutter_project/widgets/wrapper_body_listview.dart';
import 'package:wan_mobile/views/controllers/peage/peage_page_vctl.dart';
import 'package:wan_mobile/views/static/peage/reference_client_form.dart';

class PeagePage extends StatelessWidget {
  const PeagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PeagePageVctl>(
        init: PeagePageVctl(),
        builder: (ctl) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Abonnement péage"),
            ),
            body: WrapperBodyListView(
              loading: false,
              onRefresh: ctl.getFournisseurs,
              children: ctl.fournisseurs
                  .map(
                    (e) => ListTile(
                      leading: CircleAvatar(
                        child: Image.asset(
                          "assets/images/icons/abonnement_payage.png",
                          width: 25,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(e.libelle.value),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                      ),
                      onTap: () => Get.to(() => const ReferenceClientForm()),
                    ),
                  )
                  .toList(),
            ),
          );
        });
  }
}
