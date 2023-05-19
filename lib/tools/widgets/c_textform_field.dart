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
  final Color? fillColor;
  final bool? enabled;
  final TextInputType? keyboardType;
  final void Function()? onTap;
  final Color? hintColor;

  const CTextFormField(
      {this.controller,
      this.keyboardType,
      this.enabled,
      this.onTap,
      this.fillColor = Colors.white,
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
      this.hintColor,
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
        enabled: enabled,
        cursorHeight: 20,
        onTap: onTap,
        style: const TextStyle(
          fontSize: 15,
        ),
        validator: (value) {
          if (require && value?.isEmpty == true) {
            return "Ce champs est obligatoire";
          }
          return null;
        },
        decoration: InputDecoration(
          counterText: "",
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          suffixIcon: suffixIcon,
          labelText: (require && labelText != null) ? "$labelText*" : labelText,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 15,
            color: hintColor,
          ),
          prefixIcon: prefixIcon,
          fillColor: fillColor,
          filled: true,
          errorBorder: border ??
              OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 0.5,
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
          focusedBorder: border ??
              OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 0.5,
                  color: Color.fromRGBO(181, 196, 216, 1),
                ),
                borderRadius: BorderRadius.circular(5),
              ),
          enabledBorder: border ??
              OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 1,
                  color: Color.fromRGBO(181, 196, 216, 1),
                ),
                borderRadius: BorderRadius.circular(5),
              ),
          border: border ??
              OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 1,
                  color: Color.fromRGBO(181, 196, 216, 1),
                ),
                borderRadius: BorderRadius.circular(5),
              ),
        ),
      ),
    );
  }
}
