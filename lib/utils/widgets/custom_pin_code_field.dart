import 'package:fin_wise/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustomPinCodeField extends StatelessWidget {
  final TextEditingController pinTextCtrl;
  final Function(String)? onComplete;
  final int len;
  final double size;
  final double textSize;
  final bool readOnly;
  final bool showCursor;
  final bool obscure;

  const CustomPinCodeField({
    super.key,
    required this.pinTextCtrl,
    required this.len,
    this.onComplete,
    this.size = 50,
    this.textSize = 20,
    this.readOnly = false,
    this.showCursor = true,
    this.obscure = false
  });

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      controller: pinTextCtrl,
      keyboardType: TextInputType.number,
      length: len,
      readOnly: readOnly,
      showCursor: showCursor,
      obscureText: obscure,
      textStyle: TextStyle(fontSize: textSize),
      onCompleted: onComplete,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^[0-9]{0,6}'))
      ],
      pinTheme: PinTheme(
        fieldOuterPadding: EdgeInsets.all(1),
        shape: PinCodeFieldShape.circle,
        fieldHeight: size,
        fieldWidth: size,
        activeColor: AppColors.primary,
        selectedColor: AppColors.lightGreen,
        inactiveColor: Colors.grey,
      ),
    );
  }
}
