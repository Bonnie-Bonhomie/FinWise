import 'package:fin_wise/controllers/categoryCtrl/airtime_ctrl.dart';
import 'package:fin_wise/core/connection/network.dart';
import 'package:fin_wise/data/dataSource/api_service.dart';
import 'package:fin_wise/data/repositories/CategoriesRepo/airtime_repo.dart';
import 'package:get/get.dart';

class AirtimeBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => AirtimeRepository(Get.find<ApiServices>(), Get.find<InternetService>()), fenix: true);
    Get.lazyPut(() => AirtimeCtrl(Get.find<AirtimeRepository>()), fenix: true);
  }
}