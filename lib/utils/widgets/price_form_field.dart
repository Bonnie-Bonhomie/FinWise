
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PriceFormField extends StatelessWidget {

  final TextEditingController numberCtrl;
  final Function(String)? onChanged;
  final VoidCallback? onComplete;
  final Widget hint;
  final bool readOnly;
  final Color color;
  final VoidCallback? onTap;
  final FormFieldValidator<String?>? validator;
  final int? length;
  const PriceFormField({
    super.key, required this.numberCtrl,
    required this.hint,
    this.color = Colors.white,
    this.validator,
    this.onTap,
    this.onComplete,
    this.length = 20,
    this.onChanged, this.readOnly = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: numberCtrl,
      keyboardType: TextInputType.number,
      onTap: onTap,
      autofocus: false,
      readOnly: readOnly,
      maxLength: length,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
      ],
      style: TextStyle(fontWeight: FontWeight.bold),
      onEditingComplete: onComplete,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(

        counterText: '',
        contentPadding: EdgeInsets.all(2.0),
        hint: hint,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
