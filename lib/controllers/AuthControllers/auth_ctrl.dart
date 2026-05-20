import 'package:dio/dio.dart';
import 'package:fin_wise/Services/biometric_serv.dart';
import 'package:fin_wise/controllers/loader_contrl.dart';
import 'package:fin_wise/core/resources/storage_keys.dart';
import 'package:fin_wise/data/dataSource/storage_file.dart';
import 'package:fin_wise/data/models/model_export.dart';
import 'package:fin_wise/data/repositories/AuthRepo/auth_repo.dart';
import 'package:fin_wise/utils/Helpers/share_prefer_services.dart';
import 'package:fin_wise/utils/widgets/widget.dart';
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
    getEmail();
    super.onInit();
  }

  RxBool loading = false.obs;
  ProfileModel? user;
  WalletModel? userWallet;
  String? err;
  String? successMessage;
  String? forgetMail;
  int? verifyToken;
  RxString email = ''.obs;
  RxString name = ''.obs;
  RxString signMail = ''.obs;

  Future<void> getEmail() async {
    email.value = await store.retrieve(PrefStoreKeys.mail);
    name.value = await store.retrieve(PrefStoreKeys.username);
  }

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
    // print(response);
    // final token = response.data['token'];
    // await storage.saveToken(token);

    if (response is DataSuccess) {
      final data = response.data;

      if (data['status'] == true) {
        user = ProfileModel.fromJson(data['data']);

        final name = user!.name;
        final mail = user!.email;
        await store.saveData<String>(PrefStoreKeys.username, name);
        await store.saveData<String>(PrefStoreKeys.mail, mail);
        signMail.value = user!.email;
        CustomSnackbar.successSnack(data['message']);
        Get.offNamed(Routes.verAcc);
      } else {
        //  backend handled inside success (if API returns 200 with status false)
        CustomSnackbar.showSnackbar(message: data['message']);
      }
    } else if (response is DataFailed) {
      final err = response.exception;

      if (err is DioException) {
        //  Network issues
        if (err.type == DioExceptionType.connectionError || err.type == DioExceptionType.connectionTimeout) {
          CustomSnackbar.showSnackbar(title: 'No internet connection', message: 'Check your internet connection');
          return;
        }

        //  Server error
        final errData = err.response?.data;
        // print(err.response?.data);

        if (errData != null && errData['message'] != null) {
          CustomSnackbar.showSnackbar(message: errData['message']);
        } else {
          CustomSnackbar.showSnackbar(message: err.response.toString());
        }
      } else {
        CustomSnackbar.showSnackbar(message: 'Unknown error occurred');
      }
    }

    LoaderController.to.hide();
  } //Register user Function

  Future<void> loginUser(String mail, String password) async {
    final response = await authRepo.loginUser(email: mail, password: password);

    print(response.data);
    if (response is DataSuccess) {
      final data = response.data;

      if (data['status'] == true) {
        final token = data['data']['token'];
        await storage.saveToken(token);
        final name = data['data']['name'];
        final mail = data['data']['email'];
        final phone = data['data']['phone'];
        await store.saveData<String>(PrefStoreKeys.username, name);
        await store.saveData<String>(PrefStoreKeys.mail, mail);
        await store.saveData<String>(PrefStoreKeys.phone, phone);

        userWallet = WalletModel.fromJson(data['data']['wallet']);
        // user = UserModel.fromJson(response.data);
        CustomSnackbar.successSnack(data['message'].toString());

        Get.offAllNamed(Routes.mainS);
      } else {
        CustomSnackbar.showSnackbar(
          message: 'Something went wrong. Try again later.',
        );
      }
    } else if (response is DataFailed) {
      final err = response.exception;
      print(err.toString());
      // Network error
      if (err is DioException) {
        if (err.type == DioExceptionType.connectionError|| err.type == DioExceptionType.connectionTimeout) {
          CustomSnackbar.showSnackbar(title: 'No internet connection', message: 'Check your internet connection');
        }
        //   //Server error
        else if (err.response != null) {
          final errData = err.response?.data;
          print(errData.toString());
          if (errData != null && errData['message'] != null) {
            CustomSnackbar.showSnackbar(message: errData['message'] ?? "Error");
          } else {
            CustomSnackbar.showSnackbar(
              message:
                  err.response?.data ?? 'Something went wrong, try again later',
            );
          }
        }
      }
    } else {
      CustomSnackbar.showSnackbar(
        message: 'Unknown error occur, try again later',
      );
      // }
    }
  } // Login function

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
  } //LOginWIth Finger print

  //Email verification
  Future<void> verifyEmail({
    required BuildContext context,
    required int otp,
  })
  async {
    final response = await authRepo.verifyEmail(otp: otp, email: user!.email);
    print(response.data);
    if (response is DataSuccess) {
      final data = response.data;

      if (data['status'] == true) {
        final token = response.data['data']['token'];
        if (token != null) {
          await storage.saveToken(token);
        }

        await store.saveData<String>(PrefStoreKeys.mail, user!.email);
        await store.saveData<String>(PrefStoreKeys.username, user!.name);
        showCustomDiag(context);
        print('Done');
      } else {
        // backend handled inside success (if API returns 200 with status false)
        CustomSnackbar.showSnackbar(
          message: data['message'] ?? 'This is the error',
        );
      }
    } else if (response is DataFailed) {
      final err = response.exception;

      if (err is DioException) {
        //  Network issues
        if (err.type == DioExceptionType.connectionError || err.type == DioExceptionType.connectionTimeout) {
          CustomSnackbar.showSnackbar(title: 'No internet connection', message: 'Check your internet connection');
          return;
        }

        //  Server error
        final errData = err.response?.data;
        // print(err.response?.data);

        if (errData != null && errData['message'] != null) {
          CustomSnackbar.showSnackbar(message: errData['message']);
        } else {
          CustomSnackbar.showSnackbar(message: 'Server error, try again later');
        }
      } else {
        CustomSnackbar.showSnackbar(message: 'Unknown error occurred');
      }
    }
  } //Email verification

  //Resend Otp function
  Future<void> resendOtp() async {
    final String mail = await store.retrieve(PrefStoreKeys.mail);
    if (mail.isNotEmpty) {
      final response = await authRepo.resendOtp(email: mail.toString());

      if (response is DataSuccess) {
        final data = response.data;

        if (data['status'] == true) {
          CustomSnackbar.successSnack(
            data['message'] ?? 'Check your email for the verification code',
          );
        } else {
          // backend handled inside success (if API returns 200 with status false)
          CustomSnackbar.showSnackbar(message: data['message']);
        }
      } else if (response is DataFailed) {
        final err = response.exception;

        print(err.toString());
        if (err is DioException) {
          //  Network issues
          if (err.type == DioExceptionType.connectionError || err.type == DioExceptionType.connectionTimeout) {
            CustomSnackbar.showSnackbar(title: 'No internet connection', message: 'Check your internet connection');
            return;
          }

          //  Server error
          final errData = err.response?.data;
          print(response);

          if (errData != null && errData['message'] != null) {
            print(errData['message']);
            CustomSnackbar.showSnackbar(message: errData['message'].toString());
          } else {
            CustomSnackbar.showSnackbar(
              message: 'Server error, try again later',
            );
          }
        } else {
          CustomSnackbar.showSnackbar(message: 'Unknown error occurred');
        }
      }
    }
  } //Resend Otp function

  //Transaction PIn FUnction
  Future<void> setPin({
    required int oldPin,
    required int newPin,
    required int cfmPin,
  })
  async {
    final String? token = await storage.getToken();
    if (token == null) {
      CustomSnackbar.showSnackbar(message: 'You are unauthorized to set pin');
    } else {
      final response = await authRepo.setTransactPin(
        oldPin: oldPin,
        newPin: newPin,
        cfmPin: cfmPin,
        token: token,
      );

      print(response.data);
      if (response is DataSuccess) {
        final data = response.data;

        if (data['status'] == true) {
          successMessage =
              data['message'] ?? 'Transaction Pin has been set successfully';
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
            CustomSnackbar.showSnackbar(title: 'No internet connection', message: 'Check your internet connection');
            return;
          }

          //  Server error
          final errData = err.response?.data;

          if (errData != null && errData['message'] != null) {
            CustomSnackbar.showSnackbar(message: errData['message']);
          } else {
            CustomSnackbar.showSnackbar(
              message: 'Server error, try again later',
            );
          }
        } else {
          CustomSnackbar.showSnackbar(message: 'Unknown error occurred');
        }
      }
    }
  } //Transaction PIn FUnction

  //LogOut function
  Future<void> logOut() async {
    final String? token = await storage.getToken();
    print('Token: $token');
    if (token == null) {
      CustomSnackbar.showSnackbar(message: 'Something went wrong');
    } else {
      final response = await authRepo.logOut(token);
      if(response == 'Log out successfully'){
        storage.deleteToken();
        Get.offAllNamed(Routes.login);
      }else{
        CustomSnackbar.showSnackbar(message: response);
      }

    }
  } //Logout

  Future<void> forgetPwd(String email) async {
    final response = await authRepo.forgetPwd(email: email);
    forgetMail = email;
    if (response is DataSuccess) {
      final data = response.data;

      if (data['status'] == true) {
        CustomSnackbar.successSnack(data['message']);
        Get.toNamed(Routes.otp);
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
          CustomSnackbar.showSnackbar(title: 'No internet connection', message: 'Check your internet connection');
          return;
        }

        //  Server error
        final errData = err.response?.data;
        // print(err.response?.data);

        if (errData != null && errData['message'] != null) {
          CustomSnackbar.showSnackbar(message: errData['message']);
        } else {
          CustomSnackbar.showSnackbar(message: 'Server error, try again later');
        }
      } else {
        CustomSnackbar.showSnackbar(message: 'Unknown error occurred');
      }
    }
  } //Forget password, email for recovery function

  Future<void> verifyPwd(int token) async {
    if (forgetMail!.isEmpty) {
      CustomSnackbar.showSnackbar(
        message: 'Go back and re enter your email address',
      );
    }
    final response = await authRepo.verifyPwd(email: forgetMail!, token: token);
    verifyToken = token;
    if (response is DataSuccess) {
      final data = response.data;

      print(data);
      if (data['status'] == true) {
        Get.offNamed(Routes.reset);
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
          CustomSnackbar.showSnackbar(title: 'No internet connection', message: 'Check your internet connection');
          return;
        }

        //  Server error
        final errData = err.response?.data;
        // print(err.response?.data);

        if (errData != null && errData['message'] != null) {
          CustomSnackbar.showSnackbar(message: errData['message']);
        } else {
          CustomSnackbar.showSnackbar(message: 'Server error, try again later');
        }
      } else {
        CustomSnackbar.showSnackbar(message: 'Unknown error occurred');
      }
    }
  }

  Future<void> updatePwd({required String newPwd}) async {
    final response = await authRepo.updatePwd(
      email: forgetMail!,
      token: verifyToken!,
      pwd: newPwd,
    );

    if (response is DataSuccess) {
      final data = response.data;

      if (data['status'] == true) {
        CustomSnackbar.successSnack(
          data['message'] ?? 'Password has been changed successfully',
        );
        Get.offNamed(Routes.login);
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
          CustomSnackbar.showSnackbar(title: 'No internet connection', message: 'Check your internet connection');
          return;
        }

        //  Server error
        final errData = err.response?.data;
        // print(err.response?.data);

        if (errData != null && errData['message'] != null) {
          CustomSnackbar.showSnackbar(message: errData['message']);
        } else {
          CustomSnackbar.showSnackbar(message: 'Server error, try again later');
        }
      } else {
        CustomSnackbar.showSnackbar(message: 'Unknown error occurred');
      }
    }
  }
}
