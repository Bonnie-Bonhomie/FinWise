import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/utils/widgets/text_widget.dart';
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
              ? IconButton(
                  onPressed: () {
                    Get.toNamed(Routes.notify);
                  },
                  icon: Icon(
                    Icons.circle_notifications_rounded,
                    color: AppColors.bgColor,
                    size: 35,
                  ),
                )
              : notificationPage
              ? IconButton(onPressed: onTap, icon: Icon(Icons.delete_forever_outlined, color: AppColors.bgColor,))
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
