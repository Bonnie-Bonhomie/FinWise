import 'package:dio/dio.dart';
import 'package:data_boot/core/Routes/Api_endpoints/api_endpoints.dart';
import 'package:data_boot/core/connection/network.dart';
import 'package:data_boot/data/dataSource/api_service.dart';
import 'package:data_boot/core/resources/data_state.dart';

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
