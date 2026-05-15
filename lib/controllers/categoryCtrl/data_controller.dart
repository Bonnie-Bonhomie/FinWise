import 'package:dio/dio.dart';
import 'package:fin_wise/core/resources/data_state.dart';
import 'package:fin_wise/data/dataSource/storage_file.dart';
import 'package:fin_wise/data/models/model_export.dart';
import 'package:fin_wise/data/repositories/CategoriesRepo/data_repository.dart';
import 'package:fin_wise/utils/widgets/custom_snackbar.dart';
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
  var dataPlans = <DataPlan>[].obs;
  var planErr = ''.obs;
  RxBool dataLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getNetworks();
    getDataPlans(1);
    super.onInit();
  }

  var hotUp = [].obs;

  var weekly = [].obs;
  var daily = [];

  Future<void> buyData({
    required String dataId,
    required String tranPin,
    required String phone,
  }) async {
    final String? token = await store.getToken();
    if (token == null) return;

    final response = await repo.buyData(
      dataId: dataId,
      phone: phone,
      token: token,
      tranPin: tranPin,
    );

    if (response is DataSuccess) {
      if (response.data['status'] == true) {
        final data = response.data['data'];
        print(data);
        // dataReceipt = data;
      } else {
        CustomSnackbar.showSnackbar(message: 'Unable to complete transaction');
      }
    } else if (response is DataFailed) {
      final err = response.exception;
      if (err is DioException) {
        if (err.type == DioExceptionType.connectionError || err.type == DioExceptionType.connectionTimeout) {
          CustomSnackbar.showSnackbar(
            message: 'No Network. Check you internet connection.',
          );
        }
        final errData = err.response?.data;
        if (errData['message'] != null && errData != null) {
          CustomSnackbar.showSnackbar(message: errData['message']);
        }
      }
    } else {
      err.value = 'Unable to complete transaction';
      CustomSnackbar.showSnackbar(message: err.value, title: 'Oops');
    }
  }

  Future<void> getNetworks() async {
    final String? token = await store.getToken();
    if (token == null) return;
    final result = await repo.dataNetwork(token);
    if (result is DataSuccess) {
      final data = result.data;
      if (data['status'] == true) {
        //To solve JsArray<dynamic> error
        //1. Save the data from the response in a list
        List netw = data['data']['networks'];
        //2. Loop through the list
        final netwok = netw.map((e) => NetworksModel.fromJson(e)).toList();

        //3. Then add the list items into your own list
        dataNet.addAll(netwok);
        print(dataNet);
      }
      return;
    } else if (result is DataFailed) {
      final err = result.exception;
      if (err is DioException) {
        if (err.type == DioExceptionType.connectionError || err.type == DioExceptionType.connectionTimeout) {
          CustomSnackbar.showSnackbar(message: 'No internet connection');
        }
        final errData = err.response?.data;
        if (errData != null && errData['message'] != null) {
          CustomSnackbar.showSnackbar(message: errData['message']);
        }
      }
      return;
    }
  }

  Future<void> getDataPlans(int networkId) async {
    dataLoading.value = true;
    print(dataLoading.value);
    print('stat');
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
        print(plan);
      }
    }
    else if (result is DataFailed) {
      final err = result.exception;
      if (err is DioException) {
        if (err.type == DioExceptionType.connectionError || err.type == DioExceptionType.connectionTimeout) {
          planErr.value = 'No internet connection';
        }
        final errData = err.response?.data;
        if (errData != null && errData['message'] != null) {
          planErr.value = errData['message'];
        }
      }
      return;
    }

    dataLoading.value = false;
    print(dataLoading.value);
    return;
  }


}
