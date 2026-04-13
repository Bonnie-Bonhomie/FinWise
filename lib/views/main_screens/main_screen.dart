
import 'package:fin_wise/controllers/bottom_nav_ctrl.dart';
import 'package:fin_wise/utils/widgets/LoadingFiles/loading_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/app_colors.dart';

class MainScreen extends StatelessWidget{
  const MainScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NavControl>();
    return WillPopScope(
      onWillPop: () => controller.willPopHandler(),
      child: LoaderWrapper(
        child: Scaffold(
          body: Obx(()=> controller.screens[controller.selectInd.value]),
          backgroundColor: AppColors.bgColor,
          bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.only(topRight: Radius.circular(60), topLeft: Radius.circular(60)),
            child: Obx(()=> BottomAppBar(
                color: AppColors.lightGreen,
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(5, (index) {
        
                    final isSelected = controller.selectInd.value == index;
                    return IconButton(onPressed: (){
                      controller.selectInd.value = index;
                    },
                        style: IconButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                          backgroundColor: isSelected? AppColors.primary : AppColors.lightGreen,),
                        icon: Icon(controller.icons[index]), color: AppColors.darkGreen);
                  }),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../controllers/bottom_nav_ctrl.dart';
//
//
//
// class MainScreen extends StatelessWidget {
//   const MainScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//
//     NavControl control = Get.put(NavControl());
//
//     // return WillPopScope(
//     //   // onWillPop: control.willPopHandler,
//       return Scaffold(
//         body: Obx(()=> control.screens[control.selectInd.value]),
//
//         // floatingActionButton: FloatingActionButton(onPressed: (){
//         //   Get.to(()=> AddAction());
//         // },
//         //   shape: CircleBorder(),
//         //   tooltip: "Add Task",
//         //   child: Icon(Icons.add, color: Colors.white, size: 30,), ),
//         //
//         // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//
//         bottomNavigationBar: ClipRRect(
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(30),
//             topRight: Radius.circular(30),
//           ),
//           child: Obx(()=> BottomAppBar(
//             // notchMargin: 10,
//               height: 80,
//               shape: CircularNotchedRectangle(),
//               color: Theme.of(context).appBarTheme.backgroundColor,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: List.generate(5, (index){
//                   return Tooltip(
//                     message: control.tooltips[index],
//                     decoration: BoxDecoration(color: ColorTools.primaryLight, borderRadius: BorderRadius.circular(20)),
//                     child: IconButton(onPressed: (){
//                       control.selectInd.value = index;
//                     }, icon: Icon(control.icons[index]),
//                       color: ColorTools.background,
//                       iconSize: 30,
//                       style: IconButton.styleFrom(backgroundColor: control.selectInd.value == index? ColorTools.blueFade: null,),
//                     ),
//                   );
//                 }),
//               )
//           ),
//           ),
//       ),
//     );
//   }
// }
