import 'package:dio/dio.dart';
import 'package:fin_wise/core/Routes/Api_endpoints/api_endpoints.dart';
import 'package:fin_wise/core/connection/network.dart';
import 'package:fin_wise/core/resources/data_state.dart';
import 'package:fin_wise/data/dataSource/api_service.dart';

class TelevisionRepo {
  final InternetInfo info;
  final ApiServices services;

  TelevisionRepo(this.services, this.info);

  Future<DataState> buyTv({required double amount, required int smartcard}) async {
    try {
      if (!await info.connected) {
        return DataFailed(
          DioException(
            requestOptions: RequestOptions(path: ''),
            error: 'No internet connection',
          ),
        );
      }
      final result = await services.postRequests(ApiEndpoints.buyTv, {
        'amount': amount,
        'number': smartcard,
      });
      return DataSuccess(result.data);
    } on DioException catch (e) {
      return DataFailed(
        DioException(
          requestOptions: RequestOptions(path: ''),
          error: e.toString(),
        ),
      );
    }
  }
}
