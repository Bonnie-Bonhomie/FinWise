import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/data/dataSource/storage_file.dart';
import 'package:fin_wise/data/repositories/profileRepo/change_pin_repository.dart';
import 'package:fin_wise/core/resources/data_state.dart';
import 'package:get/get.dart';

class ChangePinCtrl extends GetxController {

  final ChangePinRepo repo;
  final StorageFile storage;

  ChangePinCtrl(this.repo, this.storage);

  var loading = false.obs;
  var error = ''.obs;

  Future<void> changePin({
    required String currentPin,
    required String newPin,
    required String confirmPin
  }) async {
    loading.value = true;
    final token = await storage.getToken();

    if (token == null) {
      Get.snackbar('Error', 'User not authorized');
      return;
    }
    try {
      final result = await repo.changePin(currentPin: currentPin,
          newPin: newPin,
          confirmPin: confirmPin,
          token: token);

      if(DataState is DataSuccess && result.data['status'] == 'Success');
      else{
        error.value ='Unable to Change Pin';
        Get.snackbar('Oops', error.value, backgroundColor: AppColors.bgColor);
      }
    }catch(e){
      print(e);
    }
    loading.value = false;
  }

}