import 'package:flutter/material.dart';

class CTextFormField extends StatelessWidget {
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final InputBorder? border;
  final TextEditingController? controller;
  final bool require;
  final String? hintText;
  final EdgeInsetsGeometry? margin;
  final void Function(String)? onChanged;
  final int? maxLines;
  final bool readOnly;
  final String? initialValue;
  final int? maxLength;
  final bool obscureText;
  final TextInputType? keyboardType;

  const CTextFormField(
      {this.controller,
      this.keyboardType,
      this.initialValue,
      this.obscureText = false,
      this.readOnly = false,
      this.maxLength,
      this.maxLines = 1,
      this.onChanged,
      this.margin = const EdgeInsets.only(bottom: 10),
      this.border,
      this.require = false,
      this.prefixIcon,
      this.suffixIcon,
      this.labelText,
      this.hintText,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: TextFormField(
        initialValue: initialValue,
        readOnly: readOnly,
        maxLines: maxLines,
        obscureText: obscureText,
        maxLength: maxLength,
        onChanged: onChanged,
        keyboardType: keyboardType,
        controller: controller,
        cursorHeight: 27,
        style: const TextStyle(
          fontSize: 20,
        ),
        validator: (value) {
          if (require && value?.isEmpty == true) {
            return "Ce champs est obligatoire";
          }
          return null;
        },
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          suffixIcon: suffixIcon,
          labelText: (require && labelText != null) ? "$labelText*" : labelText,
          hintText: hintText,
          prefixIcon: prefixIcon,
          filled: true,
          border: border ??
              OutlineInputBorder(
                borderSide: const BorderSide(width: 0.5),
                borderRadius: BorderRadius.circular(5),
              ),
        ),
      ),
    );
  }
}
