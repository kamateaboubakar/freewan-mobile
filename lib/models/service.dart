import 'package:flutter/material.dart';

class Service {
  String label;
  String icon;
  String? iconSelected;
  Color? colorSelected;

  Service({
    required this.label,
    required this.icon,
    this.iconSelected,
    this.colorSelected,
  }) {
    iconSelected ??= icon;
  }
}
