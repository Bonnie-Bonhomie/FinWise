import 'dart:ui';

import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbar {
  static void showSnackbar({
    String title = 'Error',
    required String message,
    Color backgroundColor = AppColors.declined,
    Color textColor = AppColors.bgColor,
    SnackPosition position = SnackPosition.TOP,
    Duration duration = const Duration(seconds: 3),
    IconData? icon,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: position,
      duration: duration,
      backgroundColor: backgroundColor,
      colorText: textColor,
      icon: icon != null ? Icon(icon, color: textColor) : null,
      // isDismissible: true,
      messageText: AppText(text: message, textColor: textColor),
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }


  static void warningSnack(String message) {
    Get.snackbar(
      'Warning',
      message,
      backgroundColor: AppColors.declined,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  static void successSnack(String message) {
    Get.snackbar(
      'Successful',
      message,
      backgroundColor: AppColors.bgColor,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }
}
