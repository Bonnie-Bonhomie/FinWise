import 'package:fin_wise/utils/Helpers/CustomKeyPad/keypad_ctrl.dart';
import 'package:get/get.dart';

class KeypadBinding extends Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=> KeyPadController(), fenix:  true);
  }
}