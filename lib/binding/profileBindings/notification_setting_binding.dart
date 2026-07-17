import 'package:data_boot/controllers/profileCtrl/notification_settings_ctrl.dart';
import 'package:data_boot/utils/Helpers/share_prefer_services.dart';
import 'package:get/get.dart';

class NotifySettingBinding extends Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => NoteSettingsCtrl(Get.find<SharedPreferService>()));
  }
}