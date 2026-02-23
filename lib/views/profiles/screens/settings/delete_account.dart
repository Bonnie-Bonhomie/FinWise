
import 'package:fin_wise/controllers/profileCtrl/main_ctrl.dart';
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/core/widgets/app_btn.dart';
import 'package:fin_wise/core/widgets/custom_app_bar.dart';
import 'package:fin_wise/core/widgets/text_widget.dart';
import 'package:fin_wise/views/view_widgets/cancel_button.dart';
import 'package:fin_wise/views/view_widgets/text_widget.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageContainer(
        topMargin: 20,
        topChild: CustomAppBar.header(
          'Delete Account',
          15,
          () => Get.find<ProfileMainControl>().back(),
        ),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
          children: [
            const AppText(
              text: 'Are you sure you want to delete your account',
              textAlign: TextAlign.center,
              textWeigh: FontWeight.bold,
              textSize: 20,
            ),
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: AppColors.lightGreen,
                borderRadius: BorderRadius.circular(15),
              ),
              child: AppText(text: content, textAlign: TextAlign.start),
            ),
            const AppText(
              text:
                  'Please enter your password to continue deletion of your account',
              textAlign: TextAlign.center,
              textWeigh: FontWeight.bold,
              textSize: 20,
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 40,
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter password',
                  fillColor: AppColors.lightGreen,
                  filled: true,
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.visibility_outlined),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            AppBtn(
              onPressed: () {
                showDelDialog(context);
              },
              label: 'Yes, Delete Account',
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                Get.find<ProfileMainControl>().back();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.lightGreen,
              ),
              child: const AppText(
                text: 'Cancel',
                textColor: AppColors.darkGreen,
                textSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showDelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.bgColor,
          title: const HeadingText(headingText: 'Delete Account'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const AppText(
                text: 'Are you sure you want to delete account?',
                textWeigh: FontWeight.bold,
                textSize: 18,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const AppText(
                text:
                    'By deleting your account, you agree that you understand the consequence of this action and that you agree to permanently delete your account and all associated data.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            AppBtn(
              onPressed: () {},
              label: 'Yes, Delete Account',
              textSize: 15,
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 250,
              child: CancelBtn(onPressed: () =>  Get.back(),),
            ),
          ],
        );
      },
    );
  }

  final String content =
      """This action will permanently delete all of your data, and you will not be able to recover it. Please keep the following in mind before proceeding:
          
• All your expenses, income and associate transactions will be eliminated. 
          
• You will not be able to access your account or any-related information. 
          
• This action cannot be undone.""";
}
