import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';

class SingleChildCardMenu extends StatelessWidget {
  final Widget icon;
  final String? title;
  final String? subtitle;
  final EdgeInsetsGeometry? margin;
  final void Function()? onTap;
  const SingleChildCardMenu(
      {this.margin = const EdgeInsets.only(bottom: 5),
      required this.icon,
      this.onTap,
      required this.title,
      this.subtitle,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: const EdgeInsets.only(left: 10, right: 10),
      color: AssetColors.blue,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return MaterialButton(
            elevation: 0,
            highlightElevation: 0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
              side: const BorderSide(
                width: .5,
                color: Color.fromRGBO(218, 218, 218, 1),
              ),
            ),
            height: constraints.minHeight,
            minWidth: constraints.minWidth,
            padding: const EdgeInsets.all(9),
            onPressed: onTap,
            child: Row(
              children: [
                icon,
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        title.value,
                        maxLines: 1,
                        maxFontSize: 12,
                        minFontSize: 10,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Visibility(
                        visible: subtitle.value.isNotEmpty,
                        child: AutoSizeText(
                          subtitle.value,
                          maxLines: 1,
                          maxFontSize: 9,
                          minFontSize: 8,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
