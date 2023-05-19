import 'package:flutter/material.dart';

class AddAccountButton extends StatelessWidget {
  final String title;
  final Function() onTap;

  const AddAccountButton({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Color(0xff0D339F),
          ),
        ),
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: Color(0xff0D339F),
                ),
              ),
            ),
            Icon(
              Icons.add_circle_outline,
              color: Color(0xff0D339F),
            )
          ],
        ),
      ),
    );
  }
}
