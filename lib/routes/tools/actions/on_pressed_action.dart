import 'package:flutter/material.dart';
import 'package:wan_mobile/routes/tools/abstracts/route_action.dart';

class OnPressedAction extends RouteAction {
  final VoidCallback onPressed;

  const OnPressedAction({required this.onPressed});

  @override
  void handle() => onPressed();
}
