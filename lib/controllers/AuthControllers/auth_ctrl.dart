import 'package:dio/dio.dart';
import 'package:fin_wise/Services/biometric_serv.dart';
import 'package:fin_wise/controllers/loader_contrl.dart';
import 'package:fin_wise/core/resources/storage_keys.dart';
import 'package:fin_wise/data/dataSource/storage_file.dart';
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
  String? successMessage;

  Future<void> registerUser({
    required String name,
    required String mail,
    required String dob,
    required String phone,
    required String password,
    required String confirmPassword,
  }) async {
    LoaderController.to.show();
      final response = await authRepo.registerUser(
        name: name,
        mail: mail,
        dob: dob,
        phone: phone,
        password: password,
        confirmPassword: confirmPassword,
      );
      // print(response);
      // final token = response.data['token'];
      // await storage.saveToken(token);

    if (response is DataSuccess) {
      final data = response.data;

      if (data['status'] == true) {
        user = ProfileModel.fromJson(data['data']);

        await store.saveData<String>(PrefStoreKeys.username, user!.email);

        CustomSnackbar.successSnack(data['message']);
        Get.offNamed(Routes.verAcc);
      } else {
        // ✅ backend handled inside success (if API returns 200 with status false)
        CustomSnackbar.showSnackbar(message: data['message']);
      }

    }
    else if (response is DataFailed) {
      final err = response.exception;

      if (err is DioException) {

        //  Network issues
        if (err.type == DioExceptionType.connectionError ||
            err.type == DioExceptionType.receiveTimeout ||
            err.type == DioExceptionType.connectionTimeout) {

          CustomSnackbar.showSnackbar(message: 'No internet connection');
          return;
        }

        //  Server error
        final errData = err.response?.data;
        // print(err.response?.data);

        if (errData != null && errData['message'] != null) {
          CustomSnackbar.showSnackbar(message: errData['message']);
        } else {
          CustomSnackbar.showSnackbar(
            message: 'Server error, try again later',
          );
        }

      } else {
        CustomSnackbar.showSnackbar(
          message: 'Unknown error occurred',
        );
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
      final err = response.exception;
      print(err.toString());
      //Network error
      if (err is DioException) {
        if (err.type == DioExceptionType.connectionError ||
            err.type == DioExceptionType.receiveTimeout ||
            err.type == DioExceptionType.connectionError) {
          CustomSnackbar.showSnackbar(message: 'No internet connection');
        }
        //Server error
        else if (err.response != null) {
          final errData = err.response?.data;
          if (errData != null && errData['message'] != null) {
            CustomSnackbar.showSnackbar(message: errData['message']);
          } else {
            CustomSnackbar.showSnackbar(
              message:
                  err.response?.data ?? 'Something went wrong, try again later',
            );
          }
        }
        // else{
        //   CustomSnackbar.showSnackbar(message: 'Something went wrong, try again later');
        // }
      } else {
        CustomSnackbar.showSnackbar(
          message: 'Unknown error occur, try again later',
        );
      }
    }
  }

  //LOginWIth Finger print
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
  //LOginWIth Finger print
  //Email verification
  Future<void> verifyEmail({
    required BuildContext context,
    required int otp,
  }) async {
    final response = await authRepo.verifyEmail(otp: otp, email: user!.email);
    if (response is DataSuccess) {
      final data = response.data;

      if (data['status'] == true) {
        showCustomDiag(context);
        print('Done');

      } else {
        // backend handled inside success (if API returns 200 with status false)
        CustomSnackbar.showSnackbar(message: data['message']);
      }

    } else if (response is DataFailed) {
      final err = response.exception;

      if (err is DioException) {

        //  Network issues
        if (err.type == DioExceptionType.connectionError ||
            err.type == DioExceptionType.receiveTimeout ||
            err.type == DioExceptionType.connectionTimeout) {

          CustomSnackbar.showSnackbar(message: 'No internet connection');
          return;
        }

        //  Server error
        final errData = err.response?.data;
        // print(err.response?.data);

        if (errData != null && errData['message'] != null) {
          CustomSnackbar.showSnackbar(message: errData['message']);
        } else {
          CustomSnackbar.showSnackbar(
            message: 'Server error, try again later',
          );
        }

      } else {
        CustomSnackbar.showSnackbar(
          message: 'Unknown error occurred',
        );
      }
    }
  }
  //Email verification
  //Resend Otp function

  Future<void> resendOtp() async {
    final response = await authRepo.resendOtp(email: user!.email);
    // final response = await authRepo.verifyEmail(otp: otp, email: 'alabaakinyemi09@gmail.com');

    if (response is DataSuccess) {
      final data = response.data;

      if (data['status'] == true) {
        CustomSnackbar.successSnack(data['message'] ?? 'Check your email for the verification code');

      } else {
        // backend handled inside success (if API returns 200 with status false)
        CustomSnackbar.showSnackbar(message: data['message']);
      }

    } else if (response is DataFailed) {
      final err = response.exception;

      if (err is DioException) {

        //  Network issues
        if (err.type == DioExceptionType.connectionError ||
            err.type == DioExceptionType.receiveTimeout ||
            err.type == DioExceptionType.connectionTimeout) {

          CustomSnackbar.showSnackbar(message: 'No internet connection');
          return;
        }

        //  Server error
        final errData = err.response?.data;
        // print(err.response?.data);

        if (errData != null && errData['message'] != null) {
          CustomSnackbar.showSnackbar(message: errData['message']);
        } else {
          CustomSnackbar.showSnackbar(
            message: 'Server error, try again later',
          );
        }

      } else {
        CustomSnackbar.showSnackbar(
          message: 'Unknown error occurred',
        );
      }
    }
  }//Resend Otp function
  //Transaction PIn FUnction

  Future<void> setPin({required int pin}) async {
    final response = await authRepo.setTransactPin(pin: pin);

    if (response is DataSuccess) {
      final data = response.data;

      if (data['status'] == true) {
        successMessage = data['message'] ?? 'Transaction Pin has been set successfully';
        Get.offNamed(Routes.successful, arguments: successMessage);
      } else {
        // backend handled inside success (if API returns 200 with status false)
        CustomSnackbar.showSnackbar(message: data['message']);
      }
    } else if (response is DataFailed) {
      final err = response.exception;

      if (err is DioException) {
        //  Network issues
        if (err.type == DioExceptionType.connectionError ||
            err.type == DioExceptionType.receiveTimeout ||
            err.type == DioExceptionType.connectionTimeout) {
          CustomSnackbar.showSnackbar(message: 'No internet connection');
          return;
        }

        //  Server error
        final errData = err.response?.data;
        // print(err.response?.data);

        if (errData != null && errData['message'] != null) {
          CustomSnackbar.showSnackbar(message: errData['message']);
        } else {
          CustomSnackbar.showSnackbar(
            message: 'Server error, try again later',
          );
        }
      } else {
        CustomSnackbar.showSnackbar(
          message: 'Unknown error occurred',
        );
      }
    }

}
}
