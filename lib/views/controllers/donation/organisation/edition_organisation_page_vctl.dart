import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:module_master/module_master.dart';
import 'package:wan_mobile/api/controllers/don/donation_api_ctl.dart';
import 'package:wan_mobile/models/don/organization.dart';
import 'package:wan_mobile/models/fichier.dart';
import 'package:wan_mobile/tools/types/types.dart';

import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';

class EditionOrganisationPageVctl extends ViewController {
  var nomCtl = TextEditingController();
  var emailCtl = TextEditingController();
  var telCtl = TextEditingController();
  var adresseCtl = TextEditingController();
  var descriptionCtl = TextEditingController();
  var formKey = GlobalKey<FormState>();
  String? image;
  Organization? editedItem;

  EditionOrganisationPageVctl({this.editedItem});

  Future<void> pickImage() async {
    final XFile? img =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) {
      image = img.path;
      update();
    }
  }

  Future<void> submit() async {
    if (formKey.currentState!.validate()) {
      if (image != null) {
        if (editedItem?.id == null) {
          onCreate();
        } else {
          onUpdate();
        }
      } else {
        Tools.messageBox(
            message:
                "Veuillez sélectionner une image pour l'organisation SVP.");
      }
    }
  }

  Future<void> onCreate() async {
    await pr.show();
    var resUpFile = await DonationApiCtl().uploadFile(File(image!));
    await pr.hide();
    if (resUpFile.status) {
      editedItem = initItem(Organization(), image: resUpFile.data!.filename);
      await pr.show();
      var res = await DonationApiCtl().createOrganization(editedItem!);
      await pr.hide();
      if (res.status) {
        Get.back(result: true);
        Tools.showToast(message: "Organisation créée avec succès");
      } else {
        Tools.messageBox(message: res.message);
      }
    } else {
      Tools.messageBox(message: resUpFile.message);
    }
  }

  Future<void> onUpdate() async {
    Fichier img;
    if (image!.contains("http")) {
      img = Fichier(filename: editedItem!.logo, url: editedItem!.logoUrl);
    } else {
      await pr.show();
      var resp = await DonationApiCtl().uploadFile(File(image!));
      await pr.hide();
      if (resp.status) {
        img = resp.data!;
      } else {
        Tools.messageBox(message: resp.message);
        return;
      }
    }
    editedItem = initItem(editedItem!, image: img.filename);
    await pr.show();
    var res = await DonationApiCtl().updateOrganisation(editedItem!);
    await pr.hide();
    if (res.status) {
      Get.back(result: true);
      Tools.showToast(message: "Organisation modifiée avec succès");
    } else {
      Tools.messageBox(message: res.message);
    }
  }

  Organization initItem(Organization item, {String? image}) {
    item.name = nomCtl.text;
    item.email = emailCtl.text;
    item.phoneNumber = telCtl.text;
    item.address = adresseCtl.text;
    item.description = descriptionCtl.text;
    item.logo = image;
    item.customerAccountId = appCtl.user.accountId;
    return item;
  }

  @override
  void onInit() {
    super.onInit();
    if (editedItem != null) {
      nomCtl.text = editedItem!.name.value;
      emailCtl.text = editedItem!.email.value;
      telCtl.text = editedItem!.phoneNumber.value;
      adresseCtl.text = editedItem!.address.value;
      descriptionCtl.text = editedItem!.description.value;
      image = editedItem!.logoUrl;
      appCtl.user.accountId = editedItem!.customerAccountId;
      update();
    }
  }
}
