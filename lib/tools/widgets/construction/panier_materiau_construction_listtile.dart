import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wan_mobile/tools/widgets/quantity_field.dart';

class PanierMateriauConstructionListTile extends StatelessWidget {
  const PanierMateriauConstructionListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                height: 72,
                width: 72,
                child: Image.asset(
                  "assets/images/empty-sea-beach-background-PhotoRoom 1.png",
                  fit: BoxFit.contain,
                ),
              ),
              Expanded(
                child: ListTile(
                  contentPadding: const EdgeInsets.only(left: 16),
                  title: const Text("Fer Torsadé"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text("Taille: Fer 8"),
                      Text("Seller: SOTACI"),
                    ],
                  ),
                  trailing: PopupMenuButton(
                    itemBuilder: (context) => [],
                  ),
                ),
              )
            ],
          ),
          const Gap(22),
          Row(
            children: const [
              QuantityField(isPositive: true),
              Expanded(
                child: Text(
                  "15 000 F",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
