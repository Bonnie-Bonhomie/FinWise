import 'package:fin_wise/controllers/loader_contrl.dart';
import 'package:fin_wise/core/Routes/routes.dart';
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/utils/widgets/custom_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class KeyPadController extends GetxController{

  late LoaderController load = Get.find<LoaderController>();


  final TextEditingController pinText = TextEditingController();
  RxString input = ''.obs;
  var loading = false.obs;

  void addValue(String value, int len){
    if(pinText.text.length < len){
      pinText.text +=value;
    }
    print(pinText.text);
  }

  void deleteValue(){
    if(pinText.text.isNotEmpty){
      pinText.text= pinText.text.substring(0, pinText.text.length - 1);
    }
  }
  void clearAll(){
    pinText.text = '';
  }

  void loadPin(pin) async{

    if(pin.length == 4) {
      Get.back();
      // load.show();
      load.offLoading(() async {
       validatePin(pin);
      });
    }
  }

  Future<void> validatePin(pin) async {

    bool isValid = pin == '2345';

    if(isValid){
      Get.offNamed(Routes.transSuccess, arguments: 200);
    }else{
      CustomSnackbar.warningSnack('Incorrect Pin. Recheck and try again');
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    pinText.dispose();
    super.onClose();

  }


}