import 'package:fin_wise/controllers/profileCtrl/change_pin_ctrl.dart';
import 'package:fin_wise/data/repositories/profileRepo/change_pin_repository.dart';
import 'package:get/get.dart';

class ChangePinBinding extends Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => ChangePinRepo(Get.find(), Get.find()));
    Get.lazyPut(() => ChangePinCtrl(Get.find(), Get.find()));
  }
}