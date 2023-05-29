import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wan_mobile/api/controllers/don/donation_api_ctl.dart';
import 'package:wan_mobile/models/don/campagne.dart';
import 'package:wan_mobile/models/don/categorie_donation.dart';
import 'package:wan_mobile/models/don/organization.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/tools/widgets/date_time_editing_controller.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';
import 'package:wan_mobile/views/controllers/app_ctl.dart';

class EditionDonationVctl extends ViewController {
  List<Organization> organsiations = [];
  var titreCtl = TextEditingController();
  var descriptionCtl = TextEditingController();
  var montantCtl = TextEditingController();
  var dateButoireCtl = DateTimeEditingController();
  var withDateButoire = true;
  var pageCtl = PageController();
  CategorieDonation? categorieDonation;
  Organization? organization;
  List<CategorieDonation> categories;
  var formKey1 = GlobalKey<FormState>();
  var formKey2 = GlobalKey<FormState>();
  File? image;

  EditionDonationVctl(this.categories);

  void validateForm1() {
    if (formKey1.currentState!.validate()) {
      if (image != null) {
        pageCtl.jumpToPage(1);
      } else {
        Tools.messageBox(
            message: "Veuillez sélectionner une image pour la campagne SVP.");
      }
    }
  }

  void submit() async {
    if (formKey2.currentState!.validate()) {
      await pr.show();
      var resUpFile = await DonationApiCtl().uploadFile(image!);
      await pr.hide();
      if (resUpFile.status) {
        Campagne camp = Campagne();
        camp.amount = montantCtl.text.toDouble();
        camp.label = titreCtl.text;
        camp.category = categorieDonation;
        camp.organization = organization;
        camp.description = descriptionCtl.text;
        camp.image = resUpFile.data!.filename;

        camp.deadline = dateButoireCtl.date?.toStringDateOnly();
        await pr.show();
        var res = await DonationApiCtl().createCampagne(camp);
        await pr.hide();
        if (res.status) {
          Get.back(result: true);
          Tools.showToast(message: "Campagne créée avec succès");
        } else {
          Tools.messageBox(message: res.message);
        }
      } else {
        Tools.messageBox(message: resUpFile.message);
      }
    }
  }

  Future<void> pickImage() async {
    final XFile? img =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) {
      image = File(img.path);
      update();
    }
  }

  Future<List<Organization>> fetchOrganisations() async {
    var res = await DonationApiCtl().getAllOrganization();
    if (res.status) {
      return res.data!;
    } else {
      Tools.messageBox(message: res.message);
      return [];
    }
  }
}
