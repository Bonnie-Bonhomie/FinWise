import 'package:dio/dio.dart';
import 'package:fin_wise/core/Routes/Api_endpoints/api_endpoints.dart';
import 'package:fin_wise/core/connection/network.dart';
import 'package:fin_wise/data/dataSource/api_service.dart';
import 'package:fin_wise/data_state.dart';

class ChangePinRepo {
  final ApiServices apiServices;
  final InternetInfo info;

  ChangePinRepo(this.apiServices, this.info);

  Future<DataState> changePin({
    required String currentPin,
    required String newPin,
    required String confirmPin,
    required String token,
  }) async {
    try {
      if (!await info.connected) {
        return DataFailed(
          DioException(
            requestOptions: RequestOptions(path: ''),
            error: 'No internet connection',
          ),
        );
      }

      final result = await apiServices.postRequestsWithToken(ApiEndpoints.changePin,  token, {
        'current_pin': currentPin,
        'new_pin': newPin,
        'confirm_pin': confirmPin,
      });

      return DataSuccess(result.data);
    } catch (e) {
      return DataFailed(
        DioException(
          requestOptions: RequestOptions(path: ''),
          error: e.toString(),
        ),
      );
    }
  }
}
