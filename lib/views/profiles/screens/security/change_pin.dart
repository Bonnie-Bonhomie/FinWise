import 'package:fin_wise/controllers/controller_exports.dart';
import 'package:fin_wise/core/validator/validator.dart';
import 'package:fin_wise/utils/utils_export.dart';
import 'package:fin_wise/utils/widgets/LoadingFiles/loading_wrapper.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePinView extends StatefulWidget {
  const ChangePinView({super.key});

  @override
  State<ChangePinView> createState() => _ChangePinViewState();
}

class _ChangePinViewState extends State<ChangePinView> {

  final AuthCtrl auth = Get.find<AuthCtrl>();
  final LoaderController loader = Get.find<LoaderController>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> currentKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> newKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> confirmKey = GlobalKey<FormFieldState>();

  final TextEditingController currentCtrl = TextEditingController();
  final TextEditingController newCtrl = TextEditingController();
  final TextEditingController confirmCtrl = TextEditingController();

  bool oldPin = true;
  bool newPin = true;
  bool cfmPin = true;

  int changeToInt(String source) {
    int format = int.parse(source);
    return format;
  }

  void setPin() {
    Focus.of(context).unfocus();
    if (formKey.currentState!.validate()) {
      loader.offLoading(() async {
        await auth.setPin(
            oldPin: changeToInt(currentCtrl.text.trim()),
            newPin: changeToInt(newCtrl.text.trim()),
            cfmPin: changeToInt(confirmCtrl.text.trim()));
      });
    } else {
      CustomSnackbar.warningSnack('Fill all the required field to continue');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoaderWrapper(
        child: PageContainer(
          topMargin: 20,
          topChild: CustomAppBar.header(
              title: 'Change Pin', leftRight: 15, onPressed: () {
            Get.find<ProfileMainControl>().back();
          }),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  labelText('Current Pin'),
                  inputField(
                      currentCtrl, 'enter current pin', currentKey, (val) {
                    if (val == null) return 'Enter your current pin';
                    return null;
                  },obscure:  oldPin,suffix: IconButton(onPressed: (){
                    setState(() {
                     oldPin = !oldPin;
                    });
                  }, icon: oldPin? Icon(Icons.visibility_off_outlined): Icon(Icons.visibility_outlined),)),
                  labelText('New Pin'),
                  inputField(newCtrl, 'enter new pin', newKey, (val) =>
                      Validator.validatePin(val!), obscure: newPin, suffix: IconButton(onPressed: (){
                    setState(() {
                      newPin = !newPin;
                    });
                  }, icon: newPin? Icon(Icons.visibility_off_outlined): Icon(Icons.visibility_outlined),)),
                  labelText('Confirm Pin'),
                  inputField(

                      confirmCtrl, 'enter pin again', confirmKey, (val) =>
                      Validator.validateConfirmPassword(
                          firstPassword: newCtrl.text, value: val),obscure:  cfmPin, suffix: IconButton(onPressed: (){
                    setState(() {
                      cfmPin = !cfmPin;
                    });
                  }, icon: cfmPin? Icon(Icons.visibility_off_outlined): Icon(Icons.visibility_outlined),)),
                  SizedBox(height: 30,),
                  AppBtn(onPressed: () {
                    if (formKey.currentState!.validate()) {
                      loader.offLoading(() async {
                        await auth.setPin(
                            oldPin: changeToInt(currentCtrl.text.trim()),
                            newPin: changeToInt(newCtrl.text.trim()),
                            cfmPin: changeToInt(confirmCtrl.text.trim()));
                      });
                    } else {
                      CustomSnackbar.warningSnack('Fill all the required field to continue');
                    }
                  }, label: 'Change Pin')
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget labelText(String title) =>
      AppText(text: title, textWeigh: FontWeight.w500,);

  Widget inputField(TextEditingController ctrl, String label,
      GlobalKey<FormFieldState> key, FormFieldValidator<String> validator,
      {required bool obscure, required Widget suffix}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30, top: 10),
      child: TextFormField(
        controller: ctrl,
        validator: validator,
        key: key,
        maxLength: 4,
        obscureText: obscure,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            hintText: label,
            counterText: '',
          suffix: suffix
        ),
      ),
    );
  }
}
