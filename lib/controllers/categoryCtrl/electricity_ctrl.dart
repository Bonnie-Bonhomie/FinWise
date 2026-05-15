import 'package:dio/dio.dart';
import 'package:fin_wise/core/resources/data_state.dart';
import 'package:fin_wise/data/dataSource/storage_file.dart';
import 'package:fin_wise/data/models/electric_model.dart';
import 'package:fin_wise/data/repositories/CategoriesRepo/electricity_repo.dart';
import 'package:fin_wise/utils/widgets/custom_snackbar.dart';
import 'package:get/get.dart';

class ElectricityCtrl  extends GetxController{

  final ElectricityRepo repo;
  final StorageFile store;
  ElectricityCtrl(this.repo, this.store);

  var selectedElect = Rxn<ElectModel>();
  var electDiscos = <ElectDisco>[].obs;
  var availableAmount = <ElectAmount>[].obs;

  var error = ''.obs;
  RxBool verifyLoad = false.obs;
  RxBool discoLoad = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit

    getElectricDiscos();
    super.onInit();
  }

  var availableElect = [
    ElectModel(name: 'Ikeja Electricity', abbrev: 'Ikeja'),
    ElectModel(name: 'IBEDC', abbrev: 'IBEDC'),
  ];

  void updateElect(ElectModel model){
    selectedElect.value = model;
  }

  /// Buy electricity function
  Future<void> buyElectric({required String amount, required String meterNum, required String type, required String transPin, required String serviceId}) async{

      final String? token = await store.getToken();
      if(token == null) return;
      final result = await repo.buyElect(amount: amount, meterNum: meterNum, token: token, type: type, transPin: transPin, serviceId: serviceId);

      if(result is DataSuccess){
        if(result.data['status'] ==  true){
          /// To do
        }
        else{
          error.value = 'Unable to complete transaction';
          CustomSnackbar.showSnackbar(message: error.value, title:  'Oops');
        }
      }else if(result is DataFailed){
         final err =result.exception;
         if(err is DioException){

           if(err.type ==DioExceptionType.connectionError || err.type == DioExceptionType.connectionTimeout){
             CustomSnackbar.showSnackbar(message: 'Check your internet connection, try again later', title: 'No internet');           }

           final errData = err.response?.data;
           if(errData != null && errData['message'] != null){
             CustomSnackbar.showSnackbar(message: errData['message']);
           }else{
             CustomSnackbar.showSnackbar(message: 'Unable to complete transaction, try again later');
           }
         }
      }

  }

  /// verify meter number
  Future<void> verifyMeter({required String meterNum, required String type, required String serviceId}) async{

    verifyLoad.value = true;
    final String? token = await store.getToken();
    if(token == null) return;
    final result = await repo.verifyMeter(meterNum: meterNum, token: token, type: type, serviceId: serviceId);

    if(result is DataSuccess){
      if(result.data['status'] ==  true){
        // airtimeReceipt = result.data;
      }
      else{
        error.value = 'Unable to complete transaction';
        CustomSnackbar.showSnackbar(message: error.value, title:  'Oops');
      }}
    else if(result is DataFailed){
      final err =result.exception;
      if(err is DioException){

        if(err.type ==DioExceptionType.connectionError || err.type == DioExceptionType.connectionTimeout){
          CustomSnackbar.showSnackbar(message: 'Check your internet connection, try again later', title: 'No internet');
        }

        final errData = err.response?.data;
        if(errData != null && errData['message'] != null){
          CustomSnackbar.showSnackbar(message: errData['message']);
        }else{
          CustomSnackbar.showSnackbar(message: 'Unable to complete transaction, try again later');
        }
      }
    }
    verifyLoad.value = false;
  }

  /// Load all available electricity Discos
  Future<void> getElectricDiscos() async{

    final String? token = await store.getToken();
    if(token == null) return;
    final result = await repo.electDiscos(token);

    if(result is DataSuccess){
      if(result.data['status'] ==  true){
        /// To do
        final data = result.data['data'];
        List elect = data['electricity'];

        final disco = elect.map((e)=> ElectDisco.fromJson(e)).toList();
        electDiscos.addAll(disco);
          print(electDiscos);
        ///Collect all the available amount
        List suggestAmount = data['suggested_amounts'];
        final amt = suggestAmount.map((e)=> ElectAmount.fromJson(e)).toList();
        availableAmount.addAll(amt);
      }
      else{
        error.value = 'Unable to complete transaction';
        CustomSnackbar.showSnackbar(message: error.value, title:  'Oops');
      }}
    else if(result is DataFailed){
      final err =result.exception;
      if(err is DioException){

        if(err.type ==DioExceptionType.connectionError || err.type == DioExceptionType.connectionTimeout){
          CustomSnackbar.showSnackbar(message: 'Check your internet connection, try again later', title: 'No internet');        }

        final errData = err.response?.data;
        if(errData != null && errData['message'] != null){
          CustomSnackbar.showSnackbar(message: errData['message']);
        }else{
          CustomSnackbar.showSnackbar(message: 'Unable to complete transaction, try again later');
        }
      }
    }

  }

}
