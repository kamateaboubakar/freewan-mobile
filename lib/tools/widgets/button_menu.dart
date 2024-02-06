import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/routes/tools/abstracts/route_action.dart';
import 'package:wan_mobile/routes/tools/actions/no_action.dart';

class ButtonMenu extends StatelessWidget {
  final Widget icon;
  final String? title;
  final double? minWidth;
  final double? height;
  final String? categorie;
  final int iconFlex;
  final int titleFlex;
  final BorderSide side;
  final Color backgroundColor;
  final Color? iconBackgroundColor;
  final Color? iconBorderColor;
  final ShapeBorder? shape;
  final bool displayName;
  final bool withCircleIcon;
  final RouteAction action;
  final void Function()? onLongPress;

  const ButtonMenu({
    this.minWidth,
    this.iconFlex = 2,
    this.titleFlex = 2,
    this.height,
    this.categorie,
    required this.icon,
    this.title,
    this.action = const NoAction(),
    this.side = BorderSide.none,
    this.backgroundColor = Colors.white,
    this.iconBackgroundColor,
    this.iconBorderColor,
    this.shape,
    this.displayName = true,
    this.withCircleIcon = true,
    this.onLongPress,
    super.key,
  });

  ButtonMenu copyWith({
    Widget? icon,
    String? title,
    double? minWidth,
    double? height,
    String? categorie,
    int? iconFlex,
    int? titleFlex,
    BorderSide? side,
    Color? backgroundColor,
    Color? iconBackgroundColor,
    Color? iconBorderColor,
    ShapeBorder? shape,
    bool? displayName,
    bool? withCircleIcon,
    RouteAction? action,
    void Function()? onLongPress,
  }) {
    return ButtonMenu(
      displayName: displayName ?? this.displayName,
      icon: icon ?? this.icon,
      title: title ?? this.title,
      action: action ?? this.action,
      side: side ?? this.side,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      iconFlex: iconFlex ?? this.iconFlex,
      titleFlex: titleFlex ?? this.titleFlex,
      minWidth: minWidth ?? this.minWidth,
      height: height ?? this.height,
      iconBackgroundColor: iconBackgroundColor ?? this.iconBackgroundColor,
      iconBorderColor: iconBorderColor ?? this.backgroundColor,
      categorie: categorie ?? this.categorie,
      shape: shape ?? this.shape,
      withCircleIcon: withCircleIcon ?? this.withCircleIcon,
      onLongPress: onLongPress ?? this.onLongPress,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: title.value.replaceAll("\n", " "),
      child: MaterialButton(
        color: backgroundColor,
        onLongPress: onLongPress,
        elevation: 0,
        highlightElevation: 0,
        highlightColor: Colors.blue.shade50,
        splashColor: Colors.blue.shade100,
        minWidth: minWidth,
        height: height,
        padding: const EdgeInsets.all(4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: side,
        ),
        onPressed: () => action.handle(),
        child: Column(
          children: [
            Expanded(
              flex: iconFlex,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: (withCircleIcon)
                      ? BoxDecoration(
                          shape: BoxShape.circle,
                          color: iconBackgroundColor ?? Colors.blue.shade50,
                          border: Border.all(
                            color: iconBorderColor ?? Colors.blue.shade100,
                          ),
                        )
                      : null,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: icon,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: title != null && displayName,
              child: Expanded(
                flex: titleFlex,
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Center(
                    child: AutoSizeText(
                      title.value,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      maxFontSize: 16,
                      minFontSize: 9,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
