import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/core/widgets/app_btn.dart';
import 'package:fin_wise/core/widgets/text_widget.dart';
import 'package:fin_wise/utils/widgets/custom_pin_code_field.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:fin_wise/views/view_widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/Routes/routes.dart';


class VerifyEmail extends StatelessWidget {
  VerifyEmail({super.key});

  final formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> pinKey = GlobalKey<FormFieldState>();
  final TextEditingController pinTextCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: PageContainer(
          topPadding: 70,
          topChild: const HeadingText(headingText: "Verify Account"),
          child: SizedBox(
            height: 650,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50,),
                    const AppText(text: 'Enter verification code send to your email', ),
                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: CustomPinCodeField(pinTextCtrl: pinTextCtrl, len: 6, size: 40, textSize: 15, ),
                    ),
                    const SizedBox(height: 30,),
                    AppBtn(onPressed: () {
                      showDialog(context: context, builder: (context){
                        return AlertDialog(
                          backgroundColor: AppColors.bgColor,
                          title: Icon(Icons.verified_outlined, size: 100,),
                          content: AppText(text: 'Your account has been verified successfully', textAlign: TextAlign.center,),
                          actions: [AppBtn(onPressed: (){
                            Get.offNamed(Routes.transPin);
                          }, label: 'Continue')],
                        );
                      });
                    }, label: "Accept"),

                    const SizedBox(height: 40),
                    AppBtn(
                      onPressed: () {},
                      label: "Resend Otp",
                      bgColor: AppColors.lightGreen,
                    ),
                    const SizedBox(height: 80),

                    const SizedBox(height: 20),
                    //Reset the gesture detector
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Text labelText(String label) => Text(
    label,
    style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
  );
}
