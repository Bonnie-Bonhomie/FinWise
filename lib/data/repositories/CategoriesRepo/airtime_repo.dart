import 'package:dio/dio.dart';
import 'package:data_boot/core/Routes/Api_endpoints/api_endpoints.dart';
import 'package:data_boot/core/connection/network.dart';
import 'package:data_boot/core/resources/data_state.dart';
import 'package:data_boot/data/dataSource/api_service.dart';

class AirtimeRepository {
  final ApiServices services;
  final InternetInfo info;

  AirtimeRepository(this.services, this.info);

  Future<DataState> buyAirtime({
    required double amount,
    required String number,
    required String networkId,
    required String token,
    required String transPin,
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
      } else {
        final result = await services.postRequestsWithToken(ApiEndpoints.buyAirtime, token, {
          'AirtimeAmount': amount,
          'AirtimePhone': number,
          'airtimeNetId': networkId,
          'transaction_pin': transPin
        });
        return DataSuccess(result.data);
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  Future<DataState> airtimeNetwork(String token) async {
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
        final result = await services.getRequestWIthToken(ApiEndpoints.airtimeNetwork, token);
        return DataSuccess(result.data);
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
