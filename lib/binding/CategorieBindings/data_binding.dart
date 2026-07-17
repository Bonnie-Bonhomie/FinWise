import 'package:data_boot/controllers/categoryCtrl/data_controller.dart';
import 'package:data_boot/core/connection/network.dart';
import 'package:data_boot/data/dataSource/api_service.dart';
import 'package:data_boot/data/dataSource/storage_file.dart';
import 'package:data_boot/data/repositories/CategoriesRepo/data_repository.dart';
import 'package:get/get.dart';

class DataBindings extends Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=> DataRepository(Get.find<ApiServices>(), Get.find<InternetService>()), fenix: true);
    Get.lazyPut(()=> DataController(Get.find<DataRepository>(), Get.find<StorageFile>()), fenix: true);
  }
}