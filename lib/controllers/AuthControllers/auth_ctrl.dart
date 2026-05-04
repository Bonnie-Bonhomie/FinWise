import 'package:dio/dio.dart';
import 'package:fin_wise/Services/biometric_serv.dart';
import 'package:fin_wise/controllers/loader_contrl.dart';
import 'package:fin_wise/core/resources/storage_keys.dart';
import 'package:fin_wise/data/dataSource/storage_file.dart';
import 'package:fin_wise/data/models/AuthModel/user_model.dart';
import 'package:fin_wise/data/models/profile_model.dart';
import 'package:fin_wise/data/repositories/AuthRepo/auth_repo.dart';
import 'package:fin_wise/utils/Helpers/share_prefer_services.dart';
import 'package:fin_wise/utils/widgets/custom_alert_dialog.dart';
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
  ProfileModel? user;
  String? err;

  Future<void> registerUser({
    required String name,
    required String mail,
    required String dob,
    required String phone,
    required String password,
    required String confirmPassword,
  })
  async {
    LoaderController.to.show();
      final response = await authRepo.registerUser(
        name: name,
        mail: mail,
        dob: dob,
        phone: phone,
        password: password,
        confirmPassword: confirmPassword,
      );
      print(response);
      // final token = response.data['token'];
      // await storage.saveToken(token);

      if (response is DataSuccess && response.data['status'] == true) {
        user = ProfileModel.fromJson(response.data['data']);
        print(user?.name);

        if(user?.email != null){
          await store.saveData<String>(PrefStoreKeys.username, user!.email);
        }
        CustomSnackbar.successSnack(response.data['message']);
        Get.offNamed(Routes.verAcc);
        // Get.find();
      }
      else if (response is DataFailed) {
        final err = response.exception?.error;
        print(err.toString());
        //Network error
        if (err is DioException) {
          if (err.type == DioExceptionType.connectionError ||
              err.type == DioExceptionType.receiveTimeout ||
              err.type == DioExceptionType.connectionError) {
            CustomSnackbar.showSnackbar(message: 'No internet connection');
          }
          //Server error
          else if(err.response != null){
            final errData = err.response?.data;
            if (errData != null && errData['message'] != null) {
              CustomSnackbar.showSnackbar(message: errData['message']);
            } else {
              CustomSnackbar.showSnackbar(
                message: err.response?.data ?? 'Server Error, try again later',
              );
            }
          }
          else{
            CustomSnackbar.showSnackbar(message: 'Something went wrong, try again later');
          }
        }else{
          CustomSnackbar.showSnackbar(message: 'Unknown error occur, try again later');
        }
      }

    LoaderController.to.hide();
  }

  Future<void> loginUser(String mail, String password) async {
    final response = await authRepo.loginUser(email: mail, password: password);
    // final token = response.data['token'];
    // await storage.saveToken(token);

    if (response is DataSuccess && response.data['status'] == 'true') {
      // user = UserModel.fromJson(response.data);
      CustomSnackbar.successSnack(response.data['message']);
    } else if (response is DataFailed) {
      final err = response.exception?.error;
      print(err.toString());
      //Network error
      if (err is DioException) {
        if (err.type == DioExceptionType.connectionError ||
            err.type == DioExceptionType.receiveTimeout ||
            err.type == DioExceptionType.connectionError) {
          CustomSnackbar.showSnackbar(message: 'No internet connection');
        }
        //Server error
        else if(err.response != null){
          final errData = err.response?.data;
          if (errData != null && errData['message'] != null) {
            CustomSnackbar.showSnackbar(message: errData['message']);
          } else {
            CustomSnackbar.showSnackbar(
              message: err.response?.data ?? 'Something went wrong, try again later',
            );
          }
        }
        // else{
        //   CustomSnackbar.showSnackbar(message: 'Something went wrong, try again later');
        // }
      }else{
        CustomSnackbar.showSnackbar(message: 'Unknown error occur, try again later');
      }
    }
  }

  Future<void> loginWithFingerprint() async {
    isAuthenticate.value = true;
    final bool hasShown =
        await store.retrieve<bool>(PrefStoreKeys.isFirstTime) ?? false;
    final canAuth = await biometricService.canAuthenticate();

    if (!canAuth && hasShown) {
      GetSnackBar(
        title: "Unavailable",
        message: "Biometric authentication is not available",
      );
      isAuthenticate.value = false;
    }

    final success = await biometricService.authenticate();
    isAuthenticate.value = false;

    if (success) {
      Get.offAllNamed(Routes.mainS);
    } else {
      GetSnackBar(title: "Oops", message: "Fingerprint authentication failed");
    }
  }

  Future<void> verifyEmail({required BuildContext context, required int otp}) async {
    final response = await authRepo.verifyEmail(otp: otp);
    // final token = response.data['token'];
    // await storage.saveToken(token);

    if (response is DataSuccess && response.data['status'] == 'true') {
      // user = UserModel.fromJson(response.data);
      showCustomDiag(context);
    } else if (response is DataFailed) {
      final err = response.exception?.error;
      print(err.toString());
      //Network error
      if (err is DioException) {
        if (err.type == DioExceptionType.connectionError ||
            err.type == DioExceptionType.receiveTimeout ||
            err.type == DioExceptionType.connectionError) {
          CustomSnackbar.showSnackbar(message: 'No internet connection');
        }
        //Server error
        else if(err.response != null){
          final errData = err.response?.data;
          if (errData != null && errData['message'] != null) {
            CustomSnackbar.showSnackbar(message: errData['message'] ?? 'Incorrect OTP');
          } else {
            CustomSnackbar.showSnackbar(
              message: err.response?.data ?? 'Something went wrong, try again later',
            );
          }
        }
        // else{
        //   CustomSnackbar.showSnackbar(message: 'Something went wrong, try again later');
        // }
      }else{
        CustomSnackbar.showSnackbar(message: 'Unknown error occur, try again later');
      }
    }
  }
}
