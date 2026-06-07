import 'package:dio/dio.dart';
import 'package:fin_wise/core/Routes/routes.dart';
import 'package:fin_wise/core/constant.dart';
import 'package:fin_wise/core/resources/data_state.dart';
import 'package:fin_wise/core/resources/storage_keys.dart';
import 'package:fin_wise/data/dataSource/storage_file.dart';
import 'package:fin_wise/data/models/model_export.dart';
import 'package:fin_wise/data/repositories/CategoriesRepo/television_repo.dart';
import 'package:fin_wise/utils/Helpers/share_prefer_services.dart';
import 'package:fin_wise/utils/widgets/custom_snackbar.dart';
import 'package:get/get.dart';

class TelevisionCtrl extends GetxController {
  final TelevisionRepo repo;
  final StorageFile store;
  final SharedPreferService storage;

  TelevisionCtrl(this.repo, this.store, this.storage);

  @override
  void onInit() {
    // TODO: implement onInit
    getCableDiscos();
    super.onInit();
  }


  String error = '';
  RxString cardErr = ''.obs;
  RxString discoErr = ''.obs;
  RxBool loadDisco = false.obs;
  RxBool loadingBun = false.obs;
  RxString phone = ''.obs;
  RxBool verified = false.obs;
  var availableCable = <CableModel>[].obs;
  var cablePrices = <CableBundle>[].obs;
  var tvRecipt = [];
  Map<String, dynamic> verifyDet = {};
  RxString verifyErr = ''.obs;
  RxBool verifyLoad = false.obs;


  void getNumber() async {
    phone.value = (await storage.retrieve<String>(PrefStoreKeys.phone)) ?? '';
  }

  ///get Cable discos
  Future<void> getCableDiscos() async {
    try{
      loadDisco.value = true;
      final String? token = await store.getToken();
      if (token == null) return;
      final response = await repo.cableDisco(token);

      if (response is DataSuccess) {
        if (response.data['status'] == true) {
          final data = response.data['data'];

          List discos = data['cables'];
          // print(discos);
          final dis = discos.map((e) => CableModel.fromJson(e)).toList();

          availableCable.addAll(dis);
        } else {
          discoErr.value = 'Unable to load Electricity discos';
        }
      } else if (response is DataFailed) {
        final err = response.exception;

        if (err is DioException) {
          if (err.type == DioExceptionType.connectionError ||
              err.type == DioExceptionType.connectionTimeout) {
            discoErr.value = 'Check your internet connection';
          }
          final errData = err.response?.data;
          if (errData != null && errData['message'] != null) {
            discoErr.value = errData['message'];
          } else {
            discoErr.value ='Unable to load Electricity discos';
          }
        }
      } else {
        CustomSnackbar.showSnackbar(
            message: 'Unable to load Electricity discos');
      }
    }catch(e){
      print(e);
      CustomSnackbar.showSnackbar(message: 'Something went wrong, try to reload');
    }
    finally{
      loadDisco.value = false;
    }
  }

  ///Get Cable Bundles and price
  Future<void> getCableBundle({required int id}) async {
    try{
      final String? token = await store.getToken();
      if (token == null) return;
      final response = await repo.cableBundlePrice(token: token, id: id);

      print(response.data);
      if (response is DataSuccess) {
        if (response.data['status'] == true) {

          cablePrices.clear();
          final data = response.data['data'];

          List bundles = data['cable'];
          final bundle = bundles.map((e) => CableBundle.fromJson(e)).toList();

          cablePrices.addAll(bundle);
          print(cablePrices.length);

          ///To do
        } else {
          error = 'Unable to load available cable bundle';
        }
      } else if (response is DataFailed) {
        final err = response.exception;

        if (err is DioException) {
          if (err.type == DioExceptionType.connectionError ||
              err.type == DioExceptionType.connectionTimeout) {
            error = 'Check your internet connection';
          }
          final errData = err.response?.data;
          if (errData != null && errData['message'] != null) {
            error = errData['message'];
          } else {
            error = 'Unable to load available cable bundle';
          }
        }
      } else {
        error = 'Unable to load available cable bundle';
      }
    }catch(e){
      error = 'Something went wrong, try to reload';

    }
  }

  ///Verify smart card function
  Future<void> verifySmartCard(
      {required String smartcard, required String id,}) async {
    try {
      verifyLoad.value = true;
      final String? token = await store.getToken();
      if (token == null) return;
      final response = await repo.verifyCableNum(
          token: token, serviceId: id, cableNumber: smartcard);

      if (response is DataSuccess) {
        if (response.data['status'] == true) {
          final data = response.data['data'];
          verified.value = true;
          verifyDet = data;
          print(verifyDet);
        } else {
          verifyErr.value = 'Unable to to verify smart card number';
        }
      } else if (response is DataFailed) {
        final err = response.exception;

        if (err is DioException) {
          if (err.type == DioExceptionType.connectionError ||
              err.type == DioExceptionType.connectionTimeout) {
            verifyErr.value = 'Check your internet connection';
          }
          final errData = err.response?.data;
          if (errData != null && errData['message'] != null) {
            verifyErr.value = errData['message'];
          } else {
            verifyErr.value = 'Unable to to verify smart card number';
          }
        }
      } else {
        verifyErr.value = 'Unable to to verify smart card number';
      }
    } catch (e) {
      verifyErr.value = 'Something went wrong, try again later';
    } finally {
      verifyLoad.value = false;
    }
  }


  /// buy Cable service
  Future<void> buyTvService({
    required String phone,
    required String smartcard,
    required String subType,
    required String transPin,
    required String productId,
  }) async {
    try {
      final String? token = await store.getToken();
      if (token == null) return;
      final response = await repo.buyCableFunction(
        token: token,
        smartcard: smartcard,
        subType: subType,
        phone: phone,
        transPin: transPin,
        productId: productId,
      );

      print(response.data);
      if (response is DataSuccess) {
        if (response.data['status'] == true) {
          final data = response.data['data'];

          TransactionModel receipt = TransactionModel.fromJson(data);
          print(receipt);
          receipt.category = Categories.cable;
          if (receipt.apiStatus == TransactionStatus.failed) {
            CustomSnackbar.showSnackbar(
                message: 'Unable to complete transaction, try again later');
          } else {
            Get.toNamed(Routes.transSuccess, arguments: receipt);
          }
        } else {
          error = 'Unable to Complete transaction';
          CustomSnackbar.showSnackbar(message: error, title: 'Oops');
        }
      } else if (response is DataFailed) {
        final err = response.exception;

        if (err is DioException) {
          if (err.type == DioExceptionType.connectionError ||
              err.type == DioExceptionType.connectionTimeout) {
            CustomSnackbar.showSnackbar(title: 'No internet connection',
                message: 'Check your internet connection');
          }
          final errData = err.response?.data;
          if (errData != null && errData['message'] != null) {
            CustomSnackbar.showSnackbar(message: errData['message']);
          } else {
            CustomSnackbar.showSnackbar(
                message: 'Unable to complete transaction process');
          }
        }
      } else {
        CustomSnackbar.showSnackbar(
            message: 'Unable to complete transaction process');
      }
    } catch (e) {
      print(e);
      CustomSnackbar.showSnackbar(
          message: 'Something went wrong, try again later.');
    }
  }
}
