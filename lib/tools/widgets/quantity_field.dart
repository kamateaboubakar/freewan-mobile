import 'package:flutter/material.dart';
import 'package:module_master/module_master.dart';

class QuantityField extends StatefulWidget {
  final bool isPositive;
  const QuantityField({this.isPositive = false, super.key});

  @override
  State<QuantityField> createState() => _QuantityFieldState();
}

class _QuantityFieldState extends State<QuantityField> {
  int quantity = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: AssetColors.grey300, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () {
              setState(() {
                if (widget.isPositive) {
                  if (quantity > 0) {
                    quantity--;
                  }
                } else {
                  quantity--;
                }
              });
            },
          ),
          const VerticalDivider(
            width: 1,
            color: AssetColors.grey300,
          ),
          SizedBox(
            width: 40,
            child: Text(
              quantity.toString(),
              textAlign: TextAlign.center,
            ),
          ),
          const VerticalDivider(
            width: 1,
            color: AssetColors.grey300,
          ),
          IconButton(
            icon: const Icon(
              Icons.add,
              color: AssetColors.blueButton,
            ),
            onPressed: () {
              setState(() {
                quantity++;
              });
            },
          ),
        ],
      ),
    );
  }
}
