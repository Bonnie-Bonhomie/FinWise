import 'package:fin_wise/controllers/categoryCtrl/data_controller.dart';
import 'package:fin_wise/core/connection/network.dart';
import 'package:fin_wise/data/dataSource/api_service.dart';
import 'package:fin_wise/data/repositories/CategoriesRepo/data_repository.dart';
import 'package:get/get.dart';

class DataBindings extends Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=> DataRepository(Get.find<ApiServices>(), Get.find<InternetService>()), fenix: true);
    Get.lazyPut(()=> DataController(Get.find<DataRepository>()), fenix: true);
  }
}