import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:wan_mobile/tools/const/const.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';

class Tools {
  Tools._();

  static ProgressDialog progressDialog({
    bool isDismissible = false,
  }) {
    ProgressDialog pr = ProgressDialog(
      Get.context!,
      isDismissible: isDismissible,
      customBody: Container(
        padding: const EdgeInsets.all(10),
        width: 300,
        height: 70,
        child: const ListTile(
          leading: CircularProgressIndicator(),
          title: Text("Veuillez patienter SVP..."),
        ),
      ),
    );

    return pr;
  }

  static Future<bool?> showChoiceMessage({
    String title = Const.appName,
    required String message,
  }) {
    return Get.defaultDialog<bool>(
      title: title,
      barrierDismissible: false,
      contentPadding: const EdgeInsets.all(10),
      titlePadding: const EdgeInsets.only(top: 10),
      titleStyle: const TextStyle(fontWeight: FontWeight.bold),
      confirmTextColor: Colors.white,
      actions: [
        MaterialButton(
          elevation: 0,
          textColor: Const.secondaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          minWidth: 120,
          onPressed: () => Get.back(result: false),
          child: const Text(
            "Non",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        MaterialButton(
          minWidth: 120,
          elevation: 0,
          textColor: Colors.white,
          color: AssetColors.blueButton,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          onPressed: () => Get.back(result: true),
          child: const Text(
            "Oui",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
      content: Container(
        height: 100,
        width: 200,
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Center(child: Text(message, textAlign: TextAlign.center)),
      ),
    );
  }

  static Future<T?> openModal<T>(Widget widget,
          {Color? backgroundColor,
          EdgeInsetsGeometry? contentPadding,
          double? elevation}) =>
      Get.dialog<T>(
        AlertDialog(
          backgroundColor: backgroundColor,
          content: widget,
          contentPadding: contentPadding,
          elevation: elevation,
        ),
      );

  static Future<T?> openBottomSheet<T>(Widget widget) =>
      Get.bottomSheet<T>(widget);

  static Future messageBox({
    required String? message,
    bool barrierDismissible = true,
    List<Widget>? actions,
    Widget? confirm,
    TextStyle? titleStyle,
    void Function()? onConfirm,
    double radius = 10,
    String? title,
  }) =>
      Get.defaultDialog(
        textConfirm: "OK",
        buttonColor: Const.primaryColor,
        confirmTextColor: Colors.white,
        title: title ?? "Message",
        titleStyle: titleStyle,
        confirm: confirm,
        content: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            message ?? "Erreur",
            textAlign: TextAlign.center,
          ),
        ),
        radius: radius,
        actions: actions,
        onConfirm: () {
          Get.back();
          if (onConfirm != null) {
            onConfirm();
          }
        },
        barrierDismissible: barrierDismissible,
      );

  static Future<bool?> showToast({
    String message = "Effectué avec succès",
    Color? color = Colors.green,
    Color titleTextColor = Colors.white,
  }) =>
      Fluttertoast.showToast(
        msg: message,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: titleTextColor,
        fontSize: 16.0,
      );

  static Future<File?> pickImage(
      {ImageSource from = ImageSource.camera, int? imageQuality}) async {
    final picker = ImagePicker();
    final pickedFile =
        await picker.pickImage(source: from, imageQuality: imageQuality);
    return (pickedFile != null) ? File(pickedFile.path) : null;
  }

  static Future<List<File>> pickMultipleImage({int? imageQuality}) async {
    final picker = ImagePicker();
    var images = await picker.pickMultiImage(imageQuality: imageQuality);
    return images.map((e) => File(e.path)).toList();
  }

  static Future<File?> bottomSheetPickImage({int imageQuality = 50}) async {
    return await Tools.showBottomPage<File?>(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      height: 170,
      content: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 10),
        children: [
          ListTile(
            leading: const Icon(IcoFontIcons.camera),
            subtitle: const Text("Prendre une image avec l'appareil photo"),
            title: const Text("Ouvrir l'appareil photo"),
            onTap: () => Tools.pickImage(imageQuality: imageQuality).then(
              (value) => Get.back(result: value),
            ),
          ),
          ListTile(
            leading: const Icon(IcoFontIcons.image),
            subtitle: const Text("Prendre une image dans la galerie"),
            title: const Text("Ouvrir la galérie"),
            onTap: () => Tools.pickImage(
                    from: ImageSource.gallery, imageQuality: imageQuality)
                .then(
              (value) => Get.back(result: value),
            ),
          )
        ],
      ),
    );
  }

  static Future showBottomPage<T>({
    EdgeInsets padding = const EdgeInsets.all(10),
    double? height,
    Widget? content,
  }) =>
      Get.bottomSheet<T>(SizedBox(height: height, child: content),
          backgroundColor: Colors.white);
}
