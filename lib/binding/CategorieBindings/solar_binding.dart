import 'package:fin_wise/controllers/categoryCtrl/solar_ctrl.dart';
import 'package:fin_wise/core/connection/network.dart';
import 'package:fin_wise/data/dataSource/api_service.dart';
import 'package:fin_wise/data/dataSource/storage_file.dart';
import 'package:fin_wise/data/repositories/CategoriesRepo/market_repo.dart';
import 'package:get/get.dart';

class SolarBinding extends Bindings{
  
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=>MarketRepo(Get.find<ApiServices>(), Get.find<InternetService>()),fenix: true);
    Get.lazyPut(() => SolarCtrl(Get.find<MarketRepo>(), Get.find<StorageFile>()), fenix: true);
  }
}