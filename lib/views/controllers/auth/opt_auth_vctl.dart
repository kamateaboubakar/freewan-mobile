import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';

class OptAuthVctl extends ViewController {
  late ProgressDialog pr;

  OptAuthVctl() : pr = Tools.progressDialog();
}
