
import 'package:fin_wise/utils/widgets/LoadingFiles/loading_wrapper.dart';
import 'package:fin_wise/utils/widgets/app_btn.dart';
import 'package:fin_wise/utils/widgets/custom_app_bar.dart';
import 'package:fin_wise/utils/widgets/text_widget.dart';
import 'package:fin_wise/views/view_widgets/cancel_button.dart';
import 'package:fin_wise/views/view_widgets/shared_widget.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/controller_exports.dart';

class DeleteAccount extends StatelessWidget {
  DeleteAccount({super.key});

  final ctrl = Get.find<DeleteCtrl>();
  final loader = Get.find<LoaderController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoaderWrapper(
        child: PageContainer(
          topMargin: 20,
          topChild: CustomAppBar.header(
            title: 'Delete Account',
            leftRight: 15,
            onPressed: () => Get.find<ProfileMainControl>().back(),
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
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(content, textAlign: TextAlign.start),
              ),
              const Text(
                    'Please enter your password to continue deletion of your account',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 40,
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter password',
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.visibility_outlined),
                    ),

                  ),
                ),
              ),
              const SizedBox(height: 15),
              AppBtn(
                onPressed: () {
                  showDelDialog(context);
                },
                label: 'Yes, Delete Account',isDel: true,
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  Get.find<ProfileMainControl>().back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).cardColor,
                ),
                child: const AppText(
                  text: 'Cancel',
                  // textColor: AppColors.darkGreen,
                  textSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showDelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // backgroundColor: AppColors.bgColor,
          title: const HeadingText(headingText: 'Delete Account'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Are you sure you want to delete account?',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(

                    'By deleting your account, you agree that you understand the consequence of this action and that you agree to permanently delete your account and all associated data.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            AppBtn(
              onPressed: () {
                Get.back();
                loader.offLoading(() async{
                  await ctrl.deleteAccount();
                });
              },
              label: 'Yes, Delete Account',
              textSize: 15,
              isDel: true,
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
