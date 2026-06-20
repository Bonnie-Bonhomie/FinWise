import 'package:dio/dio.dart';
import 'package:fin_wise/core/Routes/routes.dart';
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/data/dataSource/storage_file.dart';
import 'package:fin_wise/data/repositories/profileRepo/change_pwd_repo.dart';
import 'package:fin_wise/core/resources/data_state.dart';
import 'package:fin_wise/utils/utils_export.dart';
import 'package:get/get.dart';

import '../controller_exports.dart';

class ChangePwdControl extends GetxController {

  final ChangePwdRepo repo;
  final StorageFile storage;

  ChangePwdControl(this.repo, this.storage);

  var currentObscure = true.obs;
  var pwdObscure = true.obs;
  var confirmPwdObscure = true.obs;
  var loading = false.obs;
  var successMessage = ''.obs;
  var error = ''.obs;


  void setObscure(obscure) {
    obscure = !obscure;
  }

  Future<void> changePwd({
    required String currentPwd,
    required String newPwd,
    required String confirmPwd
  }) async {

    try {
      loading.value = true;
      final token = await storage.getToken();

      if(token == null){
        CustomSnackbar.showSnackbar(message: 'Unauthenticated');
        return;
      }
      final response = await repo.changePwd(
        token: token,
          currentPwd: currentPwd, newPwd: newPwd, confirmPwd: confirmPwd);

      if(response is DataSuccess ){
        if(response.data['status'] == true){
          // final data = response.data['data'];
          successMessage =
              response.data['message'] ?? 'Password has been changed successfully';
          Get.find<ProfileMainControl>().back();
          Get.toNamed(Routes.successful, arguments: successMessage);
        }
      }
      else if (response is DataFailed) {
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
    }catch(e){
      print(e);
    }
    loading.value = false;
  }
}