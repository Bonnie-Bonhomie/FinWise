import 'package:dio/dio.dart';
import 'package:fin_wise/core/Routes/Api_endpoints/api_endpoints.dart';
import 'package:fin_wise/core/connection/network.dart';
import 'package:fin_wise/data/dataSource/api_service.dart';
import 'package:fin_wise/core/resources/data_state.dart';

class ChangePwdRepo {
  final ApiServices apiServices;
  final InternetInfo internet;

  ChangePwdRepo(this.apiServices, this.internet);

  Future<DataState> changePwd({
    required String currentPwd,
    required String newPwd,
    required String confirmPwd,
    required String token,
  }) async {

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
      final result = await apiServices.putRequestsWithToken(ApiEndpoints.changePwd,
          token,
          {
        'old_password': currentPwd,
        'new_password': newPwd,
        'confirm_new_password': confirmPwd,
      });
      return DataSuccess(result.data);
    }on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
