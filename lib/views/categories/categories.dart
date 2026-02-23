// import 'package:fin_wise/controllers/categoryCtrl/category_nav_ctrl.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class CategoriesView extends StatelessWidget {
//   const CategoriesView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<CategoryNavCtrl>(
//       builder: (pageCtrl) {
//         return GetNavigator(
//             key: pageCtrl.catNavKey,
//             pages: pageCtrl.pages,
//             onPopPage: (route, result){
//               if(!route.didPop(result))return false;
//               pageCtrl.back();
//               return true;
//             },
//         );
//       },
//     );
//   }
// }
