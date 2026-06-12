import 'package:dio/dio.dart';
import 'package:fin_wise/core/Routes/Api_endpoints/api_endpoints.dart';
import 'package:fin_wise/core/connection/network.dart';
import 'package:fin_wise/core/resources/data_state.dart';

import '../dataSource/api_service.dart';

class NotificationRepo{

  final ApiServices service;
  final InternetInfo internet;

  NotificationRepo(this.service, this.internet);

  Future<DataState> getNotification(String token) async {
    try {
      if (!await internet.connected) {

        return DataFailed(
          DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.connectionError,
            error: "No Internet Connection",
          ),
        );
      }
      final response = await service.getRequestWIthToken(ApiEndpoints.notification, token);
      return DataSuccess(response.data);
    } on DioException catch (e) {
      print(e.response?.data);
      //Passing the real error by returning DataFailed(e)
      return DataFailed(e);
    }
  }

}