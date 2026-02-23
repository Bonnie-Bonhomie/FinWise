import 'package:fin_wise/controllers/profileCtrl/main_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/text_widget.dart';


class Profiles extends StatelessWidget {
  const Profiles({super.key});

  // final ctrl = Get.put(ProfileMainControl());


  @override
  Widget build(BuildContext context) {
    // print(Get.currentRoute);
    return GetBuilder<ProfileMainControl>(
      builder: (ctrl) {
        print(Get.currentRoute);
        return GetNavigator(
            key: ctrl.navKey,
            pages: ctrl.pages,
          // reportsRouteUpdateToEngine: true,
          onPopPage: (routes, result){
              if(!routes.didPop(result)) return false;
              ctrl.back();
              return true;
          },
        );
      }
    );
  }


}
