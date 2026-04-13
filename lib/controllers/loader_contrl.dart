import 'package:fin_wise/core/Routes/routes.dart';
import 'package:get/get.dart';

class LoaderController  extends GetxController{

  static LoaderController get to => Get.find();

  final RxBool _loading = false.obs;

  bool get loading => _loading.value;

  void show(){
    _loading.value = true;
  }
  void hide(){
    _loading.value = false;
  }

  var isLoading = false.obs;

  void offLoading(Function action){
    isLoading.value = true;
    Future.delayed(Duration(seconds: 2), () async{
      await action();
      isLoading.value = false;
    });

  }

  // void offoading(Function() action){
  //   isLoading.value = true;
  //   Future.delayed(Duration(seconds: 2), () {
  //     action();
  //     isLoading.value = false;
  // //   });
  //
  // }


}