import 'package:flutter/material.dart';
import 'package:wan_mobile/tools/const/const.dart';

class CButton extends StatelessWidget {
  final Widget? child;
  final double? height;
  final double? minWidth;
  final Color? color;
  final double? elevation;
  final Color? textColor;
  final double borderRadius;
  final ShapeBorder? shape;
  final void Function()? onPressed;
  const CButton(
      {this.elevation = 0,
      this.shape,
      this.borderRadius = 8,
      required this.onPressed,
      this.textColor = Colors.white,
      this.color = const Color.fromRGBO(96, 198, 255, 1),
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
      shape: shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
      onPressed: onPressed,
      child: child,
    );
  }
}
