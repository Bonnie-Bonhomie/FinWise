import 'package:fin_wise/controllers/controller_exports.dart';

import 'package:fin_wise/core/validator/validator.dart';
import 'package:fin_wise/utils/utils_export.dart';
import 'package:fin_wise/utils/widgets/LoadingFiles/loading_wrapper.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final ChangePwdControl ctrl = Get.find<ChangePwdControl>();
  final loader = Get.find<LoaderController>();

  final formKey = GlobalKey<FormState>();
  final currentPwd = GlobalKey<FormFieldState>();
  final pwdKey = GlobalKey<FormFieldState>();
  final confirmPwdKey = GlobalKey<FormFieldState>();
  final TextEditingController currentPwdCtrl = TextEditingController();
  final TextEditingController pwdCtrl = TextEditingController();
  final TextEditingController confirmPwdCtrl = TextEditingController();

  bool currentObscure = true;
   bool pwdObscure = true;
   bool confirmPwdObscure = true;

  void showPass() {
    setState(() {
      pwdObscure = !pwdObscure;
    });
  }
  void showCurr() {
    setState(() {
      currentObscure = !currentObscure;
    });
  }
  void showConfirm() {
    setState(() {
      confirmPwdObscure = !confirmPwdObscure;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: LoaderWrapper(
        child: PageContainer(
          topMargin: 20,
          bottomPadding: 0,
          topChild: CustomAppBar.header(
            title: 'Password Settings',
            leftRight: 15,
             onPressed: () => Get.find<ProfileMainControl>().back(),
          ),
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
              child: ListView(
                children: [
                  const SizedBox(height: 30),
                  //Email
                  const AppText(text: "Current Password"),
                  const SizedBox(height: 10.0),
                  FormWidget(
                      valController: currentPwdCtrl,
                      fieldKey: currentPwd,
                      obscure: currentObscure,
                      validator: (val) => Validator.validatePassword(val),
                      onChanged: (val) => currentPwd.currentState?.validate(),
                      hintText: "Enter current password",
                      suffixIcon: IconButton(
                        onPressed: () {
                          showCurr();
                        },
                        icon: currentObscure
                            ? const Icon(Icons.visibility_off_outlined)
                            : const Icon(Icons.visibility_outlined),
                      ),
                    ),

                  const SizedBox(height: 25,),
                  const AppText(text: "New Password"),
                  const SizedBox(height: 10.0),
                  FormWidget(
                    valController: pwdCtrl,
                    fieldKey: pwdKey,
                    obscure: pwdObscure,
                    textType: TextInputType.emailAddress,
                    validator: (val) => Validator.validatePassword(val),
                    onChanged: (val) => pwdKey.currentState?.validate(),
                    hintText: "Enter Password",
                    suffixIcon: IconButton(
                      onPressed: () =>showPass(),
                      icon: pwdObscure
                          ? const Icon(Icons.visibility_off_outlined)
                          : const Icon(Icons.visibility_outlined),
                    ),
                  ),
                  const SizedBox(height: 25,),
                  const AppText(text: "Confirm New Password"),
                  const SizedBox(height: 10.0),
                  FormWidget(
                    valController: confirmPwdCtrl,
                    fieldKey: confirmPwdKey,
                    obscure: confirmPwdObscure,
                    validator: (val) =>
                        Validator.validateConfirmPassword(
                            firstPassword: pwdCtrl.text.trim(), value: val),
                    onChanged: (val) => confirmPwdKey.currentState?.validate(),
                    hintText: "Confirm New Password",
                    suffixIcon: IconButton(
                      onPressed: ()  => showConfirm(),
                      icon: confirmPwdObscure
                          ? const Icon(Icons.visibility_off_outlined)
                          : const Icon(Icons.visibility_outlined),
                    ),
                  ),

                  const SizedBox(height: 80),
                  AppBtn(onPressed: () {
                    if(formKey.currentState!.validate()){
                      loader.offLoading(() async{
                        await ctrl.changePwd(currentPwd: currentPwdCtrl.text, newPwd: pwdCtrl.text, confirmPwd: confirmPwdCtrl.text);
                      });
                    }else{
                      CustomSnackbar.showSnackbar(message: 'Enter password to continue');
                    }
                  }, label: "Change Password"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


}
