import 'package:data_boot/controllers/bottom_nav_ctrl.dart';
import 'package:data_boot/data/dataSource/api_service.dart';
import 'package:data_boot/data/dataSource/dio_client.dart';
import 'package:data_boot/utils/Helpers/share_prefer_services.dart';
import 'package:get/get.dart';

class InitialBindings extends Bindings{

  @override
  void dependencies() {
    Get.put(DioClients(), permanent: true);
    Get.put(ApiServices(), permanent: true);
    Get.put(NavControl(), permanent: true);
    Get.putAsync(() async => SharedPreferService());
    // TODO: implement dependencies
  }
}