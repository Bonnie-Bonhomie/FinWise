
import 'package:fin_wise/core/widgets/app_btn.dart';
import 'package:fin_wise/utils/widgets/custom_snackbar.dart';
import 'package:fin_wise/utils/widgets/form_widget.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:fin_wise/views/view_widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/Routes/routes.dart';
import '../../../core/validator/validator.dart';
import '../../../core/widgets/text_widget.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final formKey = GlobalKey<FormState>();
  final pwdKey = GlobalKey<FormFieldState>();
  final confirmPwdKey = GlobalKey<FormFieldState>();
  final TextEditingController pwdCtrl = TextEditingController();
  final TextEditingController confirmPwdCtrl = TextEditingController();

  final bool pwdObscure = false;
  final bool confirmPwdObscure = false;

  void showPass(obscure){
    setState(() {
      obscure = !obscure;
    });
  }

  Future<void> changePwd() async {
    if (formKey.currentState!.validate()) {
      // await
      Get.offNamed(Routes.successful);
    }else{
      CustomSnackbar.warningSnack('Fill all the required field to continue');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: PageContainer(
          topMargin: 20,
          topPadding: 90,
          topChild: const HeadingText(headingText: "New Password"),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 30),
                  const AppText( text:
                    "Reset Password",
                      textWeigh: FontWeight.bold,
                      textSize: 17,
                  ),
                  const AppText(text:
                    "We will send a you an Otp to your email address. Enter your recovery email address",
                  ),
                  const SizedBox(height: 40),
                  //Email
                  labelText("New Password"),
                  const SizedBox(height: 10.0),
                  FormWidget(
                    valController: pwdCtrl,
                    fieldKey: pwdKey,
                    obscure: pwdObscure,
                    textType: TextInputType.emailAddress,
                    validator: (val) => Validator.validatePassword(val),
                    onChanged: (val) => pwdKey.currentState?.validate(),
                    hintText: "enter password",
                    suffixIcon: IconButton(
                      onPressed: () {
                        showPass(pwdObscure);
                      },
                      icon: pwdObscure
                          ? const Icon(Icons.visibility_outlined)
                          : const Icon(Icons.visibility_off_outlined),
                    ),
                  ),
                  const SizedBox(height: 25,),
                  labelText("Confirm New Password"),
                  const SizedBox(height: 10.0),
                  FormWidget(
                    valController: confirmPwdCtrl,
                    fieldKey: confirmPwdKey,
                    obscure: confirmPwdObscure,
                    validator: (val) => Validator.validateConfirmPassword(firstPassword: pwdCtrl.text.trim(), value: val),
                    onChanged: (val) => confirmPwdKey.currentState?.validate(),
                    hintText: "confirm password",
                    suffixIcon: IconButton(
                      onPressed: () {
                        showPass(confirmPwdObscure);
                      },
                      icon: confirmPwdObscure
                          ? const Icon(Icons.visibility_outlined)
                          : const Icon(Icons.visibility_off_outlined),
                    ),
                  ),

                  const SizedBox(height: 80),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppBtn(onPressed: () {
                       changePwd();
                      }, label: "Change Password"),

                    ],
                  ),
                ],
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
