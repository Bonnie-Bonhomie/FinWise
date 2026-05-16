
import 'package:dio/dio.dart';
import 'package:fin_wise/core/constant.dart';
import 'package:fin_wise/core/resources/data_state.dart';
import 'package:fin_wise/data/dataSource/storage_file.dart';
import 'package:fin_wise/data/models/numbers_model.dart';
import 'package:fin_wise/data/repositories/CategoriesRepo/airtime_repo.dart';
import 'package:fin_wise/utils/widgets/custom_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AirtimeCtrl extends GetxController {
  final AirtimeRepository repo;
  final StorageFile store;

  AirtimeCtrl(this.repo, this.store);
  @override
  void onInit() {
    // TODO: implement onInit
    getNetworks();
    super.onInit();
  }

  var selected = 1.obs;
  var amountCtrl = TextEditingController().obs;
  var allNumbers = [08030039725, 09052378291].obs;
  var airtimeBenes = <NumbersModel>[NumbersModel(provider: ServiceProvider.mtn, number: '09067567878', amount: 200)].obs;
  var airtimeNet = <NetworksModel>[].obs;

  var cleared = false.obs;

  var error = ''.obs;


  Future<void> buyAirtime({required String amount, required int number, required String netId, required String pin}) async {
    final String? token = await store.getToken();
    if(token == null)return;
    final result = await repo.buyAirtime(amount: amount, number: number, token: token, networkId: netId, transPin: pin);
    if (result is DataSuccess) {
      final data = result.data;
      if (data['status'] == true) {
       AirtimeApiModel airtimeReceipt = result.data['data'];

      } else {
        error.value = 'Unable to complete transaction';
        CustomSnackbar.showSnackbar(message: error.value, title: 'Oops');
      }
    } else if (result is DataFailed) {
      final err = result.exception;
      if (err is DioException) {
        if (err.type == DioExceptionType.connectionError || err.type == DioExceptionType.connectionTimeout) {
          CustomSnackbar.showSnackbar(title: 'No internet connection', message: 'Check your internet connection');
        }
        final errData = err.response?.data;
        if (errData != null && errData['message'] != null) {
          CustomSnackbar.showSnackbar(message: errData['message']);
        } else {
          CustomSnackbar.showSnackbar(message: 'Server error, try again later');
        }
        CustomSnackbar.showSnackbar(message: 'Server error, try again later');
      }
    }
  }

  Future<void> getNetworks() async {
    final String? token = await store.getToken();
    if(token == null)return;
    final result = await repo.airtimeNetwork(token);
    if (result is DataSuccess) {
      final data = result.data;
      if (data['status'] == true) {

        //To solve JsArray<dynamic> error
        //1. Save the data from the response in a list
        List netw = data['data']['networks'];
        //2. Loop through the list
        final netwok = netw.map((e)=> NetworksModel.fromJson(e)).toList();

        //3. Then add the list in your own list
        airtimeNet.addAll(netwok);
        // selected.value = airtimeNet[0];
        print(airtimeNet);
      } else { return;}
    } else if (result is DataFailed) {
      final err = result.exception;
      if(err is DioException){
        if(err.type == DioExceptionType.connectionError || err.type == DioExceptionType.connectionTimeout){
          CustomSnackbar.showSnackbar(title: 'No internet connection', message: 'Check your internet connection');

        }
      }
    }
  }
}
