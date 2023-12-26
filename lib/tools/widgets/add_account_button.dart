import 'package:flutter/material.dart';

class AddAccountButton extends StatelessWidget {
  final String title;
  final Function() onTap;

  const AddAccountButton({
    required this.title,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: const Color(0xff0D339F),
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Color(0xff0D339F),
                ),
              ),
            ),
            const Icon(
              Icons.add_circle_outline,
              color: Color(0xff0D339F),
            )
          ],
        ),
      ),
    );
  }
}
