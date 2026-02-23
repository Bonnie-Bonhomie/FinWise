import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/core/widgets/app_btn.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:fin_wise/views/view_widgets/text_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../core/Routes/routes.dart';


class VerifyEmail extends StatelessWidget {
  VerifyEmail({super.key});

  final formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> pinKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: PageContainer(
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
                    const Text("Enter Security Pin", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    const SizedBox(height: 20,),
                    PinCodeTextField(
                      appContext: context,
                      length: 6,
                      key: pinKey,
                      keyboardType: TextInputType.number,
                      pinTheme: PinTheme(
                          fieldOuterPadding: EdgeInsets.all(4.0),
                          shape: PinCodeFieldShape.circle,
                          activeColor: AppColors.primary,
                          selectedColor: AppColors.lightGreen,
                          inactiveColor: AppColors.lightGreen
                      ),
                    ),
                    const SizedBox(height: 30,),
                    AppBtn(onPressed: () {
                      Get.toNamed(Routes.reset);
                    }, label: "Accept"),

                    const SizedBox(height: 10),
                    AppBtn(
                      onPressed: () {},
                      label: "Send Again",
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
