import 'package:fin_wise/controllers/notificationCtrl/notify_controller.dart';
import 'package:get/get.dart';

class NotifyBinding extends Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<NotifyCtrl>(() => NotifyCtrl(), fenix: true);
  }
}