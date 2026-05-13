import 'package:dio/dio.dart';
import 'package:fin_wise/core/Routes/Api_endpoints/api_endpoints.dart';
import 'package:fin_wise/core/connection/network.dart';
import 'package:fin_wise/core/resources/data_state.dart';
import 'package:fin_wise/data/dataSource/api_service.dart';
import 'package:fin_wise/data/models/data_model.dart';
import 'package:get/get.dart';

class DataRepository {

  final ApiServices services;
  final InternetInfo info;

  DataRepository(this.services, this.info);

  Future<DataState> buyData({
    required int number,
    required double amount,
    required String type,
  }) async
  {
    try {
      if (!await info.connected) {
        return DataFailed(DioException(requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.connectionError,
            error: 'No internet connection'));
      }else{
        final response = await services.postRequests(ApiEndpoints.buyData, {
          'amount':amount,
          'number': number,
          'type': type
        });
        return DataSuccess(response.data);
      }
    }on DioException catch(e){
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
        final response = await services.getRequestWIthToken('${ApiEndpoints.dataNet}/$networkId', token);
        return DataSuccess(response.data);
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}