import 'package:dio/dio.dart';
import 'package:fin_wise/core/resources/data_state.dart';
import 'package:fin_wise/data/dataSource/storage_file.dart';
import 'package:fin_wise/data/repositories/accountRepo/virtual_repo.dart';
import 'package:fin_wise/utils/widgets/custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';

import '../controller_exports.dart';

class AccBalanceCtrl extends GetxController {
  final AccountRepo repo;
  final StorageFile storage;


  AccBalanceCtrl(this.repo, this.storage);

    @override
  void onInit() {
    // TODO: implement onInit
    //   getBalance();
    super.onInit();
  }

  final AuthCtrl auth = Get.find<AuthCtrl>();

  var accountBalance =  0.00.obs;
  var dailyExpense = 0.00.obs;
  var monthlyExpense = 0.00.obs;
  var bonusBal = 0.00.obs;
  var totalExpense = 0.00.obs;
  var expense = 1000.00.obs;
  var income = 4000.45.obs;
  var spendingLimit = 2000.00.obs;
  var virtualAcc = ''.obs;
  var selectPay = ''.obs;
  var filled = false.obs;
  var name = ''.obs;
  RxBool loading = false.obs;
  RxBool loadingB = false.obs;
  var balanceErr = ''.obs;

  double get spentPercent => expense.value / spendingLimit.value;

  void fillVirtualAcc(String accNumber) {
    virtualAcc.value = accNumber.toString();
  }

  void fillBalance() {
    accountBalance.value = double.parse(auth.userWallet?.accBalance ?? '0.00');
  }

  Future<void> getBonusBal() async{

    try{
      loadingB.value = true;
      final String? token = await storage.getToken();

      if(token == null){
        CustomSnackbar.warningSnack('Unauthenticated');

      }else{
        final response = await repo.getWallet(token);
        if(response is DataSuccess){
          if(response.data['status'] == true){
            final data = response.data['data'];
            bonusBal.value = data['referralAmount'];
            dailyExpense.value = data['daily_spent'];
            monthlyExpense.value = data['total_spent_amount_with_monthly'];
            totalExpense.value = data['total_spent_amount'];

          }
        }else if(response is DataFailed){
          final err = response.exception;

          if (err is DioException) {
            //  Network issues
            if (err.type == DioExceptionType.connectionError) {
              CustomSnackbar.showSnackbar(message: 'No internet connection, when loading bonus');
              return;
            }

            //  Server error
            final errData = err.response?.data;
            // print(err.response?.data);

            if (errData != null && errData['message'] != null) {
              CustomSnackbar.showSnackbar(message: errData['message']);
            } else {
              CustomSnackbar.showSnackbar(
                  message: 'Server error, Unable to load bonus');
            }
          } else {
            CustomSnackbar.showSnackbar(message: 'Unknown error occurred, Unable to load bonus');
          }
        }
      }
      }catch(e){
      print(e);
      CustomSnackbar.showSnackbar(message: 'Something went wrong, Unable to load bonus');
    }finally{
      loadingB.value = false;
    }
  }


  Future<void> getBalance() async {
    try{
    loading.value = true;
    final String? token = await storage.getToken();

    if(token != null){
    final response = await repo.getWallet(token);

    if (response is DataSuccess) {
      final data = response.data;
      // print(data['data']['bal']);
      if (data['status'] == true) {

        accountBalance.value = double.parse(data['data']['bal']);
      }else {
        balanceErr.value = 'Reload the page';
      }
    }else if(response is DataFailed){
      final err = response.exception;

      if (err is DioException) {
        //  Network issues
        if (err.type == DioExceptionType.connectionError ) {
          balanceErr.value = 'no internet connection';
        }

        //  Server error
        final errData = err.response?.data;
        // print(err.response?.data);

        print(errData);
        if (errData != null && errData['message'] != null) {
          balanceErr.value = 'unable to load balance';
        } else {
          balanceErr.value = 'unable to load balance';
        }
      } }else{
      balanceErr.value = 'unable to load balance';
    }
    }}catch(e){
      balanceErr.value = 'Something went wrong try again later';
    }finally{
      loading.value = false;
    }

  }

  //
  Future<void> generateVirtual({
    required String fullname,
    required String phoneNumber,
    required String bvn,
    required String dob,
  }) async {
    try {
      final response = await repo.generateVirtual(
        fullname: fullname,
        bvn: bvn,
        phoneNumber: phoneNumber,
        dob: dob,
      );

      if (response is DataSuccess) {
        if (response.data['status'] == true) {
          virtualAcc.value = response.data['accountNumber'];
        } else {
          CustomSnackbar.showSnackbar(
            message: 'Unable to generate virtual account',
          );
        }
      } else if (response is DataFailed) {
        final err = response.exception;

        if (err is DioException) {
          //  Network issues
          if (err.type == DioExceptionType.connectionError) {
            CustomSnackbar.showSnackbar(message: 'No internet connection');
            return;
          }

          //  Server error
          final errData = err.response?.data;
          // print(err.response?.data);

          if (errData != null && errData['message'] != null) {
            CustomSnackbar.showSnackbar(message: errData['message']);
          } else {
            CustomSnackbar.showSnackbar(
                message: 'Server error, try again later');
          }
        } else {
          CustomSnackbar.showSnackbar(message: 'Unknown error occurred');
        }
      }
    }catch(e){
      CustomSnackbar.showSnackbar(message: 'Something went wrong try again later', title: 'Oops');
    }
  }

  var paymentGateWay = <BankModel>[
    BankModel(
      name: 'Nomba',
      availbaleServ: ['Pay with card', 'Transfer and USSD'],
      imgUrl: '',
    ),
    BankModel(name: 'PayStack', availbaleServ: ['PayStack'], imgUrl: ''),
    BankModel(
      name: 'Nomba',
      availbaleServ: ['Pay with card', 'Transfer and USSD'],
      imgUrl: '',
    ),
  ].obs;
}

class BankModel {
  final String name;
  final List<String> availbaleServ;
  final String imgUrl;

  BankModel({
    required this.name,
    required this.availbaleServ,
    required this.imgUrl,
  });
}
