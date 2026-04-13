

import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';

class FormWidget extends StatelessWidget {
  const FormWidget({
    this.hintText,
    this.suffixIcon,
    this.label,
    this.obscure,
    this.min,
    this.max,
    this.preferLines = false,
    this.size,
    this.valController,
    this.errorText,
    this.textType,
    this.onChanged,
    this.prefixIcon,
    this.maxLength = 800,
    this.needMax = false,
    this.readOnly,
    required this.fieldKey,
    required this.validator,
    super.key,
  });

  final String? hintText;
  final Widget? suffixIcon;
  final String? label;
  final bool? obscure;
  final int? min;
  final int? max;
  final bool preferLines;
  final double? size;
  final TextEditingController? valController;
  final FormFieldValidator<String> validator;
  final String? errorText;
  final TextInputType? textType;
  final Function(String)? onChanged;
  final Widget? prefixIcon;
  final int maxLength;
  final bool needMax;
  final bool? readOnly;
  final GlobalKey<FormFieldState> fieldKey;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscure ?? false,
      key: fieldKey,
      onChanged: onChanged,
      validator: validator,
      controller: valController,
      maxLength: maxLength,
      readOnly: readOnly ?? false,
      // minLines: min,
      // maxLines: max,
      // keyboardType: TextInputType.multiline, // For address where the input box expands
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(2.0),
        // label: Text(label ?? ''),
        counterText: '',
        filled: true,
          hintText: hintText,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          fillColor: AppColors.lightGreen,

          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none
          ), focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none
      )
      ),
    );
  }
}
