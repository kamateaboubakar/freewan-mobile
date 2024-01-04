import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/tools/widgets/button_menu.dart';

class GridMenu extends StatelessWidget {
  final List<ButtonMenu> menus;
  final List<Widget> children;
  final int crossAxisCount;
  final String? title;
  final double height;
  final double width;
  final ScrollController? listController;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double childAspectRatio;
  final Widget trailing;
  const GridMenu({
    this.title,
    required this.menus,
    this.crossAxisCount = 2,
    this.height = 325,
    this.width = 250,
    this.children = const [],
    this.listController,
    this.backgroundColor = Colors.white,
    this.padding = const EdgeInsets.all(10),
    this.mainAxisSpacing = 3,
    this.crossAxisSpacing = 3,
    this.childAspectRatio = 1.0,
    this.trailing = const SizedBox.shrink(),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: (title.value.isEmpty)
                    ? const SizedBox.shrink()
                    : ListTile(
                        title: AutoSizeText(
                          title.value,
                          minFontSize: 10,
                          maxLines: 2,
                          maxFontSize: 22,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ),
              trailing
            ],
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              controller: listController,
              children: [
                Container(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: GridView(
                    padding: padding,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: mainAxisSpacing,
                      crossAxisSpacing: crossAxisSpacing,
                      childAspectRatio: childAspectRatio,
                    ),
                    children: menus,
                  ),
                ),
                Row(children: children),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
