
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
    // debugPrint('Transaction Ctrl');
    // loadTransactions(selectMon.value, selectY.value);
    scrollCtrl.addListener(scrollFunction);
    super.onInit();

  }

  final ScrollController scrollCtrl = ScrollController();
  var dailyExpense = 1000.00.obs;
  var monthlyExpense = 2000.45.obs;
  var totalExpense = 2000.00.obs;
  var loading = false.obs;
  var loadMore  = false.obs;
  int page = 1;
  int currentPage = 1;
  int lastPage = 1;
  RxBool nextPage = true.obs;


  List allTransactions = [].obs;
  var transactionList = <TransactionModel>[].obs;
  var allDeposit = <DepoModel>[].obs;
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


///Get transaction per page

  Future<List<TransactionModel>> getTransactions(int page) async{
    try{

      loading.value = true;
    final token = await storage.getToken();
    if(token == null){
     CustomSnackbar.showSnackbar(message: 'User not authourized');
      return <TransactionModel>[];
    }
    final transact = await repo.getTransactPerPage(token, page);
    transactionList.clear();

    if(transact is DataSuccess){
      if(transact.data['status'] == true){
        final data = transact.data['data'];
        if(data[page -1 ]['next_page_url'] != null){
          nextPage.value = true;
        }
        // print(data[page -1 ]['to']);

        List currentPage = data[page - 1]['data'];
        List trans = currentPage;
        print(transact.data);
        final transac = trans.map<TransactionModel>((e) =>TransactionModel.fromJson(Map<String, dynamic>.from(e))).toList();

        transactionList.assignAll(transac);
        print(transactionList.length);

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
          error.value = 'No internet connection';
          return [];
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
      return [];
    }
    }catch(e){
      print(e);
      error.value = 'Something went wrong, try again later';
    }finally{
      loading.value = false;
    }
    return transactionList;
  }

///Get all Deposits
  Future<void> loadDepo() async{
    try{

      loading.value = true;
      final token = await storage.getToken();
      if(token == null){
        CustomSnackbar.showSnackbar(message: 'User not authourized');
        return;
      }
      final deposits = await repo.getDeposits(token);

      if(deposits is DataSuccess){
        if(deposits.data['status'] == true){
          final data = deposits.data['data'];



          List depos = data;

          print(deposits.data['data']);
          final deposit = depos.map<DepoModel>((e) =>DepoModel.fromJson(Map<String, dynamic>.from(e))).toList();

          allDeposit.addAll(deposit);

          if(allDeposit.isEmpty){
            error.value = 'No transaction history';
          }
        }else{
          error.value = 'Unable to load all Transactions';
        }
      }
        else if(deposits is DataFailed){
        final err = deposits.exception;
        print(err);
        if (err is DioException) {
          if (err.type == DioExceptionType.connectionError ||
              err.type == DioExceptionType.connectionTimeout) {
            error.value = 'No internet connection';
            return;
          }

          final errData = err.response!.data;
          if(errData != null && errData['message'] != null){
            error.value = errData['message'].toString();
          }
          // else{
          //   error.value = 'Something went wrong, try to reload';
          // }
        }
        else{
          error.value = 'Something went wrong, try again later';
        }
        // return;
      }
    }catch(e){
      print(e);
      error.value = 'Something went wrong, try again later';
    }finally{
      loading.value = false;
    }
  }
  Future<void> fetchMoreTran() async{

    try{
      loadMore.value = true;

      final response = await getTransactions(page + 1);
      allTransactions.add(response);
    }catch(e){
      print(e);
      CustomSnackbar.showSnackbar(message: 'Something went wrong');
    }finally{
      loadMore.value = false;
    }
  }

  bool get hasMore => currentPage < lastPage;
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

  Future<void> scrollFunction() async {
    if(scrollCtrl.position.pixels >= scrollCtrl.position.maxScrollExtent){
          loadMore.value = true;
          print(loadMore.value);
    }else{
      print('Hello');
    }
  }


}