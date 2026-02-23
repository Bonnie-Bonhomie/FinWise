

import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/core/widgets/text_widget.dart';
import 'package:fin_wise/utils/Helpers/CustomKeyPad/custom_keyboard.dart';
import 'package:fin_wise/utils/Helpers/CustomKeyPad/keypad_ctrl.dart';
import 'package:fin_wise/utils/widgets/custom_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class PaymentBottomSheet {

   final controller = KeyPadController();
   //This make the controller refresh and create a new TextEditingController for the form field
  final TextEditingController pinText = TextEditingController();


  void paymentBottomSheet(BuildContext context) {
    FocusScope.of(context).unfocus();
    showModalBottomSheet(
      enableDrag: false,
      context: context,
      isDismissible: false,

      builder: (context) {
      // return WillPopScope(onWillPop: () async{
      //   Get.delete<KeyPadController>();
      //   return false;
      // }, child:
      return controller.loading.value ? CircularProgressIndicator(): buildBottomSheet(context);
      // );


      },
    );
    FocusScope.of(context).unfocus();
  }

  Container buildBottomSheet(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadiusGeometry.directional(
            topEnd: Radius.circular(30),
            topStart: Radius.circular(30),
          ),
          color: AppColors.bgColor,
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const AppText(text: 'Enter your Pin'),
                const Spacer(),
                IconButton(onPressed: (){
                  FocusScope.of(context).unfocus();
                  showDialog(context: context, builder: (context) =>CustomAlertDialog());
                },
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.bgColor,
                    shape: RoundedRectangleBorder()
                  ),
                  icon: const Icon(Icons.dangerous_outlined, size: 25,),)
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 15, 40, 0),
              child: PinCodeTextField(
                    appContext: context,
                    controller: controller.pinText,
                    length: 4,
                    readOnly: true,
                    showCursor: false,
                    obscureText: true,
                    textStyle: TextStyle(fontSize: 20),
                    onCompleted: (pin){ controller.loadPin(pin);},
                    pinTheme: PinTheme(
                      fieldOuterPadding: EdgeInsets.all(2.0),
                      shape: PinCodeFieldShape.circle,
                      fieldHeight: 50,
                      fieldWidth: 50,
                      activeColor: AppColors.primary,
                      selectedColor: AppColors.lightGreen,
                      inactiveColor: Colors.grey,

                    ),
                  ),

              ),


            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: Colors.transparent,
              ),
              child: AppText(
                text: 'Forget Pin? Click Here',
                textColor: AppColors.darkGreen,
              ),
            ),
            // SizedBox(height: 15),
            Expanded(
              child: CustomKeyboard(controller: controller,)
            ),
          ],
        ),
      );
  }
}
