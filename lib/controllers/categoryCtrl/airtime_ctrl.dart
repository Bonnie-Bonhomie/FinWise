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

  var selected = ServiceProvider.glo.obs;
  var amountCtrl = TextEditingController().obs;
  var allNumbers = [08030039725, 09052378291].obs;
  var airtimeBenes = [].obs;
  var airtimeNet = <NetworksModel>[].obs;

  var cleared = false.obs;
  var airtimeReceipt = [];
  var error = ''.obs;

  Future<void> buyAirtime({required double amount, required int number}) async {
    final result = await repo.buyAirtime(amount: amount, number: number);
    if (result is DataSuccess) {
      final data = result.data;
      if (data['status'] == true) {
        airtimeReceipt = result.data;
      } else {
        error.value = 'Unable to complete transaction';
        CustomSnackbar.showSnackbar(message: error.value, title: 'Oops');
      }
    } else if (result is DataFailed) {
      final err = result.exception;
      if (err is DioException) {
        if (err.type == DioExceptionType.connectionError) {
          CustomSnackbar.showSnackbar(message: 'No internet connection');
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
        airtimeNet.value = result.data['networks'] as List<NetworksModel>;
      } else {

        CustomSnackbar.showSnackbar(message: 'Unable to load networks', title: 'Oops');
      }
    } else if (result is DataFailed) {
      final err = result.exception;
      if (err is DioException) {
        if (err.type == DioExceptionType.connectionError) {
          CustomSnackbar.showSnackbar(message: 'No internet connection');
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
}
