import 'package:dio/dio.dart';
import 'package:data_boot/core/Routes/Api_endpoints/api_endpoints.dart';
import 'package:data_boot/core/connection/network.dart';
import 'package:data_boot/data/dataSource/api_service.dart';
import 'package:data_boot/core/resources/data_state.dart';

class AnalysisRepo {
  final ApiServices apiServices;
  final InternetInfo info;

  AnalysisRepo(this.apiServices, this.info);

  Future<DataState> dayAnalysis(String token) async {
    try {
      if (!await info.connected) {
        return DataFailed(
          DioException(
            requestOptions: RequestOptions(path: ''),
            error: 'No internet Connection',
          ),
        );
      }

      final dayAnls = await apiServices.getRequestWIthToken(
        ApiEndpoints.transact,
        token,
      );
      return DataSuccess(dayAnls.data);
    } catch (e) {
      return DataFailed(
        DioException(
          requestOptions: RequestOptions(path: ''),
          error: 'Failed load data',
        ),
      );
    }
  }
}
