import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:wan_mobile/tools/const/const.dart';

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
          child:
              const Text("Non", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        MaterialButton(
          minWidth: 120,
          elevation: 0,
          textColor: Colors.white,
          color: Const.secondaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          onPressed: () => Get.back(result: true),
          child:
              const Text("Oui", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
      content: Container(
        height: 100,
        width: 200,
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Text(message, textAlign: TextAlign.center),
      ),
    );
  }

  static Future<T?> openModal<T>(Widget widget,
          {Color? backgroundColor, EdgeInsetsGeometry? contentPadding}) =>
      Get.dialog<T>(
        AlertDialog(
          backgroundColor: backgroundColor,
          content: widget,
          contentPadding: contentPadding,
        ),
      );

  static Future<T?> openBottomSheet<T>(Widget widget) => Get.bottomSheet<T>(
        widget,
      );

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

  static SnackbarController showToast({
    String title = Const.appName,
    String message = "Effectué avec succès",
    Color? color = Colors.green,
    Color bodyTextColor = Colors.black,
    Color titleTextColor = Const.primaryColor,
  }) =>
      Get.snackbar(
        title,
        message,
        maxWidth: 500,
        backgroundColor: Colors.white,
        colorText: Const.primaryColor,
        titleText: Text(
          title,
          style: TextStyle(
            color: titleTextColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        messageText: Text(
          message,
          style: TextStyle(
            color: bodyTextColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
}
