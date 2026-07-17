import 'package:data_boot/controllers/categoryCtrl/education_controller.dart';
import 'package:data_boot/core/connection/network.dart';
import 'package:data_boot/data/dataSource/api_service.dart';
import 'package:data_boot/data/dataSource/storage_file.dart';
import 'package:data_boot/data/repositories/CategoriesRepo/education_repo.dart';
import 'package:get/get.dart';

class EducationBinding extends Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => EducationRepo(Get.find<ApiServices>(), Get.find<InternetService>()), fenix: true);
    Get.lazyPut(() => EducationController(Get.find<EducationRepo>(), Get.find<StorageFile>()), fenix: true);
  }

}