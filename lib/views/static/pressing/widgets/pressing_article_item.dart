import 'package:flutter/material.dart';
import 'package:wan_mobile/models/pressing/pressing_article.dart';
import 'package:wan_mobile/tools/utils/amount_util.dart';

import '../../../../tools/utils/asset_colors.dart';

class PressingArticleItem extends StatelessWidget {
  final PressingArticle item;
  final bool selected;
  final int quantity;
  final Function()? decrease;
  final Function()? increase;

  const PressingArticleItem({
    Key? key,
    required this.item,
    this.selected = false,
    this.quantity = 0,
    this.decrease,
    this.increase,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 8,
          left: 8,
          right: 8,
          bottom: 8,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: selected ? AssetColors.blueButton : AssetColors.lightGrey3,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: InkWell(
                    onTap: () {
                      if (item.price == null) return;
                      if (increase != null) {
                        increase!();
                      }
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Center(
                            child: Image.network(
                              item.imageUrl,
                              width: 50,
                              height: 50,
                              errorBuilder: (context, _, __) {
                                return Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(10)),
                                  width: 50,
                                  height: 50,
                                );
                              },
                            ),
                          ),
                        ),
                        Text(
                          item.name!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xff07153C),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        if (item.price != null && item.price! > 0) ...[
                          const SizedBox(height: 5),
                          Text(
                            item.price.toString().formatAmount,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xff07153C),
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          )
                        ]
                      ],
                    ),
                  ),
                ),
                if (quantity > 0)
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color(0xff00853F),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      child: Center(
                        child: Text(
                          quantity.toString(),
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.white,
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
        if (quantity > 0)
          Positioned(
            top: 0,
            left: 0,
            child: InkWell(
              onTap: () {
                if (decrease != null) decrease!();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color(0xffFB2424),
                ),
                padding: const EdgeInsets.all(8),
                child: const Center(
                  child: Icon(
                    Icons.remove,
                    color: Colors.white,
                    size: 10,
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }
}
