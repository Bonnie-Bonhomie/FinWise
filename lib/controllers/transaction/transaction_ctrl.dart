
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/data/dataSource/storage_file.dart';
import 'package:fin_wise/data/models/transaction_model.dart';
import 'package:fin_wise/data/repositories/transacetionRepository/transact_repo.dart';
import 'package:fin_wise/core/resources/data_state.dart';
import 'package:fin_wise/utils/widgets/custom_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../core/constant.dart';

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


  var transactions = <TransactionModel>[].obs;
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
      Get.snackbar('Oops', 'Unable to load this month transactions');
    }finally{
      loading.value = false;
    }
  }

//End


  //filtered month




  Future<void> getTransactions() async{

    final token = await storage.getToken();
    if(token == null){
     CustomSnackbar.showSnackbar(message: 'User not authourized');
      return;
    }
    final transact = await repo.getTransact(token);
    if(DataState is DataSuccess && transact.data['status'] == 'success'){

      transactions.add(transact.data);
    }
    else{
      error.value = 'Unable to load transactions history';
      GetSnackBar(title: 'Oops', message: error.value,);
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