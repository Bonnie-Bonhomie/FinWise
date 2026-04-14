import 'package:fin_wise/controllers/AuthControllers/auth_ctrl.dart';
import 'package:fin_wise/controllers/loader_contrl.dart';
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/core/widgets/app_btn.dart';
import 'package:fin_wise/utils/widgets/LoadingFiles/loading_wrapper.dart';
import 'package:fin_wise/utils/widgets/custom_snackbar.dart';
import 'package:fin_wise/utils/widgets/datePicker.dart';
import 'package:fin_wise/utils/widgets/form_widget.dart';
import 'package:fin_wise/utils/widgets/phone_number_form.dart';
import 'package:fin_wise/views/view_widgets/text_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/Routes/routes.dart';
import '../../../core/validator/validator.dart';
import '../../../core/widgets/text_widget.dart';


class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final formKey = GlobalKey<FormState>();
  final nameKey = GlobalKey<FormFieldState>();
  final numberKey = GlobalKey<FormFieldState>();
  final mailKey = GlobalKey<FormFieldState>();
  final pwdKey = GlobalKey<FormFieldState>();
  final confirmPwdKey = GlobalKey<FormFieldState>();
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController numberCtrl = TextEditingController();
  final TextEditingController mailCtrl = TextEditingController();
  final TextEditingController pwdCtrl = TextEditingController();
  final TextEditingController confirmPwdCtrl = TextEditingController();
  final TextEditingController dobCtrl = TextEditingController();
  final AuthCtrl authCtrl = Get.find<AuthCtrl>();
  final loader = Get.find<LoaderController>();

  bool pwdObscure = true;
  bool confirmPwdObscure = true;

  @override
  void dispose() {
    mailCtrl.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void showPass() {
    setState(() {
      pwdObscure = !pwdObscure;
    });
  }

  void showCfmPass() {
    setState(() {
      confirmPwdObscure = !confirmPwdObscure;
    });
  }

  Future<void> _register() async {

      await authCtrl.registerUser(
        name: nameCtrl.text.trim(),
        mail: mailCtrl.text.trim(),
        dob: dobCtrl.text.trim(),
        phone: numberCtrl.text.trim(),
        password: pwdCtrl.text.trim(),
        confirmPassword: confirmPwdCtrl.text.trim(),
      );
      print('done');


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: LoaderWrapper(
        child: ListView(
          children: [
            Padding(padding: const EdgeInsets.fromLTRB(25, 40, 25, 0), child: Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: HeadingText(headingText: 'Create Account'),
            ),),
            Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(60),),
                color: AppColors.bgColor
              ),
              child: formSection(),
            )
          ],
        ),
      ),
    );
  }

  Form formSection() {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // const SizedBox(height: 20),
          labelText("Full Name"),
          const SizedBox(height: 5.0),
          FormWidget(
            valController: nameCtrl,
            fieldKey: nameKey,
            validator: (val) => Validator.validateText(val, 'Full Name'),
            onChanged: (val) => nameKey.currentState?.validate(),
            hintText: "john due",
          ),
          const SizedBox(height: 15),
          labelText("Email"),
          const SizedBox(height: 8.0),
          FormWidget(
            // label: '',
            valController: mailCtrl,
            fieldKey: mailKey,
            textType: TextInputType.emailAddress,
            validator: (val) => Validator.validateEmail(val!.trim()),
            onChanged: (val) => mailKey.currentState?.validate(),
            hintText: "johndue@example.com",
          ),
          const SizedBox(height: 15),
          labelText("Mobile Number"),
          const SizedBox(height: 8.0),
          PhoneNumberFormField(
            numberCtrl: numberCtrl,
            numberKey: numberKey,
            validator: (value) => Validator.validateNumber(value!),
            onChanged: (val) => numberKey.currentState!.validate(),
          ),
          const SizedBox(height: 15),
          labelText("Date of Birth"),
          const SizedBox(height: 8.0),
          DatePicker(dateControl: dobCtrl),
          const SizedBox(height: 15.0),
          labelText("Password"),
          const SizedBox(height: 8.0),
          FormWidget(
            valController: pwdCtrl,
            fieldKey: pwdKey,
            obscure: pwdObscure,
            validator: (val) => Validator.validatePassword(val),
            onChanged: (val) => pwdKey.currentState?.validate(),
            hintText: "Password",
            suffixIcon: IconButton(
              onPressed: () {
                showPass();
              },
              icon: pwdObscure
                  ? const Icon(Icons.visibility_off_outlined)
                  : const Icon(Icons.visibility_outlined),
            ),
          ),
          const SizedBox(height: 15),
          labelText("Confirm Password"),
          const SizedBox(height: 8.0),
          FormWidget(
            valController: confirmPwdCtrl,
            fieldKey: confirmPwdKey,
            obscure: confirmPwdObscure,
            onChanged: (val) => confirmPwdKey.currentState?.validate(),
            validator: (val) => Validator.validateConfirmPassword(
              firstPassword: pwdCtrl.text,
              value: val,
            ),
            hintText: "confirm password",
            suffixIcon: IconButton(
              onPressed: () {
                showCfmPass();
              },
              icon: confirmPwdObscure
                  ? const Icon(Icons.visibility_off_outlined)
                  : const Icon(Icons.visibility_outlined),
            ),
          ),
          const SizedBox(height: 20.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const AppText(text: "By continuing, you agree to"),
              InkWell(onTap: (){
                Get.toNamed(Routes.terms);
              },
                child: const AppText(
                text: "Terms of Use and Privacy Policy.",
                textWeigh: FontWeight.bold,textColor: AppColors.darkGreen,
              ),),
              const SizedBox(height: 20,),
              AppBtn(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                  loader.offLoading(()=>  _register());
                  }
                  else{
                    CustomSnackbar.warningSnack('Fill all the required field to continue');
                  }
                },
                label: 'Sign Up',
                loading: authCtrl.loading.value,
                loadWidget: CircularProgressIndicator(),
              ),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  text: "Already have an account? ",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                  children: [
                    TextSpan(
                      text: 'Log in',
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.offNamed(Routes.login);
                        },
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 15,)
            ],
          ),
        ],
      ),
    );
  }

  Text labelText(String label) => Text(
    label,
    style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
  );
}
