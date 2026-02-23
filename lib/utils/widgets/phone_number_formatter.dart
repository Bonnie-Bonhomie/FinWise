import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // TODO: implement formatEditUpdate
    //TO REMOVE SPACE
    String digitOnly = newValue.text.replaceAll(' ', '');
    if (digitOnly.length > 11) {
      digitOnly = digitOnly.substring(0, 11);
    }
    String formatted = '';
    if (digitOnly.isNotEmpty) {
      formatted = digitOnly.substring(
        0,
        digitOnly.length >= 3 ? 3 : digitOnly.length,
      );
    }
    if (digitOnly.length > 3) {
      formatted += ' ${digitOnly.substring(3, digitOnly.length >= 7 ? 7 : digitOnly.length)}';
    }
    if (digitOnly.length > 7) {
      formatted += ' ${digitOnly.substring(7)}';
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
