import 'package:flutter/material.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';

class FormEditionBienImmobilierVctl extends ViewController {
  int selectedItem;

  FormEditionBienImmobilierVctl({this.selectedItem = 0});

  var nomLocalCtl = TextEditingController();
  var lieuCtl = TextEditingController();
  var nomLocataireCtl = TextEditingController();
  var telLocataireCtl = TextEditingController();
  var nbPieceCtl = TextEditingController();
  var loyerCtl = TextEditingController();
  var datePaiementCtl = TextEditingController();
}
