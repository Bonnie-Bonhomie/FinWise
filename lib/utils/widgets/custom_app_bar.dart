import 'package:data_boot/core/app_colors.dart';
import 'package:data_boot/utils/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/Routes/routes.dart';

class CustomAppBar {
  static header({
    required String title,
    required double leftRight,
    bool needArrow= true,
    VoidCallback? onPressed,
    VoidCallback? onTap,
    bool notification = true,
    bool notificationPage = false,
  }) {
    return Padding(
      padding: EdgeInsets.fromLTRB(leftRight, 15, leftRight, 5.0),
      child: Row(
        children: [
          needArrow? IconButton(
            onPressed: onPressed,
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
          ): SizedBox(),
          Spacer(),
          AppText(text: title, textWeigh: FontWeight.bold, textSize: 20),
          const Spacer(),
          notification
              ? Stack(
                children: [

                  IconButton(
                      onPressed: () {
                        Get.toNamed(Routes.notify);
                      },
                      icon: Icon(
                        Icons.circle_notifications,
                        size: 35,
                        color: AppColors.bgColor,
                      ),
                    ),
                  Positioned(
                    top: 8,
                      right: 8,
                      child: Icon(Icons.circle, color: Colors.red, size: 13,)),
                ],
              )
              : notificationPage
              ? IconButton(onPressed: onTap, style: IconButton.styleFrom(backgroundColor: AppColors.bgColor, ),icon: Icon(Icons.delete, color: AppColors.primary,))
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
