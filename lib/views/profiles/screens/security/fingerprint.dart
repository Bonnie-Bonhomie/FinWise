import 'package:fin_wise/controllers/profileCtrl/fingerprint_ctrl.dart';
import 'package:fin_wise/controllers/profileCtrl/main_ctrl.dart';
import 'package:fin_wise/core/widgets/custom_app_bar.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/widgets/text_widget.dart';

class FingerprintListView extends StatelessWidget {
  FingerprintListView({super.key});

  final FingerprintCtrl ctrl = Get.put(FingerprintCtrl());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageContainer(
        topMargin: 20,
        topChild: CustomAppBar.header(
          'FingerPrints',
          15,
          () => Get.find<ProfileMainControl>().back(),
        ),
        child: Column(
          children: [
            ctrl.fingerprints.isEmpty
                ? SizedBox.shrink()
                : ListView.builder(
                    itemCount: ctrl.fingerprints.length,
                    itemBuilder: (context, index) {
                      final title = ctrl.fingerprints[index];
                      return profileTile(
                        title,
                        Icons.fingerprint_rounded,
                        AppColors.subBlue,
                        () {
                          Get.find<ProfileMainControl>().delFinger();
                        },
                      );
                    },
                  ),
            profileTile('Add a FingerPrint', Icons.add, AppColors.blue, () {
              Get.find<ProfileMainControl>().addFinger();
            }),
          ],
        ),
      ),
    );
  }

  Widget profileTile(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
      child: ListTile(
        title: AppText(text: title),
        leading: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color,
          ),
          child: Icon(icon, color: AppColors.bgColor),
        ),
        onTap: onTap,
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
