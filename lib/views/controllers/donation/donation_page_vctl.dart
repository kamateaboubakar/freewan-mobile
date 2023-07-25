import 'package:wan_mobile/api/controllers/don/donation_api_ctl.dart';
import 'package:wan_mobile/models/don/campagne.dart';
import 'package:wan_mobile/models/don/categorie_campagne.dart';
import 'package:wan_mobile/tools/utils/http_response.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';

class DonationPageVctl extends ViewController {
  List<CategorieCampagne> categories = [];
  List<Campagne> campagnes = [];
  List<Campagne> userCampagnes = [];
  int? selectedCatId;

  bool loadAllCampagne = false;
  bool loadUserCampagne = false;

  Future<void> fetchData() async {
    Future.wait([
      fetchCategories(),
      fetchCampagnes(),
      fetchUserCampagnes(),
    ]);
  }

  Future<void> fetchCampagnes({int? catId}) async {
    loadAllCampagne = true;
    selectedCatId = catId;
    update();

    HttpResponse<List<Campagne>> res;
    if (selectedCatId == null) {
      res = await DonationApiCtl().getAllCampagne();
    } else {
      res = await DonationApiCtl().getAllCampagneByCategorie(selectedCatId!);
    }
    loadAllCampagne = false;
    update();
    if (res.status) {
      campagnes = res.data!;
      update();
    }
  }

  Future<void> fetchUserCampagnes() async {
    loadUserCampagne = true;
    update();
    var res = await DonationApiCtl().getAllUserCampagne(appCtl.user.accountId!);
    loadUserCampagne = false;
    update();
    if (res.status) {
      userCampagnes = res.data!;
      update();
    }
  }

  Future<void> fetchCategories() async {
    var res = await DonationApiCtl().getAllCategorie();

    if (res.status) {
      categories = res.data!;
      categories.add(CategorieCampagne(
        label: "voir tout",
        iconUrl: "assets/images/don/tout.png",
        isAllOption: true,
      ));
      update();
    }
  }

  @override
  void onReady() {
    super.onReady();
    fetchData();
  }
}
