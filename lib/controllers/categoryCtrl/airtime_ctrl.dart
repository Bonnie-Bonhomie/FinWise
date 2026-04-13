
import 'package:fin_wise/core/constant.dart';
import 'package:fin_wise/core/resources/data_state.dart';
import 'package:fin_wise/data/repositories/CategoriesRepo/airtime_repo.dart';
import 'package:fin_wise/utils/Helpers/loader_helper.dart';
import 'package:fin_wise/utils/widgets/custom_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AirtimeCtrl extends GetxController{

  final AirtimeRepository repo;
  AirtimeCtrl(this.repo);

  var selected = ServiceProvider.glo.obs;
  var amountCtrl = TextEditingController().obs;
  var allNumbers = [08030039725, 09052378291].obs;
  var airtimeBenes = [].obs;

  var cleared = false.obs;
  var airtimeReceipt = [];
  var error = ''.obs;

 Future<void> buyAirtime({
    required double amount,
   required int number,
}) async{
   await runWithLoader(() async{
     final result = await repo.buyAirtime(amount: amount, number: number);

     if(DataState == DataSuccess && result.data['status'] == 'success'){
       airtimeReceipt = result.data;
     }
     else{
       error.value = 'Unable to complete transaction';
       CustomSnackbar.showSnackbar(message: error.value, title:  'Oops');
     }
   });
 }

}