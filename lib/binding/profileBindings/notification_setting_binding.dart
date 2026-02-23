import 'package:fin_wise/controllers/profileCtrl/notification_settings_ctrl.dart';
import 'package:fin_wise/utils/Helpers/share_prefer_services.dart';
import 'package:get/get.dart';

class NotifySettingBinding extends Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => NoteSettingsCtrl(Get.find<SharedPreferService>()));
  }
}