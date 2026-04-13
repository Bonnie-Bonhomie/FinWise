import 'package:fin_wise/controllers/profileCtrl/main_ctrl.dart';
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/core/widgets/custom_app_bar.dart';
import 'package:fin_wise/core/widgets/text_widget.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageContainer(
        topMargin: 20,
        topChild: CustomAppBar.header(
         title: 'Settings',
         leftRight: 15,
          onPressed: () => Get.find<ProfileMainControl>().back(),
        ),
        child: Column(
          children: [
            settingTile(
              'Notification Settings',
              Icons.notifications_none_outlined,
              () => Get.find<ProfileMainControl>().toNoteSettings(),
            ),
            settingTile(
              'Password Settings',
              Icons.vpn_key_outlined,
              () => Get.find<ProfileMainControl>().toChangePwd(),
            ),
            settingTile(
              'Delete Account',
              Icons.person_outline_outlined,
              () => Get.find<ProfileMainControl>().toDelAccount(),
            ),
          ],
        ),
      ),
    );
  }

  Widget settingTile(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      title: AppText(text: title),
      leading: CircleAvatar(
        radius: 15.0,
        backgroundColor: AppColors.primary,
        child: Icon(icon, color: AppColors.lightGreen,),
      ),
      trailing: const Icon(Icons.arrow_right,),
      onTap: onTap,
    );
  }
}
