import 'package:dio/dio.dart';
import 'package:fin_wise/core/Routes/Api_endpoints/api_endpoints.dart';
import 'package:fin_wise/core/connection/network.dart';
import 'package:fin_wise/core/resources/data_state.dart';
import 'package:fin_wise/data/dataSource/api_service.dart';

class ElectricityRepo{

  final ApiServices services;
  final InternetInfo info;

  ElectricityRepo(this.services, this.info);

  /// Buy electricity function
  Future<DataState> buyElect({required String amount,
    required String meterNum,
    required String token,
    required String type,
    required String transPin,
    required String serviceId,})
  async {
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
      final result = await services.postRequestsWithToken(ApiEndpoints.buyElect, token, {
        'amount': amount,
        'meter_number': meterNum,
        'service_id': serviceId,
        'transaction_pin': transPin,
        'type': type
      });
      return DataSuccess(result.data);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

/// verify meter number
  Future<DataState> verifyMeter({
    required String meterNum,
    required String token,
    required String type,
    required String serviceId,})
  async {
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
      final result = await services.postRequestsWithToken(ApiEndpoints.verifyMeter, token, {
        'meter_number': meterNum,
        'service_id': serviceId,
        'type': type
      });
      print(result.data);
      return DataSuccess(result.data);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  ///Available Electricity services
  Future<DataState> electDiscos(String token) async {
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
      final result = await services.getRequestWIthToken(ApiEndpoints.electDisco, token);
      return DataSuccess(result.data);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}