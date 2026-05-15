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

  String error = '';
  RxString discoErr = ''.obs;
  var availableCable = <CableModel>[].obs;
  var tvRecipt = [];

  var availableTv = [
    TvModel(
      name: 'DSTV Subscription',
      abbrev: 'DSTV',
      description:
          'Share the joy this season with DSTv, your home of drama series and football',
    ),

    TvModel(
      name: 'GoTV',
      abbrev: 'GoTV',
      description:
          'Share the joy this season with GoTv, your home of drama series and football',
    ),
    TvModel(
      name: 'Startimes Payment',
      abbrev: 'STIM',
      description:
          'Share the joy this season with STIMTv, your home of drama series and football',
    ),
    TvModel(
      name: 'DSTV Box Office Wallet TopUp',
      abbrev: 'BOX',
      description:
          'Share the joy this season with DSTv, your home of drama series and football',
    ),
    TvModel(
      name: 'TSTV',
      abbrev: 'TSTV',
      description:
          'Share the joy this season with TSTv, your home of drama series and football',
    ),
    TvModel(
      name: 'African Cable Television (ACTV) Subscription',
      abbrev: 'ACTV',
      description:
          'Share the joy this season with ACTv, your home of drama series and football',
    ),
    TvModel(
      name: 'Cable Africa Network TV (CableTV)',
      abbrev: 'CNTV',
      description:
          'Share the joy this season with CNTv, your home of drama series and football',
    ),
    TvModel(
      name: 'Infinity TV Payments',
      abbrev: 'ITV',
      description:
          'Share the joy this season with ITv, your home of drama series and football',
    ),
  ].obs;

  var leftService = [
    TvServiceModel(title: 'Yanga', amount: '6000', duration: '1'),
    TvServiceModel(title: 'Compact', amount: '8000', duration: '1'),
    TvServiceModel(title: 'Stream', amount: '9000', duration: '1'),
    TvServiceModel(title: 'Premium', amount: '10000', duration: '1'),
  ];
  var rightService = [
    TvServiceModel(title: 'Padi', amount: '7000', duration: '1'),
    TvServiceModel(title: 'Compact Plus', amount: '8000', duration: '1'),
    TvServiceModel(title: 'Confam', amount: '7000', duration: '1'),
  ];
  var premiumService = [
    TvServiceModel(title: 'Premium', amount: '10000', duration: '1'),
    TvServiceModel(title: 'Padi', amount: '15000', duration: '2'),
    TvServiceModel(title: 'Padi', amount: '20000', duration: '3'),
    TvServiceModel(title: 'Padi', amount: '20000', duration: '4'),
  ];
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

  ///get Cable discos
  Future<void> getCableDiscos() async {

    final String? token = await store.getToken();
    if(token == null) return;
    final response = await repo.cableDisco(token);

    if(response is DataSuccess){
      if (response.data['status'] == true) {
        final data = response.data['data'];
        List discos = data['cables'];
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

  }

///Get Cable Bundles and price
  Future<void> getCableBundle({
    required String phone,
    required String smartcard,
    required String id,
    required String subType,
    required String transPin,
    required String productId,
  }) async {

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

  Future<void> buyTvService({
    required String phone,
    required String smartcard,
    required String id,
    required String subType,
    required String transPin,
    required String productId,
  }) async {

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
