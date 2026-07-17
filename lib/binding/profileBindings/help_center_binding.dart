import 'package:data_boot/controllers/controller_exports.dart';
import 'package:data_boot/core/connection/network.dart';
import 'package:data_boot/data/dataSource/api_service.dart';
import 'package:data_boot/data/dataSource/storage_file.dart';
import 'package:data_boot/data/repositories/profileRepo/help_center_repo.dart';
import 'package:get/get.dart';

class HelpCenterBinding extends Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => HelpCenterRepo(Get.find<ApiServices>(), Get.find<InternetService>()), fenix: true);
    Get.lazyPut<HelpControl>(() => HelpControl(Get.find<HelpCenterRepo>(), Get.find<StorageFile>()), fenix: true);
  }
}