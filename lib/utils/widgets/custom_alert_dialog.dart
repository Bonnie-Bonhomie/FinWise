import 'package:data_boot/core/Routes/routes.dart';
import 'package:data_boot/core/app_colors.dart';
import 'package:data_boot/utils/widgets/widget.dart';
import 'package:data_boot/views/view_widgets/cancel_button.dart';
import 'package:data_boot/views/view_widgets/shared_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({super.key});


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // backgroundColor: AppColors.bgColor,
      title: Center(child: Text('Do you want to continue your transaction?', textAlign: TextAlign.center, style: TextStyle(fontSize: 17),)),
      actions: [
        AppBtn(onPressed: (){
          Get.back();
        FocusScope.of(context).unfocus();
          }, label: 'Continue payment', textSize: 14,),
          const SizedBox(height: 10,),
         SizedBox(
           width: MediaQuery.of(context).size.width,
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
void showCustomDiag(BuildContext context){
  // print('Iam called');
  showDialog(context: context, builder: (context){
    return AlertDialog(
      title: Icon(Icons.verified_outlined, size: 100, color: AppColors.primary,),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText(text: 'Your account has been verified successfully', textAlign: TextAlign.center,),
          AppText(text: 'Press continue to set pin', textAlign: TextAlign.center,),
        ],
      ),
      actions: [AppBtn(onPressed: (){
        Get.offNamed(Routes.transPin);
      }, label: 'Continue')],
    );
  });
}


void logoutDialog(BuildContext context, VoidCallback action){
  showDialog(context: context, builder: (context){
    return AlertDialog(
      title: const HeadingText(headingText: 'End Session',),
      content: const Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: AppText(text: 'Are you sure you want to log out?', textAlign: TextAlign.center,),
      ),

      actions: [
        AppBtn(onPressed: (){
          Get.back();
          action();
        }, label: 'End Session', textSize: 15, isDel: true,),
        SizedBox(height: 10,),
        SizedBox(
            width: MediaQuery.of(context).size.width,
            child: CancelBtn(onPressed: (){Get.back();})
        ),
      ],
    );
  });
}
