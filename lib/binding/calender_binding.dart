import 'package:data_boot/controllers/analysis/calender_ctrl.dart';
import 'package:get/get.dart';

class CalenderBinding extends Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<CalenderCtrl>(() => CalenderCtrl());
  }
}