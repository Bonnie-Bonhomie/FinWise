import 'package:data_boot/controllers/notificationCtrl/notify_controller.dart';
import 'package:data_boot/core/connection/network.dart';
import 'package:data_boot/data/dataSource/api_service.dart';
import 'package:data_boot/data/dataSource/storage_file.dart';
import 'package:data_boot/data/repositories/notification_repo.dart';
import 'package:get/get.dart';

class NotifyBinding extends Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => NotificationRepo(Get.find<ApiServices>(), Get.find<InternetService>()), fenix: true);
    Get.lazyPut<NotifyCtrl>(() => NotifyCtrl(Get.find<NotificationRepo>(), Get.find<StorageFile>()), fenix: true);
  }
}