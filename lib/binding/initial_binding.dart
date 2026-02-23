import 'package:fin_wise/controllers/bottom_nav_ctrl.dart';
import 'package:fin_wise/data/dataSource/api_service.dart';
import 'package:fin_wise/data/dataSource/dio_client.dart';
import 'package:fin_wise/utils/Helpers/share_prefer_services.dart';
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