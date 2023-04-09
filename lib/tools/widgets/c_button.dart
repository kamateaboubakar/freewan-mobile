import 'package:flutter/material.dart';
import 'package:wan_mobile/tools/const/const.dart';

class CButton extends StatelessWidget {
  final Widget? child;
  final double? height;
  final double? minWidth;
  final Color? color;
  final double? elevation;
  final Color? textColor;
  final void Function()? onPressed;
  const CButton(
      {this.elevation = 0,
      required this.onPressed,
      this.textColor = Colors.white,
      this.color = Const.primaryColor,
      this.minWidth,
      this.height,
      this.child,
      super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      textColor: textColor,
      elevation: elevation,
      hoverElevation: 0,
      highlightElevation: 0,
      disabledElevation: 0,
      focusElevation: 0,
      color: color,
      height: height,
      minWidth: minWidth,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
