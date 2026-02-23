
import 'package:fin_wise/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Routes/routes.dart';

class CustomAppBar{

  static header(String title, double leftRight, VoidCallback? onPressed) {
    return Padding(
      padding: EdgeInsets.fromLTRB(leftRight, 15, leftRight, 5.0),
      child: Row(
        children: [
          IconButton(onPressed: onPressed, icon: Icon(Icons.arrow_back), color: Colors.white,),
          Spacer(),
              AppText(text: title,
                textWeigh: FontWeight.bold,
                textSize: 20,),
          const Spacer(),
          IconButton(
              onPressed: () {
                Get.toNamed(Routes.notify);
              },
              icon: const Icon(Icons.circle_notifications_rounded, color: Colors.white, size: 35,)),
        ],
      ),
    );
  }
}