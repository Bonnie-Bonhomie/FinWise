import 'package:dio/dio.dart';
import 'package:fin_wise/core/Routes/Api_endpoints/api_endpoints.dart';
import 'package:fin_wise/core/connection/network.dart';
import 'package:fin_wise/data/dataSource/api_service.dart';
import 'package:fin_wise/core/resources/data_state.dart';

class TransactionRepo {

  final ApiServices apiServices;
  final InternetInfo internetInfo;

  TransactionRepo({required this.internetInfo, required this.apiServices});

  Future<DataState> getTransact(String token, int page) async {
    try {
      if (!await internetInfo.connected) {
        return DataFailed(DioException(requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.connectionError,
            error: "No Internet Connection"));
      }

      final transact = await apiServices.getRequestWIthToken(
        '${ApiEndpoints.transact}?page=1', //Url
        token,);
      return DataSuccess(transact.data);

    }on DioException catch (e) {
      return DataFailed(e);
    }
  }


  Future<DataState> getSingleTransact(String token) async {
    try {
      if (!await internetInfo.connected) {
        return DataFailed(DioException(requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.connectionError,
            error: "No Internet Connection"));
      }

      final transact = await apiServices.getRequestWIthToken(
        ApiEndpoints.transact, //Url
        token,);
      return DataSuccess(transact.data);

    }on DioException catch (e) {
      return DataFailed(e);
    }
  }

  Future<DataState> depositTransact(String token) async {
    try {
      if (!await internetInfo.connected) {
        return DataFailed(DioException(requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.connectionError,
            error: "No Internet Connection"));
      }

      final transact = await apiServices.getRequestWIthToken(
        ApiEndpoints.transact, //Url
        token,);
      return DataSuccess(transact.data);

    }on DioException catch (e) {
      return DataFailed(e);
    }
  }
}