import 'package:flutter/material.dart';
import 'package:wan_mobile/api/controllers/construction_api_ctl.dart';
import 'package:wan_mobile/models/construction/categorie_materiau_construction.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:lebedoo_assets/views/controllers/abstracts/view_controller.dart';

class ConstructionPageVctl extends ViewController {
  List<CategorieMateriauConstruction> categories = [];
  Future<void> fetchCategorieMateriauConstruction() async {
    var res = await ConstructionApiCtl().getAllCategorieMateriauConstruction();
    if (res.status) {
      categories = res.data!;
      update();
    } else {
      Tools.showToast(message: res.message, color: Colors.red);
    }
  }

  @override
  void onReady() {
    super.onReady();
    fetchCategorieMateriauConstruction();
  }
}
