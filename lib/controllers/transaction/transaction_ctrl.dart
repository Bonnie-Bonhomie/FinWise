
import 'package:dio/dio.dart';
import 'package:fin_wise/data/dataSource/storage_file.dart';
import 'package:fin_wise/data/models/transaction_model.dart';
import 'package:fin_wise/data/repositories/transacetionRepository/transact_repo.dart';
import 'package:fin_wise/core/resources/data_state.dart';
import 'package:fin_wise/utils/widgets/custom_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class TransactionCtrl extends GetxController{

  final TransactionRepo repo;
  final StorageFile storage;
  TransactionCtrl(this.repo, this.storage);

  @override
  void onInit() {
    // TODO: implement onInit
    debugPrint('Transaction Ctrl');
    loadTransactions(selectMon.value, selectY.value);
    super.onInit();

  }

  var dailyExpense = 1000.00.obs;
  var monthlyExpense = 2000.45.obs;
  var totalExpense = 2000.00.obs;
  var loading = false.obs;
  int page = 1;
  RxBool nextPage = true.obs;


  List allTransactions = [].obs;
  var transactionList = <TransactionModel>[].obs;
  var error = ''.obs;


//Start
  var transacts = <TransactionModel> [].obs;

  RxInt selectMon = DateTime.now().month.obs;
  RxInt selectY =  DateTime.now().year.obs;

  Map<String, List<TransactionModel>> montCache = {};

  Future<void> loadTransactions(int month, int year) async{
    String key = '$month-$year';

    selectMon.value = month;
    selectY.value = year;
    if(montCache.containsKey(key)){
      transacts.value = montCache[key]!;
      update();
      return;
    }
    try{
      loading.value = true;
      // final result = awaiy repo.getTransactions(month, year);
      // montCache[key] = result;
      // transacts = result;
    }catch(e){
      print(e);
      Get.snackbar('Oops', 'Unable to load this month transactions');
    }finally{
      loading.value = false;
    }
  }

//End


  //filtered month




  Future<void> getTransactions(int page) async{
    try{

      loading.value = true;
    final token = await storage.getToken();
    if(token == null){
     CustomSnackbar.showSnackbar(message: 'User not authourized');
      return;
    }
    final transact = await repo.getTransact(token, page);
    // print(transact.data);
    if(transact is DataSuccess){
      if(transact.data['status'] == true){

        // if(transact.data['data']['next_page_url'] != null){
        //   nextPage.value = true;
        // }
        final data = transact.data['data'];
        List currentPage = data[page - 1]['data'];
        List trans = currentPage;

        // print((currentPage[0]));
        final transac = trans.map<TransactionModel>((e) =>TransactionModel.fromJson(Map<String, dynamic>.from(e))).toList();

        transactionList.addAll(transac);
        allTransactions.add(transactionList);
        if(transactionList.isEmpty){
          error.value = 'No transaction history';
        }
      }else{
        error.value = 'Unable to load all Transactions';
      }
    }else if(transact is DataFailed){
      final err = transact.exception;
      print(err);
      if (err is DioException) {
        if (err.type == DioExceptionType.connectionError ||
            err.type == DioExceptionType.connectionTimeout) {
          CustomSnackbar.showSnackbar(
            title: 'No internet connection',
            message: 'Check your internet connection',
          );
        }

        final errData = err.response!.data;
        if(errData != null && errData['message'] != null){
          error.value = errData['message'].toString();
        }else{
          error.value = 'Something went wrong, try to reload';
        }
      }else{
        error.value = 'Something went wrong, try again later';
      }

    }
    }catch(e){
      print(e);
      error.value = 'Something went wrong, try again later';
    }finally{
      loading.value = false;
    }
  }



  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];


}