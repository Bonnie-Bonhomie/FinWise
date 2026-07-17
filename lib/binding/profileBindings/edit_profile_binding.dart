import 'package:data_boot/controllers/profileCtrl/edit_ctrl.dart';
import 'package:data_boot/core/connection/network.dart';
import 'package:data_boot/data/dataSource/api_service.dart';
import 'package:data_boot/data/dataSource/storage_file.dart';
import 'package:data_boot/data/repositories/profileRepo/edit_profile_repo.dart';
import 'package:data_boot/utils/Helpers/share_prefer_services.dart';
import 'package:get/get.dart';

class EditBinding extends Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => EditProfileRepo(Get.find<ApiServices>(), Get.find<InternetService>()), fenix: true);
    Get.lazyPut(()=> EditProfileCtrl(Get.find<EditProfileRepo>(), Get.find<StorageFile>(), Get.find<SharedPreferService>()), fenix: true);
  }
}