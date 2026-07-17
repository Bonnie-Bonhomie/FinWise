import 'package:data_boot/controllers/categoryCtrl/electricity_ctrl.dart';
import 'package:data_boot/core/connection/network.dart';
import 'package:data_boot/data/dataSource/api_service.dart';
import 'package:data_boot/data/dataSource/storage_file.dart';
import 'package:data_boot/data/repositories/CategoriesRepo/electricity_repo.dart';
import 'package:get/get.dart';

class ElectricityBinding extends Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => ElectricityRepo(Get.find<ApiServices>(), Get.find<InternetService>()), fenix: true);
    Get.lazyPut(() => ElectricityCtrl(Get.find<ElectricityRepo>(), Get.find<StorageFile>()), fenix: true);
  }
}