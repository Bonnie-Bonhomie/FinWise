import 'package:data_boot/controllers/controller_exports.dart';
import 'package:data_boot/utils/utils_export.dart';
import 'package:data_boot/utils/widgets/LoadingFiles/loading_wrapper.dart';
import 'package:data_boot/views/view_widgets/view_container.dart';
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
                  const SizedBox(height: 10,),
                  CustomPinCodeField(pinTextCtrl: currentCtrl,
                    len: 4,
                    pinKey: currentKey,
                    onComplete: (pin) {
                      if (pin.length == 4) {
                        setState(() => oldPin = true);
                      }
                    },),

                  const SizedBox(height: 20,),
                  labelText('New Pin'),
                  const SizedBox(height: 10,),
                  CustomPinCodeField(
                      pinTextCtrl: newCtrl, len: 4, pinKey: newKey, onComplete: (pin) {
                    if (pin.length == 4) {
                      setState(() => newPin = true);
                    }
                  },),

                  const SizedBox(height: 20,),
                  labelText('Confirm Pin'),
                  const SizedBox(height: 10,),
                  CustomPinCodeField(
                      pinTextCtrl: confirmCtrl, len: 4, pinKey: confirmKey, onComplete: (pin) {
                    if (pin.length == 4) {
                      setState(() => cfmPin = true);
                    }
                  }),

                  SizedBox(height: 40,),
                  AppBtn(onPressed: () async{
                    if (oldPin && newPin && cfmPin){
                      loader.offLoading(() async {
                        await auth.setPin(
                            oldPin: changeToInt(currentCtrl.text.trim()),
                            newPin: changeToInt(newCtrl.text.trim()),
                            cfmPin: changeToInt(confirmCtrl.text.trim()));

                        // Get.find<ProfileMainControl>().back();
                      });

                    } else {
                      CustomSnackbar.warningSnack(
                          'Fill all the required field to continue');
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
}
