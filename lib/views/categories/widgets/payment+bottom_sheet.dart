///
/// package name
///
/// License

import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/utils/widgets/widget.dart';
import 'package:fin_wise/utils/Helpers/CustomKeyPad/custom_keyboard.dart';
import 'package:fin_wise/utils/Helpers/CustomKeyPad/keypad_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/controller_exports.dart';

class PaymentBottomSheet {
  final controller = KeyPadController();
  final loader = Get.find<LoaderController>();


  //This make the controller refresh and create a new TextEditingController for the form field
  TextEditingController pinText = TextEditingController();
  final GlobalKey<FormFieldState> pinKey = GlobalKey<FormFieldState>();


  void paymentBottomSheet({required BuildContext context, required Function(String pin) action}) {
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
        return WillPopScope(
          onWillPop: () async {
            bool? shouldPop = await showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(),
            );
            return shouldPop ?? false;
          },
          child: buildBottomSheet(context, action),
        );
        // );
      },
    );
    FocusScope.of(context).unfocus();
  }

  Container buildBottomSheet(BuildContext context, Function(String pin) action) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.directional(
          topEnd: Radius.circular(30),
          topStart: Radius.circular(30),
        ),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const AppText(text: 'Enter your Pin'),
              const Spacer(),
              IconButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  showDialog(
                    context: context,
                    builder: (context) => CustomAlertDialog(),
                  );
                },
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(),
                ),
                icon: const Icon(Icons.dangerous_outlined, size: 25),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 15, 40, 0),
            child: CustomPinCodeField(
              pinTextCtrl: controller.pinText,
              len: 4,
              obscure: true,
              readOnly: true,
              showCursor: false,
              pinKey: pinKey,
              onComplete: (pin){controller.loadPin(pin, action);}
            ),
          ),

          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(backgroundColor: Colors.transparent),
            child: AppText(
              text: 'Forget Pin? Click Here',
              textColor: AppColors.darkGreen,
            ),
          ),
          // SizedBox(height: 15),
          Expanded(child: CustomKeyboard(controller: controller)),
        ],
      ),
    );
  }
}
