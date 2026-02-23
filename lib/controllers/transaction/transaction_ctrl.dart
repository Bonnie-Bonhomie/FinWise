
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/data/dataSource/storage_file.dart';
import 'package:fin_wise/data/models/transaction_model.dart';
import 'package:fin_wise/data/repositories/transacetionRepository/transact_repo.dart';
import 'package:fin_wise/data_state.dart';
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
    // loadTransactions(selectMon, selectY);
    super.onInit();

    Future.microtask(() => monthlyTransacts);
  }

  var dailyExpense = 1000.00.obs;
  var monthlyExpense = 2000.45.obs;
  var totalExpense = 2000.00.obs;



  var transactions = <TransactionModel>[].obs;
  var loading = false.obs;
  var error = ''.obs;

  List<TransactionModel>  transacts = [];
  bool isLoading = false;

  int selectMon = DateTime.now().month;
  int selectY =  DateTime.now().year;

  Map<String, List<TransactionModel>> montCache = {};

  Future<void> loadTransactions(int month, int year) async{
    String key = '$month-$year';

    selectMon = month;
    selectY = year;
    if(montCache.containsKey(key)){
      transacts = montCache[key]!;
      update();
      return;
    }
    try{
      isLoading = true;
      update();

      // final result = awaiy repo.getTransactions(month, year);
      // montCache[key] = result;
      // transacts = result;
    }catch(e){
      Get.snackbar('Oops', 'Unable to load this month transactions');
    }finally{
      isLoading = false;
      update();
    }
  }



  final Rx<DateTime> selectedMonth = DateTime(DateTime.now().year, DateTime.now().month).obs;

  //filtered month
  List<TransactionModel> get monthlyTransacts {
    transactionList.sort((a, b) => a.time.compareTo(b.time));
    return transactionList.where((tx) {
      return tx.time.year == selectedMonth.value.year && tx.time.month == selectedMonth.value.month;
    }).toList();
  }

  void changeMonth(DateTime month){
    selectedMonth.value = month;
  }



  Future<void> getTransactions() async{
    loading.value = true;

    final token = await storage.getToken();
    if(token == null){
      Get.snackbar('Error', 'User not authorized', backgroundColor: AppColors.bgColor);
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

  final List<TransactionModel> transactionList = [
    TransactionModel(
      id: '1',
      title: 'Airtime',
      time: DateTime(2026,2, 24, 10, 00),
      category: Categories.airtime,
      amount: 2000,
      isIncome: false,
    ),
    TransactionModel(
      id: '2',
      title: 'Data Subscription',
      time: DateTime(2026, 2,23,2,00),
      category: Categories.data,
      amount: 2000,
      isIncome: true,
    ),
    TransactionModel(
      id: '3',
      title: 'Gift Card',
      time: DateTime(2026, 2, 4,9,10),
      category: Categories.gift,
      amount: 2000,
      isIncome: false,
    ),
    TransactionModel(
      id: '4',
      title: 'Television Subscription',
      time: DateTime.now(),
      category: Categories.cable,
      amount: 200,
      isIncome: false,
    ),
    TransactionModel(
      id: '5',
      title: 'Invitation ',
      time: DateTime.now(),
      category: Categories.invitation,
      amount: 200,
      isIncome: false,
    ),
    TransactionModel(
      id: '6',
      title: 'E-pin purchase',
      time: DateTime(2025, 5,8,9,30),
      category: Categories.education,
      amount: 2000,
      isIncome: false,
    ),
  ].obs;
}