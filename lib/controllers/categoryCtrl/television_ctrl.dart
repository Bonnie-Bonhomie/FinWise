import 'package:dio/dio.dart';
import 'package:fin_wise/core/resources/data_state.dart';
import 'package:fin_wise/data/dataSource/storage_file.dart';
import 'package:fin_wise/data/models/model_export.dart';
import 'package:fin_wise/data/repositories/CategoriesRepo/television_repo.dart';
import 'package:fin_wise/utils/widgets/custom_snackbar.dart';
import 'package:get/get.dart';

class TelevisionCtrl extends GetxController {
  final TelevisionRepo repo;
  final StorageFile store;

  TelevisionCtrl(this.repo, this.store);

  @override
  void onInit() {
    // TODO: implement onInit
    getCableDiscos();
    super.onInit();
  }


  String error = '';
  RxString cardErr= ''.obs;
  RxString discoErr = ''.obs;
  RxBool loadDisco = false.obs;
  RxBool loadingBun = false.obs;
  var availableCable = <CableModel>[].obs;
  var cablePrices = <CableBundle>[].obs;
  var tvRecipt = [];


  ///get Cable discos
  Future<void> getCableDiscos() async {

    loadDisco.value = true;
    final String? token = await store.getToken();
    if(token == null) return;
    final response = await repo.cableDisco(token);

    if(response is DataSuccess){
      if (response.data['status'] == true) {
        final data = response.data['data'];

        List discos = data['cables'];
        // print(discos);
        final dis = discos.map((e) => CableModel.fromJson(e)).toList();

        availableCable.addAll(dis);
      } else {
        discoErr.value = 'Unable to Complete transaction';
      }
    }else if(response is DataFailed){
      final err = response.exception;

      if(err is DioException){
        if(err.type == DioExceptionType.connectionError || err.type == DioExceptionType.connectionTimeout){
          discoErr.value = 'Check your internet connection';
        }
        final errData = err.response?.data;
        if(errData != null && errData['message'] != null){
          discoErr.value = errData['message'];
        }else{
          discoErr.value = 'Unable to complete transaction process';
        }
      }
    }else{
      CustomSnackbar.showSnackbar(message: 'Unable to complete transaction process');
    }
    loadDisco.value = false;

  }

///Get Cable Bundles and price
  Future<void> getCableBundle({required int id}) async {

    final String? token = await store.getToken();
    if(token == null) return;
    final response = await repo.cableBundlePrice(token: token, id: id);

    if(response is DataSuccess){
      if (response.data['status'] == true) {
        final data = response.data['data'];

        final bundle = CableBundle.fromJson(data['bundles']);
        
        // print(data['bundles']);
        cablePrices.add(bundle);
        ///To do
      } else {
        error = 'Unable to load available cable bundle';
      }
    }else if(response is DataFailed){
      final err = response.exception;

      if(err is DioException){
        if(err.type == DioExceptionType.connectionError || err.type == DioExceptionType.connectionTimeout){
          error = 'Check your internet connection';
        }
        final errData = err.response?.data;
        if(errData != null && errData['message'] != null){
           error = errData['message'];
        }else{
          error = 'Unable to load available cable bundle';
        }
      }
    }else{
      error = 'Unable to load available cable bundle';
    }

  }

  ///Verify smart card function
  Future<void> verifySmartCard({required String smartcard, required String id,}) async {

    final String? token = await store.getToken();
    if(token == null) return;
    final response = await repo.verifyCableNum(token: token, serviceId: id, cableNumber: smartcard);

    if(response is DataSuccess){
      if (response.data['status'] == true) {
        final data = response.data['data'];
      } else {
        cardErr.value = 'Unable to to verify card number';
      }
    }else if(response is DataFailed){
      final err = response.exception;

      if(err is DioException){
        if(err.type == DioExceptionType.connectionError || err.type == DioExceptionType.connectionTimeout){
          cardErr.value =  'Check your internet connection';
        }
        final errData = err.response?.data;
        if(errData != null && errData['message'] != null){
         cardErr.value = errData['message'];
        }else{
          cardErr.value = 'Unable to complete transaction process';
        }
      }
    }else{
      cardErr.value = 'Unable to complete transaction process';
    }

  }


  /// buy Cable service
  Future<void> buyTvService({
    required String phone,
    required String smartcard,
    required String id,
    required String subType,
    required String transPin,
    required String productId,
  })
  async {

    final String? token = await store.getToken();
    if(token == null) return;
    final response = await repo.buyCableFunction(
      token: token,
      smartcard: smartcard,
      subType: subType,
      phone: phone,
      transPin: transPin,
      productId: productId,
    );

    if(response is DataSuccess){
      if (response.data['status'] == true) {
        final data = response.data['data'];
      } else {
        error = 'Unable to Complete transaction';
        CustomSnackbar.showSnackbar(message: error, title: 'Oops');
      }
    }else if(response is DataFailed){
      final err = response.exception;

      if(err is DioException){
        if(err.type == DioExceptionType.connectionError || err.type == DioExceptionType.connectionTimeout){
          CustomSnackbar.showSnackbar(title: 'No internet connection', message: 'Check your internet connection');
        }
        final errData = err.response?.data;
        if(errData != null && errData['message'] != null){
          CustomSnackbar.showSnackbar(message: errData['message']);
        }else{
          CustomSnackbar.showSnackbar(message: 'Unable to complete transaction process');
        }
      }
    }else{
      CustomSnackbar.showSnackbar(message: 'Unable to complete transaction process');
    }

  }
}
