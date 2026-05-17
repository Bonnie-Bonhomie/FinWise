import 'package:dio/dio.dart';
import 'package:fin_wise/core/constant.dart';
import 'package:fin_wise/core/resources/data_state.dart';
import 'package:fin_wise/data/dataSource/storage_file.dart';
import 'package:fin_wise/data/models/education_model.dart';
import 'package:fin_wise/data/repositories/CategoriesRepo/education_repo.dart';
import 'package:fin_wise/utils/Helpers/loader_helper.dart';
import 'package:fin_wise/utils/widgets/custom_snackbar.dart';
import 'package:get/get.dart';

class EducationController extends GetxController{

  final EducationRepo repo;
  final StorageFile store;
  EducationController(this.repo, this.store);

 List<EduModel> schools = [
   EduModel(schoolName: 'WAEC', abbrev: 'WAEC', imgPath: 'onboard-1.png', serviceName:'Result Checker Pin', amount: 3500),
   EduModel(schoolName: 'NECO', abbrev: 'NECO', imgPath: 'onboard-2.png', serviceName: 'Result Checker Pin', amount: 2500),
   EduModel(schoolName: 'JAMB', abbrev: 'JAMB', imgPath: 'onboard-1.png', serviceName: 'Registration Pin', amount: 5100),
 ];
 List services = [
    'Result Checker PIN',  'School Fees Payment'
 ].obs;

 var selectServ = 'Result Checker PIN'.obs;
 var selectedProvider = ServiceProvider.glo.label.obs;
 var error = ''.obs;


  Future<void> buyEduCard({
    required String transPin,
    required String phoneNumber,
    required String examId,
  }) async{
     String? token = await store.getToken();
     if(token == null) return;
      final response = await repo.buyEduCard(transPin: transPin, phoneNumber: phoneNumber, examId: examId, token: token);

      if(response is DataSuccess){
        if(response.data['status'] == true){
          // airtimeReceipt = result.data;
        }
        else{
          error.value = 'Unable to complete transaction';
          CustomSnackbar.showSnackbar(message: error.value, title:  'Oops');
        }
      }else if(response is DataFailed){
        final err = response.exception;

        if(err is DioException){
          if(err.type == DioExceptionType.connectionError || err.type == DioExceptionType.connectionTimeout){
            CustomSnackbar.showSnackbar(title: 'No internet connection', message: 'Unable to verify meter number, try again.');
          }
          final errData = err.response?.data;
          if(errData != null && errData['message']){
            CustomSnackbar.showSnackbar(message: errData['message']);
          }else{
            CustomSnackbar.showSnackbar(message: 'Unable to complete transcction, try again later');
          }
        }else{
          CustomSnackbar.showSnackbar(message: 'Unable to complete transaction, try again later');
        }
      }


  }
}


