import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wan_mobile/api/controllers/don/donation_api_ctl.dart';
import 'package:wan_mobile/models/don/campagne.dart';
import 'package:wan_mobile/models/don/categorie_campagne.dart';
import 'package:wan_mobile/models/don/organization.dart';
import 'package:wan_mobile/models/fichier.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/tools/widgets/date_time_editing_controller.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';

class EditionDonationVctl extends ViewController {
  List<Organization> organsiations = [];
  var titreCtl = TextEditingController();
  var descriptionCtl = TextEditingController();
  var montantCtl = TextEditingController();
  var dateButoireCtl = DateTimeEditingController();
  var withDateButoire = true;
  var pageCtl = PageController();
  CategorieCampagne? categorieDonation;
  Organization? organization;

  var formKey1 = GlobalKey<FormState>();
  var formKey2 = GlobalKey<FormState>();
  String? image;

  Campagne? editedItem;

  EditionDonationVctl({this.editedItem});

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
      if (editedItem?.id == null) {
        onCreateCampagne();
      } else {
        onUpdateCampagne();
      }
    }
  }

  Future<void> onCreateCampagne() async {
    await pr.show();
    var resUpFile = await DonationApiCtl().uploadFile(File(image!));
    await pr.hide();
    if (resUpFile.status) {
      Campagne camp =
          initialiseItem(Campagne(), image: resUpFile.data!.filename);
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

  Future<void> onUpdateCampagne() async {
    await pr.show();
    editedItem = initialiseItem(editedItem!);

    Fichier resUpFile;
    if (image!.contains("http")) {
      resUpFile =
          Fichier(filename: editedItem!.image, url: editedItem!.imageUrl);
    } else {
      await pr.show();
      var resp = await DonationApiCtl().uploadFile(File(image!));
      await pr.hide();
      if (resp.status) {
        resUpFile = resp.data!;
      } else {
        Tools.messageBox(message: resp.message);
        return;
      }
    }
    await pr.show();
    var res = await DonationApiCtl().updateCampagne(editedItem!);
    await pr.hide();
    if (res.status) {
      Get.back(result: true);
      Tools.showToast(message: "Campagne modifiée avec succès");
    } else {
      Tools.messageBox(message: res.message);
    }
  }

  Campagne initialiseItem(Campagne item, {String? image}) {
    item.amount = montantCtl.text.toDouble();
    item.label = titreCtl.text;
    item.category = categorieDonation;
    item.organization = organization;
    item.description = descriptionCtl.text;
    item.image = image;
    item.deadline = dateButoireCtl.date?.toStringDateOnly();
    return item;
  }

  Future<void> pickImage() async {
    final XFile? img =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) {
      image = img.path;
      update();
    }
  }

  Future<List<Organization>> fetchOrganisations() async {
    var res =
        await DonationApiCtl().getAllUserOrganization(appCtl.user.accountId!);
    if (res.status) {
      return res.data!;
    } else {
      Tools.messageBox(message: res.message);
      return [];
    }
  }

  Future<List<CategorieCampagne>> fetchCategories() async {
    var res = await DonationApiCtl().getAllCategorie();

    if (res.status) {
      return res.data!;
    } else {
      Tools.messageBox(message: res.message);
      return [];
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (editedItem != null) {
      titreCtl.text = editedItem!.label.value;
      descriptionCtl.text = editedItem!.description.value;
      montantCtl.text = editedItem!.amount.value.toInt().toString();
      dateButoireCtl.date = editedItem!.deadline.toDateTime();
      image = editedItem!.imageUrl.value;
      organization = editedItem!.organization;
      categorieDonation = editedItem!.category;
      update();
    }
  }
}
