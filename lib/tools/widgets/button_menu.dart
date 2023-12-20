import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';

class ButtonMenu extends StatelessWidget {
  final Widget icon;
  final String? title;
  final double? minWidth;
  final double? height;
  final String? categorie;
  final int iconFlex;
  final int titleFlex;
  final BorderSide side;

  final void Function()? onPressed;

  const ButtonMenu({
    this.minWidth,
    this.iconFlex = 2,
    this.titleFlex = 2,
    this.height,
    this.categorie,
    required this.icon,
    this.title,
    this.onPressed,
    this.side = BorderSide.none,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: title.value.replaceAll("\n", " "),
      child: MaterialButton(
        minWidth: minWidth,
        height: height,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: side,
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                flex: iconFlex,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue.shade50,
                    border: Border.all(
                      color: Colors.blue.shade100,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: icon,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Visibility(
                visible: title != null,
                child: Expanded(
                  flex: titleFlex,
                  child: Padding(
                    padding: const EdgeInsets.all(2),
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
            ],
          ),
        ),
      ),
    );
  }
}
