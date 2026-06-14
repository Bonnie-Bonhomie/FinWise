import 'package:dio/dio.dart';
import 'package:fin_wise/core/Routes/routes.dart';
import 'package:fin_wise/core/resources/data_state.dart';
import 'package:fin_wise/core/resources/storage_keys.dart';
import 'package:fin_wise/data/dataSource/storage_file.dart';
import 'package:fin_wise/data/repositories/profileRepo/delete_acc_repo.dart';
import 'package:fin_wise/utils/Helpers/share_prefer_services.dart';
import 'package:fin_wise/utils/widgets/custom_snackbar.dart';
import 'package:get/get.dart';

class DeleteCtrl extends GetxController{

  final DeleteAccRepo repo;
  final StorageFile store;
  final SharedPreferService shareStore;

  DeleteCtrl(this.repo, this.store, this.shareStore);

  Future<void> deleteAccount() async {
    try{
      final String? token = await store.getToken();
      print('Token: $token');
      if (token == null) {
        CustomSnackbar.showSnackbar(message: 'Something went wrong');
      } else {
        final response = await repo.deleteAccount(token);
        if(response is DataSuccess){
          if(response.data['status'] == true){
            await store.deleteToken();
            await shareStore.deleteValue(PrefStoreKeys.mail);
            await shareStore.deleteValue(PrefStoreKeys.username);
            await shareStore.deleteValue(PrefStoreKeys.userId);
            Get.offAllNamed(Routes.login);
          }

        }else if(response is DataFailed){

          final err = response.exception;

          if(err is DioException){
            if(err.type == DioExceptionType.connectionError ||
                err.type == DioExceptionType.receiveTimeout ||
                err.type == DioExceptionType.connectionTimeout ){
              CustomSnackbar.showSnackbar(message: 'Check your internet connection', title: 'No network');
            }
            final errData = err.response?.data;

            if(errData != null && errData['message'] != null){
              CustomSnackbar.showSnackbar(message: errData['message'].toString());
            }
          }
        }

      }}catch(e){
      CustomSnackbar.showSnackbar(message: 'Something went wrong try again later', title: 'Oops');
    }
  } //Logout


}