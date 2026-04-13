import 'package:fin_wise/controllers/profileCtrl/main_ctrl.dart';
import 'package:fin_wise/core/Routes/routes.dart';
import 'package:fin_wise/core/widgets/custom_app_bar.dart';
import 'package:fin_wise/core/widgets/text_widget.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SecurityPage extends StatelessWidget {
  const SecurityPage({super.key});

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
              secureTile('Change Pin', (){Get.find<ProfileMainControl>().toChangePin();}),
              secureTile('FingerPrint', (){Get.find<ProfileMainControl>().toFingerPrints();}),
              secureTile('Terms and Condition', (){Get.toNamed(Routes.terms);}),
            ],
          ),
        ),
      ),
    );
  }

  Widget secureTile(String title, VoidCallback onTap) {
    return ListTile(
      title: AppText(text: title),
      trailing: const Icon(Icons.arrow_right),
      onTap: onTap,
    );
  }
}
