import 'package:fin_wise/controllers/profileCtrl/edit_ctrl.dart';
import 'package:fin_wise/core/connection/network.dart';
import 'package:fin_wise/data/dataSource/api_service.dart';
import 'package:fin_wise/data/repositories/profileRepo/edit_profile_repo.dart';
import 'package:get/get.dart';

class EditBinding extends Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => EditProfileRepo(Get.find<ApiServices>(), Get.find<InternetService>()), fenix: true);
    Get.lazyPut(()=> EditProfileCtrl(Get.find()), fenix: true);
  }
}