import 'package:dio/dio.dart';
import 'package:data_boot/core/Routes/Api_endpoints/api_endpoints.dart';
import 'package:data_boot/core/connection/network.dart';
import 'package:data_boot/core/resources/data_state.dart';
import 'package:data_boot/data/dataSource/api_service.dart';

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