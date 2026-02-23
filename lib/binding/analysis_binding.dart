// import 'package:fin_wise/controllers/analysis/analysis_ctrl.dart';
// import 'package:fin_wise/core/connection/network.dart';
// import 'package:fin_wise/data/dataSource/api_service.dart';
// import 'package:fin_wise/data/repositories/analysis_repo.dart';
// import 'package:get/get.dart';
//
// class AnalysisBinding extends Bindings{
//   @override
//   void dependencies() {
//     // TODO: implement dependencies
//     Get.lazyPut<AnalysisRepo>(() => AnalysisRepo(Get.find<ApiServices>(), Get.find<InternetService>()), fenix: true);
//
//     Get.lazyPut<AnalysisCtrl>(() => AnalysisCtrl(Get.find<AnalysisRepo>()), fenix: true);
//   }
// }