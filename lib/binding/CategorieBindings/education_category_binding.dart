import 'package:fin_wise/controllers/categoryCtrl/education_controller.dart';
import 'package:fin_wise/core/connection/network.dart';
import 'package:fin_wise/data/dataSource/api_service.dart';
import 'package:fin_wise/data/repositories/CategoriesRepo/education_repo.dart';
import 'package:get/get.dart';

class EducationBinding extends Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => EducationRepo(Get.find<ApiServices>(), Get.find<InternetService>()), fenix: true);
    Get.lazyPut(() => EducationController(Get.find<EducationRepo>()), fenix: true);
  }

}