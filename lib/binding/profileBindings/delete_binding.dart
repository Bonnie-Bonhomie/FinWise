

import 'package:data_boot/controllers/controller_exports.dart';
import 'package:data_boot/core/connection/network.dart';
import 'package:data_boot/data/dataSource/api_service.dart';
import 'package:data_boot/data/dataSource/storage_file.dart';
import 'package:data_boot/data/repositories/profileRepo/delete_acc_repo.dart';
import 'package:data_boot/utils/Helpers/share_prefer_services.dart';
import 'package:get/get.dart';

class DeleteBinding extends Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<DeleteAccRepo>(() => DeleteAccRepo(Get.find<ApiServices>(), Get.find<InternetService>()));
    Get.lazyPut<DeleteCtrl>(() => DeleteCtrl(Get.find<DeleteAccRepo>(), Get.find<StorageFile>(), Get.find<SharedPreferService>()));
  }
}