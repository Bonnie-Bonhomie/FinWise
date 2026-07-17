import 'package:dio/dio.dart';
import 'package:data_boot/core/Routes/Api_endpoints/api_endpoints.dart';
import 'package:data_boot/core/connection/network.dart';
import 'package:data_boot/core/resources/data_state.dart';
import 'package:data_boot/data/dataSource/api_service.dart';

class TelevisionRepo {
  final InternetInfo info;
  final ApiServices services;

  TelevisionRepo(this.services, this.info);

  ///  Cable discos function
  Future<DataState> cableDisco(String token) async {
    try {
      if (!await info.connected) {
        return DataFailed(
          DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.connectionError,
            error: 'No internet connection',
          ),
        );
      }
      final response = await services.getRequestWIthToken(ApiEndpoints.cableDisco, token);
      return DataSuccess(response.data);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }



  /// get Cable bundle price function
  Future<DataState> cableBundlePrice({required String token, required int id}) async {
    try {
      if (!await info.connected) {
        return DataFailed(
          DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.connectionError,
            error: 'No internet connection',
          ),
        );
      }
      final result = await services.getRequestWIthToken('${ApiEndpoints.cableBundle}/$id', token);
      return DataSuccess(result.data);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  /// Verify Cable smart card number function
  Future<DataState> verifyCableNum({required String token, required String serviceId, required String cableNumber}) async {
    try {
      if (!await info.connected) {
        return DataFailed(
          DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.connectionError,
            error: 'No internet connection',
          ),
        );
      }
      final response = await services.postRequestsWithToken(ApiEndpoints.verifySmartCard, token , {
        'service_id': serviceId,
        'cable_number': cableNumber,
      });
      return DataSuccess(response.data);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  /// Buy Cable function
  Future<DataState> buyCableFunction({required String token, required String smartcard, required String subType, required String phone, required String transPin, required String productId}) async {
    try {
      if (!await info.connected) {
        return DataFailed(
          DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.connectionError,
            error: 'No internet connection',
          ),
        );
      }
      final result = await services.postRequestsWithToken(ApiEndpoints.buyCable, token, {
        'product_id': productId,
        'smartCardNo': smartcard,
        'phone': phone,
        'transaction_pin': transPin,
        'subscription_type': subType
      });
      return DataSuccess(result.data);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
