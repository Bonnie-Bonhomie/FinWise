import 'package:dio/dio.dart';
import 'package:data_boot/core/Routes/routes.dart';
import 'package:data_boot/core/constant.dart';
import 'package:data_boot/core/resources/data_state.dart';
import 'package:data_boot/data/dataSource/storage_file.dart';
import 'package:data_boot/data/models/model_export.dart';
import 'package:data_boot/data/repositories/CategoriesRepo/data_repository.dart';
import 'package:data_boot/utils/widgets/custom_snackbar.dart';
import 'package:data_boot/viewModel/home_view_model.dart';
import 'package:get/get.dart';

class DataController extends GetxController {
  final DataRepository repo;
  final StorageFile store;

  DataController(this.repo, this.store);

  var sections = ['HotUp', 'Daily', 'Weekly', 'Monthly'];
  var dataNet = <NetworksModel>[].obs;
  DataApiModel? dataReceipt;
  var err = ''.obs;
  var select = 1.obs;

  var planErr = ''.obs;
  RxBool dataLoading = false.obs;
  final HomeViewModel viewModel = HomeViewModel();

  @override
  void onInit() {
    // TODO: implement onInit
    getNetworks();
    getDataPlans(1);
    super.onInit();
  }
  var dataPlans = <DataPlan>[].obs;
  var hotUp = <DataPlan>[].obs;

  var weeklyPlan = <DataPlan>[].obs;
  var dailyPlan = <DataPlan>[].obs;
  var monthlyPlan = <DataPlan>[].obs;

  Future<void> buyData({
    required String dataId,
    required String tranPin,
    required String phone,
  }) async {
   try{
    final String? token = await store.getToken();
    if (token == null) return;

    final number = viewModel.numberBack(phone);
    int id = int.parse(dataId);
    final response = await repo.buyData(
      dataId: dataId,
      phone: number,
      token: token,
      tranPin: tranPin,
    );
    if (response is DataSuccess) {
      if (response.data['status'] == true) {
        final data = response.data['data'];
        ////print(data);
        TransactionModel receipt = TransactionModel.fromJson(data);
          // receipt.category = Categories.data;
        if(receipt.apiStatus == TransactionStatus.failed){
          CustomSnackbar.showSnackbar(message: 'Unable to complete transaction, try again later');
        }else{
          Get.toNamed(Routes.transSuccess, arguments: receipt);
        }
      } else {
        CustomSnackbar.showSnackbar(message: 'Unable to complete transaction');
      }
    } else if (response is DataFailed) {
      final err = response.exception;

      if (err is DioException) {
        if (err.type == DioExceptionType.connectionError || err.type == DioExceptionType.connectionTimeout) {
          CustomSnackbar.showSnackbar(title: 'No internet connection', message: 'Check your internet connection');
        }
        final errData = err.response?.data;
        ////print(errData);
        if (errData['message'] != null && errData != null) {
          CustomSnackbar.showSnackbar(message: errData['message'].toString());
        }
      }else{
        CustomSnackbar.showSnackbar(message: 'Unable to complete transaction', title: 'Oops');
      }
    } else {
      err.value = 'Unable to complete transaction';
      CustomSnackbar.showSnackbar(message: err.value, title: 'Oops');
    }
   }catch(e){
     ////print(e);
     CustomSnackbar.showSnackbar(message: 'Something went wrong try again later', title: 'Oops');
   }
  }

  Future<void> getNetworks() async {
    final String? token = await store.getToken();
    if (token == null) return;
    final result = await repo.dataNetwork(token);
    if (result is DataSuccess) {
      final data = result.data;
      if (data['status'] == true) {
        dataNet.clear();
        //To solve JsArray<dynamic> error
        //1. Save the data from the response in a list
        List netw = data['data']['networks'];
        //2. Loop through the list
        final netwok = netw.map((e) => NetworksModel.fromJson(e)).toList();

        //3. Then add the list items into your own list
        dataNet.addAll(netwok);
        // ////print(dataNet);
      }
      return;
    } else if (result is DataFailed) {
      final err = result.exception;
      if (err is DioException) {
        if (err.type == DioExceptionType.connectionError || err.type == DioExceptionType.connectionTimeout) {
          CustomSnackbar.showSnackbar(title: 'No internet connection', message: 'Check your internet connection');
        }
      }
      return;
    }
    return;
  }


  /// Get data plans
  Future<void> getDataPlans(int networkId) async {
    try{
    dataLoading.value = true;
    dataPlans.clear();

    final String? token = await store.getToken();
    if (token == null) return;
    final result = await repo.dataPlans(token, networkId);

    if (result is DataSuccess) {
      final data = result.data;
      if (data['status'] == true) {
        List plan = data['data']['dataplans'];
        //
        final dataPlan = plan.map((e) => DataPlan.fromJson(e)).toList();

        dataPlans.addAll(dataPlan);
        ////print(dataPlans.length);
        dailyPlan.value = dataPlans.where((e) => e.frequency == Frequency.daily).toList();
        weeklyPlan.value = dataPlans.where((e) => e.frequency == Frequency.weekly).toList();
        monthlyPlan.value = dataPlans.where((e) => e.frequency == Frequency.monthly).toList();
        hotUp.value = dataPlans.where((pl) => pl.hotPlans == '1').toList();
        ////print(monthlyPlan.length);

        // ////print(plan);
      }
    }
    else if (result is DataFailed) {
      final err = result.exception;
      if (err is DioException) {
        if (err.type == DioExceptionType.connectionError || err.type == DioExceptionType.connectionTimeout) {
          planErr.value = 'No internet connection';
          ////print(planErr.value);
        }
        final errData = err.response?.data;
        if (errData != null && errData['message'] != null) {
          planErr.value = errData['message'];
        }
      }
      return;
    }}catch(e){
      planErr.value ='Something went wrong try again later';
    }
    finally{dataLoading.value = false;}
  }


  ///Filter data plans
///

  void getHots(){

  }
  final Map<String, List<DataPlan>> groupPlans = {
    'daily': [],
    'weekly': [],
    'monthly': [],
  };
  void getPlans(){
    for(final plan in dataPlans){
      groupPlans[plan.frequency.name]?.add(plan);
    }
    final dailyPlans = groupPlans[Frequency.daily];
  }

}
