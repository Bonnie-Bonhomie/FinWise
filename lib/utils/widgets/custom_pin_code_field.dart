import 'package:data_boot/core/app_colors.dart';
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
  final GlobalKey<FormFieldState> pinKey;
  final FormFieldValidator? validator;
  final bool autoFocus;

  const CustomPinCodeField({
    super.key,
    required this.pinTextCtrl,
    required this.len,
    required this.pinKey,
    this.onComplete,
    this.size = 50,
    this.textSize = 20,
    this.readOnly = false,
    this.showCursor = true,
    this.obscure = false,
    this.autoFocus = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      key: pinKey,
      controller: pinTextCtrl,
      keyboardType: TextInputType.number,
      // enableActiveFill: true,

      length: len,
      readOnly: readOnly,
      showCursor: showCursor,
      obscureText: obscure,
      textStyle: TextStyle(fontSize: textSize),
      onCompleted: onComplete,
      validator: validator,
      autoFocus: autoFocus,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^[0-9]{0,6}'))
      ],

      pinTheme: PinTheme(

        // fieldOuterPadding: EdgeInsets.all(5),
        //     activeBorderWidth: 10,
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(8),
        fieldHeight: 55,
        fieldWidth: size,
        activeColor: AppColors.primary,
        selectedColor: AppColors.lightGreen,
        inactiveColor: Colors.grey,
        activeFillColor: Colors.yellow,

        borderWidth: 3,
        activeBorderWidth: 2,
        // inactiveBorderWidth: 2
      ),
    );
  }
}
