import 'package:fin_wise/core/Routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class KeyPadController extends GetxController{

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

  void loadPin(pin){

    if(pin.length == 4) {
      loading.value = true;
      Future.delayed(Duration(seconds: 3));
      FocusManager.instance.primaryFocus?.context;

      Future.microtask(() {
        Get.offNamed(Routes.transSuccess, arguments: 200);
      });
    }
    loading.value = false;
  }

  Future<void> validatePin(pin) async {

    // bool isValid = await repo.verifyPin();

    // if(isValid){
    //   Get.offNamed(Routes.transReceipt);
    // }else{
    //   Get.snackbar('Recheck', 'Incorrect pin', backgroundColor: AppColors.lightGreen);
    // }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    pinText.dispose();
    super.onClose();

  }


}