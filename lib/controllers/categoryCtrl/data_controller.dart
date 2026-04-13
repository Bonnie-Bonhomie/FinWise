import 'package:fin_wise/core/resources/data_state.dart';
import 'package:fin_wise/data/models/data_model.dart';
import 'package:fin_wise/data/repositories/CategoriesRepo/data_repository.dart';
import 'package:fin_wise/utils/Helpers/loader_helper.dart';
import 'package:fin_wise/utils/widgets/custom_snackbar.dart';
import 'package:get/get.dart';

class DataController extends GetxController{

  final DataRepository repo;
  DataController(this.repo);

  var sections = ['HotUp', 'Daily', 'Weekly', 'Monthly'];
  DataApiModel? dataReceipt;
  var err = ''.obs;

  var hotUp = [
    DataPlan(name: '7', days: 'GB', uid: '10', price: 3500, type: 'GB'),
    DataPlan(name: '8', days: '30 days', uid: '10', price: 3700, type: 'GB'),
    DataPlan(name: '6', days: '7 days', uid: '10', price: 3000, type: 'GB'),
    DataPlan(name: '4', days: '3 day', uid: '10', price: 1500, type: 'GB'),
    DataPlan(name: '10', days: '7 days', uid: '10', price: 5000, type: 'GB'),

    DataPlan(name: '8', days: '30 days', uid: '10', price: 3700, type: 'GB'),
    DataPlan(name: '6', days: '7 days', uid: '10', price: 3000, type: 'GB'),
    DataPlan(name: '4', days: '3 day', uid: '10', price: 1500, type: 'GB'),
    DataPlan(name: '10', days: '7 days', uid: '10', price: 5000, type: 'GB'),

  ].obs;

  var weekly = [
    DataPlan(name: '7', days: '7 days', uid: '10', price: 3500, type: 'GB'),
    DataPlan(name: '10', days: '7 days', uid: '10', price: 5000, type: 'GB'),
    DataPlan(name: '8', days: '7 days', uid: '10', price: 4500, type: 'GB'),
    DataPlan(name: '10', days: '14 days', uid: '10', price: 5500, type: 'GB'),
    DataPlan(name: '9', days: '7 days', uid: '10', price: 5000, type: 'GB'),
    DataPlan(name: '15', days: '14 days', uid: '10', price: 6000, type: 'GB'),
  ].obs;
  var daily = [
    DataPlan(name: '1', days: 'Daily', uid: '20', price: 350, type: 'GB'),
    DataPlan(name: '2', days: 'Daily', uid: '20', price: 350, type: 'GB'),
    DataPlan(name: '1', days: 'Daily', uid: '20', price: 350, type: 'GB'),
    DataPlan(name: '500', days: 'Daily', uid: '20', price: 350, type: 'MB'),
    DataPlan(name: '1', days: 'Daily', uid: '20', price: 350, type: 'GB'),
  ];

  Future<void> buyData({
    required int number,
    required double amount,
    required String type,
}) async{

    await runWithLoader(() async{
      final result = await repo.buyData(number: number, amount: amount, type: type);

      if(DataState == DataSuccess && result.data['status'] == 'success'){
        dataReceipt = result.data;
      }
      else{
        err.value = 'Unable to complete transaction';
        CustomSnackbar.showSnackbar(message: err.value, title: 'Oops');
      }
    });

}

}