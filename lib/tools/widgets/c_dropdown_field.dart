import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class CDropdownField<T> extends StatelessWidget {
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final InputBorder? border;
  final TextEditingController? controller;
  final bool require;
  final String? hintText;
  final EdgeInsetsGeometry? margin;
  final void Function(T?)? onChanged;
  final int? maxLines;
  final List<T> items;
  final T? selectedItem;
  final bool enabled;
  final String Function(T)? itemAsString;
  const CDropdownField(
      {this.controller,
      this.selectedItem,
      this.enabled = true,
      this.itemAsString,
      this.items = const [],
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
      child: DropdownSearch<T>(
        onChanged: onChanged,
        enabled: enabled,
        items: items,
        itemAsString: itemAsString,
        selectedItem: selectedItem,
        validator: (value) {
          if (require && value == null) {
            return "Ce champs est obligatoire";
          }
          return null;
        },
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            suffixIcon: suffixIcon,
            labelText:
                (require && labelText != null) ? "$labelText*" : labelText,
            hintText: (require && hintText != null) ? "$hintText" : hintText,
            prefixIcon: prefixIcon,
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
      ),
    );
  }
}
