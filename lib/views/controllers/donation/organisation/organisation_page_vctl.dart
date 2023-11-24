import 'package:tools_flutter_project/tools/types/int.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/api/controllers/don/donation_api_ctl.dart';
import 'package:wan_mobile/models/don/organization.dart';

import 'package:lebedoo_assets/views/controllers/abstracts/view_controller.dart';

class OrgnisationPageVctl extends ViewController {
  bool loading = false;
  List<Organization> organisations = [];

  Future<void> fetchOrganisations() async {
    loading = true;
    update();
    var res = await DonationApiCtl()
        .getAllUserOrganization(appCtl.user.id.value.toString());
    loading = false;
    update();
    if (res.status) {
      organisations = res.data!;
      update();
    } else {
      Tools.messageBox(message: res.message);
    }
  }

  @override
  void onReady() {
    super.onReady();
    fetchOrganisations();
  }
}
