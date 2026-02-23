import 'package:fin_wise/controllers/profileCtrl/main_ctrl.dart';
import 'package:fin_wise/core/widgets/app_btn.dart';
import 'package:fin_wise/core/widgets/custom_app_bar.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/Routes/routes.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/widgets/text_widget.dart';

class ChangePinView extends StatefulWidget {
  const ChangePinView({super.key});

  @override
  State<ChangePinView> createState() => _ChangePinViewState();
}

class _ChangePinViewState extends State<ChangePinView> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> currentKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> newKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> confirmKey = GlobalKey<FormFieldState>();

  final TextEditingController currentCtrl = TextEditingController();
  final TextEditingController newCtrl = TextEditingController();
  final TextEditingController confirmCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageContainer(
        topMargin: 20,
        topChild: CustomAppBar.header('Change Pin', 15, ()
        {Get.find<ProfileMainControl>().back();}),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              labelText('Current Pin'),
              inputField(currentCtrl, 'enter current pin'),
              labelText('New Pin'),
              inputField(newCtrl, 'enter new pin'),
              labelText('Confirm Pin'),
              inputField(confirmCtrl, 'enter pin again'),
              SizedBox(height: 30,),
              AppBtn(onPressed: (){
                Get.toNamed(Routes.successful, arguments: 'Pin has been changed successfully');
              }, label: 'Change Pin')
            ],
          ),
        ),
      ),
    );
  }

  Widget labelText(String title) => AppText(text: title, textWeigh: FontWeight.w500,);

  Widget inputField(TextEditingController ctrl, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30, top: 10),
      child: SizedBox(
        height: 40,
        child: TextFormField(
          controller: ctrl,
          maxLength: 4,
          obscureText: true,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: label,
            fillColor: AppColors.lightGreen,
            filled: true,
            counterText: '',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
