import 'package:fin_wise/controllers/categoryCtrl/education_controller.dart';
import 'package:get/get.dart';

class EducationBinding extends Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => EducationController());
  }

}