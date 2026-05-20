import 'package:dio/dio.dart';
import 'package:fin_wise/core/Routes/Api_endpoints/api_endpoints.dart';
import 'package:fin_wise/core/connection/network.dart';
import 'package:fin_wise/core/resources/data_state.dart';
import 'package:fin_wise/data/dataSource/api_service.dart';

class DataRepository {

  final ApiServices services;
  final InternetInfo info;

  DataRepository(this.services, this.info);

  Future<DataState> buyData({
    required int dataId,
    required String phone,
    required String token,
    required String tranPin
  }) async
  {
    try {
      if (!await info.connected) {
        return DataFailed(DioException(requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.connectionError,
            error: 'No internet connection'));
      }else{
        final response = await services.postRequestsWithToken(ApiEndpoints.buyData, token, {
          'data_id': dataId,
          'phone_number': phone,
          'transaction_pin': tranPin
        });
        return DataSuccess(response.data);
      }
    }on DioException catch(e){
      print(e);
      return DataFailed(e);
    }
  }
  Future<DataState> dataNetwork(String token) async {
    try {
      if (!await info.connected) {
        return DataFailed(
          DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.connectionError,
            error: 'No internet connection',
          ),
        );
      } else {
        final response = await services.getRequestWIthToken(ApiEndpoints.dataNet, token);
        return DataSuccess(response.data);
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  Future<DataState> dataPlans(String token, int networkId) async {
    try {
      if (!await info.connected) {
        return DataFailed(
          DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.connectionError,
            error: 'No internet connection',
          ),
        );
      } else {
        final response = await services.getRequestWIthToken('${ApiEndpoints.dataPlans}/$networkId', token);
        // print(response.data);
        return DataSuccess(response.data);
      }
    } on DioException catch (e) {
      print(e);
      return DataFailed(e);
    }
  }
}