
import 'package:fin_wise/core/constant.dart';
import 'package:fin_wise/data/models/transaction_model.dart';
import 'package:get/get.dart';

class AccBalanceCtrl extends GetxController{

  var accountBalance = 7777.63.obs;
  var expense = 1000.00.obs;
  var income = 4000.45.obs;
  var spendingLimit = 2000.00.obs;
  var virtualAcc = ''.obs;

  double get spentPercent => expense.value /spendingLimit.value;

  final Rx<DateTime> selectedMonth = DateTime(DateTime.now().year, DateTime.now().month).obs;

  List<TransactionModel> get monthlyTransacts {
    transactionList.sort((a, b) => a.time.compareTo(b.time));
    return transactionList.where((tx) {
      return tx.time.year == selectedMonth.value.year && tx.time.month == selectedMonth.value.month;
    }).toList();
  }

  // void changeMonth(DateTime month){
  //   selectedMonth.value = month;
  // }

  //
  //
  // Future<void> getTransactions() async{
  //   loading.value = true;
  //
  //   final token = await storage.getToken();
  //   if(token == null){
  //     Get.snackbar('Error', 'User not authorized', backgroundColor: AppColors.bgColor);
  //     return;
  //   }
  //   final transact = await repo.getTransact(token);
  //   if(DataState is DataSuccess && transact.data['status'] == 'success'){
  //
  //     transactions.add(transact.data);
  //   }
  //   else{
  //     error.value = 'Unable to load transactions history';
  //     GetSnackBar(title: 'Oops', message: error.value,);
  //   }
  // }

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