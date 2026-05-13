import 'package:dio/dio.dart';
import 'package:fin_wise/core/resources/data_state.dart';
import 'package:fin_wise/data/dataSource/storage_file.dart';
import 'package:fin_wise/data/models/data_model.dart';
import 'package:fin_wise/data/models/numbers_model.dart';
import 'package:fin_wise/data/repositories/CategoriesRepo/data_repository.dart';
import 'package:fin_wise/utils/Helpers/loader_helper.dart';
import 'package:fin_wise/utils/widgets/custom_snackbar.dart';
import 'package:get/get.dart';

class DataController extends GetxController{

  final DataRepository repo;
  final StorageFile store;
  DataController(this.repo, this.store);

  var sections = ['HotUp', 'Daily', 'Weekly', 'Monthly'];
  var dataNet = <NetworksModel>[].obs;
  DataApiModel? dataReceipt;
  var err = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getNetworks();
    super.onInit();
  }

  var hotUp = [
    // DataPlan(name: '7', days: 'GB', uid: '10', price: 3500, type: 'GB'),
    // DataPlan(name: '8', days: '30 days', uid: '10', price: 3700, type: 'GB'),
    // DataPlan(name: '6', days: '7 days', uid: '10', price: 3000, type: 'GB'),
    // DataPlan(name: '4', days: '3 day', uid: '10', price: 1500, type: 'GB'),
    // DataPlan(name: '10', days: '7 days', uid: '10', price: 5000, type: 'GB'),
    //
    // DataPlan(name: '8', days: '30 days', uid: '10', price: 3700, type: 'GB'),
    // DataPlan(name: '6', days: '7 days', uid: '10', price: 3000, type: 'GB'),
    // DataPlan(name: '4', days: '3 day', uid: '10', price: 1500, type: 'GB'),
    // DataPlan(name: '10', days: '7 days', uid: '10', price: 5000, type: 'GB'),

  ].obs;

  var weekly = [
    // DataPlan(name: '7', days: '7 days', uid: '10', price: 3500, type: 'GB'),
    // DataPlan(name: '10', days: '7 days', uid: '10', price: 5000, type: 'GB'),
    // DataPlan(name: '8', days: '7 days', uid: '10', price: 4500, type: 'GB'),
    // DataPlan(name: '10', days: '14 days', uid: '10', price: 5500, type: 'GB'),
    // DataPlan(name: '9', days: '7 days', uid: '10', price: 5000, type: 'GB'),
    // DataPlan(name: '15', days: '14 days', uid: '10', price: 6000, type: 'GB'),
  ].obs;
  var daily = [
    // DataPlan(name: '1', days: 'Daily', uid: '20', price: 350, type: 'GB'),
    // DataPlan(name: '2', days: 'Daily', uid: '20', price: 350, type: 'GB'),
    // DataPlan(name: '1', days: 'Daily', uid: '20', price: 350, type: 'GB'),
    // DataPlan(name: '500', days: 'Daily', uid: '20', price: 350, type: 'MB'),
    // DataPlan(name: '1', days: 'Daily', uid: '20', price: 350, type: 'GB'),
  ];

  Future<void> buyData({
    required int number,
    required double amount,
    required String type,
}) async{

    await runWithLoader(() async{
      final response = await repo.buyData(number: number, amount: amount, type: type);

      if(response is DataSuccess){

        if(response.data['status'] == true){
          final data = response.data['data'];
          print(data);
          // dataReceipt = data;
        }else{

        }
      }

      else{
        err.value = 'Unable to complete transaction';
        CustomSnackbar.showSnackbar(message: err.value, title: 'Oops');
      }
    });

}

  Future<void> getNetworks() async {
    final String? token = await store.getToken();
    if(token == null)return;
    final result = await repo.dataNetwork(token);
    if (result is DataSuccess) {
      final data = result.data;
      if (data['status'] == true) {

        //To solve JsArray<dynamic> error
        //1. Save the data from the response in a list
        List netw = data['data']['networks'];
        //2. Loop through the list
        final netwok = netw.map((e)=> NetworksModel.fromJson(e)).toList();

        //3. Then add the list items into your own list
        dataNet.addAll(netwok);
        print(dataNet);
      } return;
    } else if (result is DataFailed) {
      final err = result.exception;
      if (err is DioException) {
        if (err.type == DioExceptionType.connectionError) {
          CustomSnackbar.showSnackbar(message: 'No internet connection');
        }
        final errData = err.response?.data;
        if (errData != null && errData['message'] != null) {
          CustomSnackbar.showSnackbar(message: errData['message']);
        } }return;
    }
  }

  Future<void> dataPlans() async {
    final String? token = await store.getToken();
    if(token == null)return;
    final result = await repo.dataNetwork(token);
    if (result is DataSuccess) {
      final data = result.data;
      if (data['status'] == true) {

        //To solve JsArray<dynamic> error
        //1. Save the data from the response in a list
        List netw = data['data']['networks'];
        //2. Loop through the list
        final netwok = netw.map((e)=> NetworksModel.fromJson(e)).toList();

        //3. Then add the list items into your own list
        dataNet.addAll(netwok);
        print(dataNet);
      } return;
    } else if (result is DataFailed) {
      final err = result.exception;
      if (err is DioException) {
        if (err.type == DioExceptionType.connectionError) {
          CustomSnackbar.showSnackbar(message: 'No internet connection');
        }
        final errData = err.response?.data;
        if (errData != null && errData['message'] != null) {
          CustomSnackbar.showSnackbar(message: errData['message']);
        } }return;
    }
  }

}