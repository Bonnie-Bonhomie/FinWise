//
// import 'package:fin_wise/data/dataSource/api_service.dart';
// import 'package:fin_wise/controllers/AuthControllers/auth_ctrl.dart';
// import 'package:fin_wise/data/repositories/AuthRepo/auth_repo.dart';
// import 'package:get/get.dart';
//
// class AuthBinding extends Bindings{
//
//  @override
//   void dependencies() {
//  Get.lazyPut(()=> ApiServices());
//   Get.lazyPut<AuthRepository>(
//       () => AuthRepository(apiServices: Get.find(), internetInfo: Get.find()),
//     fenix: true,
//   );
//   Get.lazyPut<AuthCtrl>(()=> AuthCtrl(Get.find()), fenix: true);
//
//     // TODO: implement dependencies
//   }
// }