import 'package:fin_wise/controllers/profileCtrl/main_ctrl.dart';
import 'package:fin_wise/controllers/profileCtrl/notification_settings_ctrl.dart';
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/core/widgets/custom_app_bar.dart';
import 'package:fin_wise/core/widgets/text_widget.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationSettings extends StatelessWidget {
  NotificationSettings({super.key});

  final ctrl = Get.find<NoteSettingsCtrl>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageContainer(
        topMargin: 20,
        topChild: CustomAppBar.header(
          'Notification Settings',
          15,
          () => Get.find<ProfileMainControl>().back(),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Obx(() {
            return Column(
              children: [
                switchTile('General Notification', ctrl.general.value, (val) async{
                  await ctrl.saveTransUpdate();
                  ctrl.general.value = val;
                }),
                switchTile('Transaction Update', ctrl.transUpdate.value, (val) {
                  ctrl.transUpdate.value = val;
                  ctrl.saveTransUpdate();
                }),
                switchTile('Low Balance Alerts', ctrl.lowBalance.value, (val) {
                  ctrl.lowBalance.value = val;
                }),
                switchTile('Push Notification', ctrl.pushNotify.value, (val) {
                  ctrl.pushNotify.value = val;
                }),
                switchTile('Email Notification', ctrl.mailNotify.value, (val) {
                  ctrl.mailNotify.value = val;
                }),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget switchTile(
    String title,
    bool typeSwitch,
    ValueChanged<bool> onChanged,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(text: title, textSize: 15),
        Transform.scale(
          scale: 0.8,
          child: Switch(
            value: typeSwitch,
            activeColor: AppColors.primary,
            inactiveTrackColor: AppColors.lightGreen,
            inactiveThumbColor: AppColors.primary,
            trackOutlineColor: WidgetStateColor.transparent,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
