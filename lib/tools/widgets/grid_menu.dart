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

  const GridMenu({
    this.title,
    required this.menus,
    this.crossAxisCount = 2,
    this.height = 310,
    this.width = 250,
    this.children = const [],
    this.listController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Column(
        children: [
          (title.value.isEmpty)
              ? const SizedBox.shrink()
              : ListTile(
                  title: Text(
                    title.value,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              controller: listController,
              children: [
                Container(
                  width: width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: GridView(
                    padding: const EdgeInsets.all(10),
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                    ),
                    children: menus,
                  ),
                ),
                const Gap(20),
                Row(children: children),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
