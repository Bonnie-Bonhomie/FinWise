import 'package:fin_wise/controllers/categoryCtrl/electricity_ctrl.dart';
import 'package:fin_wise/core/connection/network.dart';
import 'package:fin_wise/data/dataSource/api_service.dart';
import 'package:fin_wise/data/repositories/CategoriesRepo/electricity_repo.dart';
import 'package:get/get.dart';

class ElectricityBinding extends Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => ElectricityRepo(Get.find<ApiServices>(), Get.find<InternetService>()), fenix: true);
    Get.lazyPut(() => ElectricityCtrl(Get.find<ElectricityRepo>()), fenix: true);
  }
}