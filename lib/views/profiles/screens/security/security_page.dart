import 'package:fin_wise/controllers/profileCtrl/main_ctrl.dart';
import 'package:fin_wise/core/Routes/Api_endpoints/api_endpoints.dart';
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/utils/widgets/custom_app_bar.dart';
import 'package:fin_wise/utils/widgets/general_web_view.dart';
import 'package:fin_wise/utils/widgets/text_widget.dart';
import 'package:fin_wise/viewModel/home_view_model.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SecurityPage extends StatelessWidget {
  SecurityPage({super.key});

  final HomeViewModel viewModel = HomeViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageContainer(
        topMargin: 20,
        topChild: CustomAppBar.header(title: 'Security',leftRight: 15, onPressed: () => Get.find<ProfileMainControl>().back()),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppText(
                text: 'Security',
                textSize: 25,
                textWeigh: FontWeight.bold,
              ),
              secureTile('Change Pin', (){Get.find<ProfileMainControl>().toChangePin();}, Icons.keyboard_command_key_sharp),
              // secureTile('FingerPrint', (){Get.find<ProfileMainControl>().toFingerPrints();}),
              secureTile('Terms and Condition', (){Get.to(() => GeneralWebView(url: ApiEndpoints.terms));}, Icons.rule_folder_outlined),
              secureTile('Privacy Policy', (){Get.to(() => GeneralWebView(url: ApiEndpoints.policy));}, Icons.policy_outlined),
            ],
          ),
        ),
      ),
    );
  }

  Widget secureTile(String title, VoidCallback onTap, IconData icon) {
    return ListTile(
      leading: CircleAvatar(backgroundColor: AppColors.primary, radius: 15.0, child: Icon(icon),),
      title: AppText(text: title),
      trailing: const Icon(Icons.arrow_right),
      onTap: onTap,
    );
  }
}
