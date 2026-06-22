import 'package:dio/dio.dart';
import 'package:fin_wise/core/Routes/Api_endpoints/api_endpoints.dart';
import 'package:fin_wise/core/connection/network.dart';
import 'package:fin_wise/data/dataSource/api_service.dart';
import 'package:fin_wise/core/resources/data_state.dart';

class HelpCenterRepo {
  final ApiServices apiServices;
  final InternetInfo internet;

  HelpCenterRepo(this.apiServices, this.internet);

  Future<DataState> getFaqs(String token, String type) async {

    try {

      if (!await internet.connected) {
        return DataFailed(
          DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.connectionError,
            error: 'No internet connection',
          ),
        );
      }
      final result = await apiServices.getRequestWIthToken('${ApiEndpoints.faqs}?type=$type', token);
      return DataSuccess(result.data);
    }on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
