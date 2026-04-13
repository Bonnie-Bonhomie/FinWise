import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/data/dataSource/storage_file.dart';
import 'package:fin_wise/data/repositories/profileRepo/change_pwd_repo.dart';
import 'package:fin_wise/core/resources/data_state.dart';
import 'package:get/get.dart';

class ChangePwdControl extends GetxController {

  final ChangePwdRepo repo;
  final StorageFile storage;

  ChangePwdControl(this.repo, this.storage);

  var currentObscure = true.obs;
  var pwdObscure = true.obs;
  var confirmPwdObscure = true.obs;
  var loading = false.obs;
  var error = ''.obs;


  void setObscure(obscure) {
    obscure = !obscure;
  }

  Future<void> changePwd({
    required String currentPwd,
    required String newPwd,
    required String confirmPwd
  }) async {
    loading.value = true;
    final token = await storage.getToken();

    if(token == null){
      Get.snackbar('Error', 'User not authenticated');
      return;
    }
    try {
      final response = await repo.submitPwd(
        token: token,
          currentPwd: currentPwd, newPwd: newPwd, confirmPwd: confirmPwd);

      if(DataState is DataSuccess && response.data['status'] == 'Success'){
        error.value = '';
      }
      else{
        error.value = 'Unable to change Password';
        Get.snackbar('Oops', error.value, backgroundColor: AppColors.bgColor);
      }
    }catch(e){
      print(e);
    }
    loading.value = false;
  }
}