import 'package:fin_wise/controllers/categoryCtrl/market_ctrl.dart';
import 'package:fin_wise/core/connection/network.dart';
import 'package:fin_wise/data/dataSource/api_service.dart';
import 'package:fin_wise/data/dataSource/storage_file.dart';
import 'package:fin_wise/data/repositories/CategoriesRepo/market_repo.dart';
import 'package:get/get.dart';

class MarketBinding extends Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<MarketRepo>(() => MarketRepo(Get.find<ApiServices>(), Get.find<InternetService>()), fenix: true);
    Get.lazyPut<MarketCtrl>(() => MarketCtrl(Get.find<MarketRepo>(), Get.find<StorageFile>()), fenix: true);
  }
}