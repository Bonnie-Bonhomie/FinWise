import 'package:fin_wise/controllers/categoryCtrl/television_ctrl.dart';
import 'package:fin_wise/core/connection/network.dart';
import 'package:fin_wise/data/dataSource/api_service.dart';
import 'package:fin_wise/data/repositories/CategoriesRepo/television_repo.dart';
import 'package:get/get.dart';

class TvBindings extends Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => TelevisionRepo(Get.find<ApiServices>(), Get.find<InternetService>()), fenix: true);
    Get.lazyPut(() => TelevisionCtrl(Get.find<TelevisionRepo>()), fenix: true);
  }
}