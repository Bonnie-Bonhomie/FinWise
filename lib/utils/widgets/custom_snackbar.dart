
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/utils/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbar {
  static void showSnackbar({
    String title = 'Error',
    required String message,
    Color backgroundColor = AppColors.declined,
    Color textColor = AppColors.lightGreen,
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
      colorText: AppColors.lightGreen,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  static void successSnack(String message) {
    Get.snackbar(
      'Successful',
      message,
      colorText: AppColors.primary,
      messageText: Text(message, style: TextStyle(fontSize: 13.0, color: AppColors.darkGreen), overflow: TextOverflow.ellipsis, maxLines: 2,),
      backgroundColor: AppColors.bgColor,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }
}

