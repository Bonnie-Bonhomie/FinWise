import 'package:dio/dio.dart';
import 'package:fin_wise/core/Routes/Api_endpoints/api_endpoints.dart';
import 'package:fin_wise/core/connection/network.dart';
import 'package:fin_wise/core/resources/data_state.dart';
import 'package:fin_wise/data/dataSource/api_service.dart';

class AccountRepo {
  final ApiServices services;
  final InternetInfo info;

  AccountRepo(this.services, this.info);

  Future<DataState> generateVirtual({
    required String fullname,
    required String bvn,
    required String phoneNumber,
    required dob,
  }) async {
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
      final result = await services.postRequests(ApiEndpoints.virtual, {
        'fullName': fullname,
        'bvn': bvn,
        'phoneNumber': phoneNumber,
        'dob': dob,
      });
      return DataSuccess(result.data);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  Future<DataState> getWallet(String token) async {
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
      final result = await services.getRequestWIthToken(ApiEndpoints.balance, token);
      return DataSuccess(result.data);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }


  ///Bonus balance
  Future<DataState> getBonusBal(String token) async {
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
      final result = await services.getRequestWIthToken(ApiEndpoints.bonusBal, token);
      return DataSuccess(result.data);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  ///Payment channels
  Future<DataState> getPaymentChannel(String token) async {
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
      final result = await services.getRequestWIthToken(ApiEndpoints.paymentChannel, token);
      return DataSuccess(result.data);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  ///Pay stack init
  Future<DataState> getPayInit(String token, String endPoint) async {
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
      final result = await services.getRequestWIthToken(endPoint, token);
      return DataSuccess(result.data);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
