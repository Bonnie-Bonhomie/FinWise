//
// import 'package:fin_wise/controllers/categoryCtrl/category_nav_ctrl.dart';
// import 'package:fin_wise/core/constant.dart';
// import 'package:fin_wise/views/view_widgets/category_card.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class CategoryWrapper extends StatelessWidget {
//   const CategoryWrapper({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Wrap(
//       spacing: 10,
//       runSpacing: 15,
//       children: List.generate(Categories.values.length, (index) {
//         final category = Categories.values[index];
//         return CategoriesCard(
//           icon: category.icon,
//           title: category.label,
//           onTap: () => Get.find<CategoryNavCtrl>().toAirtime(),
//         );
//       }),
//     );
//   }
// }
