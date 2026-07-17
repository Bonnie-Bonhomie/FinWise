import 'package:data_boot/controllers/categoryCtrl/television_ctrl.dart';
import 'package:data_boot/core/connection/network.dart';
import 'package:data_boot/data/dataSource/api_service.dart';
import 'package:data_boot/data/dataSource/storage_file.dart';
import 'package:data_boot/data/repositories/CategoriesRepo/television_repo.dart';
import 'package:data_boot/utils/Helpers/share_prefer_services.dart';
import 'package:get/get.dart';

class TvBindings extends Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => TelevisionRepo(Get.find<ApiServices>(), Get.find<InternetService>()), fenix: true);
    Get.lazyPut(() => TelevisionCtrl(Get.find<TelevisionRepo>(), Get.find<StorageFile>(), Get.find<SharedPreferService>()), fenix: true);
  }
}