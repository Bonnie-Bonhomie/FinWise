import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/core/widgets/app_btn.dart';
import 'package:fin_wise/core/widgets/text_widget.dart';
import 'package:fin_wise/views/view_widgets/cancel_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({super.key});


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.bgColor,
      title: Center(child: AppText(text: 'Do you want to continue your transaction?', textAlign: TextAlign.center, textSize: 17,)),
      actions: [
        AppBtn(onPressed: (){
          Get.back();
        FocusScope.of(context).unfocus();
          }, label: 'Continue payment', textSize: 14,),
          const SizedBox(height: 10,),
         SizedBox(
           width: 250,
           child: CancelBtn(onPressed: (){
              // FocusScope.of(context).unfocus();
              Get.back();
              Get.back();
              FocusScope.of(context).unfocus();
            }),
         ),

      ],
    );
  }
}
