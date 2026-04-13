
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PriceFormField extends StatelessWidget {

  final TextEditingController numberCtrl;
  final Function(String)? onChanged;
  final Widget hint;
  final bool readOnly;
  final Color color;
  final VoidCallback? onTap;
  final FormFieldValidator<String?>? validator;
  const PriceFormField({super.key, required this.numberCtrl,
    required this.hint,
    this.color = Colors.white,
    this.validator,
    this.onTap,
    this.onChanged, this.readOnly = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: numberCtrl,
      keyboardType: TextInputType.number,
      onTap: onTap,
      autofocus: false,
      readOnly: readOnly,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
      ],
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(2.0),
        filled: true,
        fillColor: color,
        hint: hint,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
