import 'package:dio/dio.dart';
import 'package:fin_wise/core/Routes/routes.dart';
import 'package:fin_wise/core/constant.dart';
import 'package:fin_wise/core/resources/data_state.dart';
import 'package:fin_wise/data/dataSource/storage_file.dart';
import 'package:fin_wise/data/models/model_export.dart';
import 'package:fin_wise/data/repositories/CategoriesRepo/education_repo.dart';
import 'package:fin_wise/utils/widgets/custom_snackbar.dart';
import 'package:fin_wise/viewModel/home_view_model.dart';
import 'package:get/get.dart';

class EducationController extends GetxController{

  final EducationRepo repo;
  final StorageFile store;
  EducationController(this.repo, this.store);

 List services = [
    'Result Checker PIN',  'School Fees Payment'
 ].obs;

 @override
  void onInit() {
    // TODO: implement onInit
   getAvailableCard();
    super.onInit();
  }

  final HomeViewModel viewModel = HomeViewModel();
 var selectServ = 'Result Checker PIN'.obs;
 var selectedProvider = ServiceProvider.glo.label.obs;
 var error = ''.obs;
 var cardError = ''.obs;
 var loadingCard = false.obs;
 var eduCards = <ExamCardModel>[].obs;

 //Available eduction card
  Future<void> getAvailableCard() async{
    loadingCard.value = true;
    eduCards.clear();
    String? token = await store.getToken();
    if(token == null) return;
    final response = await repo.getEduCard(token);

    if(response is DataSuccess){
      if(response.data['status'] == true || response.data['status'] == 1){
        final data = response.data['data'];
        print(data);
        List list = data['educations'];
        final card = list.map((e) => ExamCardModel.fromJson(e)).toList();
        eduCards.addAll(card);
      } else{
        cardError.value = 'Unable to complete transaction';
      }
    }else if(response is DataFailed){
      final err = response.exception;

      if(err is DioException){
        if(err.type == DioExceptionType.connectionError || err.type == DioExceptionType.connectionTimeout){
         cardError.value = 'Check your internet connection, try again.';
        }
        final errData = err.response?.data;
        if(errData != null && errData['message']){
          cardError.value = errData['message'];
        }else{
          cardError.value = 'Unable to load education cards, try again later';
        }
      }else{
        cardError.value = 'Unable to load education cards, try again later';
      }
    }
    loadingCard.value = false;
  }

///Buy Education card function
  Future<void> buyEduCard({
    required String transPin,
    required String phoneNumber,
    required int examId,
  }) async{
    final phone = viewModel.numberBack(phoneNumber);
     String? token = await store.getToken();
     if(token == null) return;
      final response = await repo.buyEduCard(transPin: transPin, phoneNumber: phone, examId: examId.toString(), token: token);

      if(response is DataSuccess){
        if(response.data['status'] == true || response.data['status'] == 1){
          final data = response.data['data'];
          print(data);
          TransactionModel receipt = TransactionModel.fromJson(data);
            receipt.category = Categories.education;
          if(receipt.apiStatus == TransactionStatus.completed){
            Get.toNamed(Routes.transSuccess, arguments: receipt);
          }else{
            CustomSnackbar.showSnackbar(message: 'Unable to complete transaction, try again later 1');
          }
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
          if(errData != null && errData['message'] != null){
            CustomSnackbar.showSnackbar(message: errData['message']);
          }else{
            CustomSnackbar.showSnackbar(message: 'Unable to complete transaction, try again later 2');
          }
        }else{
          CustomSnackbar.showSnackbar(message: 'Unable to complete transaction, try again later 3');
        }
      }


  }
}


