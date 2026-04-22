import 'package:fin_wise/Services/biometric_serv.dart';
import 'package:fin_wise/controllers/loader_contrl.dart';
import 'package:fin_wise/core/resources/storage_keys.dart';
import 'package:fin_wise/data/dataSource/storage_file.dart';
import 'package:fin_wise/data/models/AuthModel/user_model.dart';
import 'package:fin_wise/data/repositories/AuthRepo/auth_repo.dart';
import 'package:fin_wise/utils/Helpers/share_prefer_services.dart';
import 'package:fin_wise/utils/widgets/custom_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../core/Routes/routes.dart';
import '../../core/resources/data_state.dart';

class AuthCtrl extends GetxController {

  final AuthRepository authRepo;
  final StorageFile storage;
  final SharedPreferService store;
  AuthCtrl(this.authRepo, this.storage, this.store);
  final BiometricService biometricService = BiometricService();
  var isAuthenticate = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    debugPrint('Auth Control');
    super.onInit();

  }


  RxBool loading = false.obs;
  UserModel? user;
  String? err;



  Future<void> registerUser({
    required String name,
    required String mail,
    required String dob,
    required String phone,
    required String password,
    required String confirmPassword,
  }) async{
    LoaderController.to.show();


    final response = await authRepo.registerUser(
      name: name,
      mail: mail,
      dob: dob,
      phone: phone,
      password: password,
      confirmPassword: confirmPassword,
    );
    // print(response.data);
    // final token = response.data['token'];
    // await storage.saveToken(token);

    if(DataState is DataSuccess && response.data['status'] == 'true'){
      user = UserModel.fromJson(response.data['user']);
      // print(user);
    //   // print
      CustomSnackbar.successSnack(response.message.toString());
      Get.offNamed(Routes.verAcc);
      Get.find();
    }
    else {
      err = response.exception?.error.toString() ?? 'Unable to create account';
      GetSnackBar(message: err,);
      // print(err);
      // print(err);
    }
    LoaderController.to.hide();
  }


  Future<void> loginUser (String mail, String password)  async{

    final response = await authRepo.loginUser(mail: mail, password: password);
    final token = response.data['token'];
    await storage.saveToken(token);

    if(DataState is DataSuccess && response.data['status'] == 'success'){
      user = UserModel.fromJson(response.data);
    }else if (DataState is DataSuccess && response.data['invalid credential']){
      err = 'Invalid email or password';
    }
    else{

    }
  }
  Future<void> loginWithFingerprint() async {
    isAuthenticate.value = true;
    final bool hasShown = await store.retrieve<bool>(PrefStoreKeys.isFirstTime) ?? false;
    final canAuth = await biometricService.canAuthenticate();

    if(!canAuth && hasShown){
      GetSnackBar(title: "Unavailable", message: "Biometric authentication is not available",);
      isAuthenticate.value = false;
    }

    final success = await biometricService.authenticate();
    isAuthenticate.value = false;

    if(success){
      Get.offAllNamed(Routes.mainS);
    }else{
      GetSnackBar(title: "Oops", message: "Fingerprint authentication failed", );
    }
  }
}
