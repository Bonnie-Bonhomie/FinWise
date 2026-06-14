import 'package:dio/dio.dart';
import 'package:fin_wise/core/Routes/Api_endpoints/api_endpoints.dart';
import 'package:fin_wise/core/connection/network.dart';
import 'package:fin_wise/core/resources/data_state.dart';
import 'package:fin_wise/data/dataSource/api_service.dart';

class DeleteAccRepo{


  final ApiServices services;
  final InternetInfo info;

  DeleteAccRepo(this.services, this.info);

  Future<DataState> deleteAccount(String token) async {

    try {

      if (!await info.connected) {
        return DataFailed(
          DioException(
            requestOptions: RequestOptions(path: ''),
            error: 'No internet connection',
          ),
        );
      }
      final result = await services.deleteRequestWIthToken(ApiEndpoints.deleteAccount, token);
      return DataSuccess(result.data);
    }on DioException catch (e) {
      return DataFailed(e);
    }
  }

}