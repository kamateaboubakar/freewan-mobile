import 'package:flutter/widgets.dart';
import 'package:wan_mobile/tools/widgets/toggle_button_widget/toggle_item.dart';

class CToggleButton extends StatelessWidget {
  final int crossAxisCount;
  final List<ToggleItem> items;
  final EdgeInsetsGeometry? padding;
  final double childAspectRatio;
  final Function(int) onItemSelected;
  final double crossAxisSpacing;

  const CToggleButton(
      {required this.crossAxisCount,
      required this.items,
      this.crossAxisSpacing = 0.0,
      this.childAspectRatio = 1.35,
      this.padding,
      required this.onItemSelected,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: crossAxisSpacing,
      shrinkWrap: true,
      childAspectRatio: childAspectRatio,
      padding: padding,
      crossAxisCount: crossAxisCount,
      children: items
          .map(
            (e) => GestureDetector(
              child: e,
              onTap: () {
                final index = items.indexOf(e);
                onItemSelected(index);
              },
            ),
          )
          .toList(),
    );
  }
}
