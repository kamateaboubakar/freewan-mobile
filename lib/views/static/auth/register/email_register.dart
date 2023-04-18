import 'package:flutter/material.dart';
import 'package:wan_mobile/tools/widgets/c_textform_field.dart';
import 'package:wan_mobile/views/controllers/auth/register_page_vctl.dart';

class EmailRegister extends StatelessWidget {
  final RegisterPageVctl ctl;
  const EmailRegister(this.ctl, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: const [
        Text(
          "Enter your email address",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(7, 21, 60, 1),
          ),
        ),
        SizedBox(height: 30),
        CTextFormField(
          hintText: "Enter your email address",
        ),
        SizedBox(height: 133),
      ],
    );
  }
}
