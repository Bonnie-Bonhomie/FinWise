import 'package:dio/dio.dart';
import 'package:fin_wise/core/Routes/Api_endpoints/api_endpoints.dart';
import 'package:fin_wise/core/connection/network.dart';
import 'package:fin_wise/core/resources/data_state.dart';
import 'package:fin_wise/data/dataSource/api_service.dart';

class AirtimeRepository {
  final ApiServices services;
  final InternetInfo info;

  AirtimeRepository(this.services, this.info);

  Future<DataState> buyAirtime({
    required double amount,
    required int number,
  }) async {
    try {
      if (!await info.connected) {
        return DataFailed(
          DioException(
            requestOptions: RequestOptions(path: ''),
            error: 'No internet connection',
          ),
        );
      } else {
        final result = await services.postRequests(ApiEndpoints.buyAirtime, {
          'amount': amount,
          'number': number,
        });
        return DataSuccess(result.data);
      }
    } catch (e) {
      return DataFailed(
        DioException(
          requestOptions: RequestOptions(path: ''),
          error: 'Something went wrong ${e.toString()}',
        ),
      );
    }
  }
}
