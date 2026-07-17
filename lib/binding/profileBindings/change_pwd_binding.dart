import 'package:data_boot/controllers/profileCtrl/change_pwd_ctrl.dart';
import 'package:data_boot/core/connection/network.dart';
import 'package:data_boot/data/dataSource/api_service.dart';
import 'package:data_boot/data/dataSource/storage_file.dart';
import 'package:data_boot/data/repositories/profileRepo/change_pwd_repo.dart';
import 'package:get/get.dart';

class ChangePwdBinding extends Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => ChangePwdRepo(Get.find<ApiServices>(), Get.find<InternetService>()));
    Get.lazyPut(() => ChangePwdControl(Get.find<ChangePwdRepo>(), Get.find<StorageFile>()));
  }
}