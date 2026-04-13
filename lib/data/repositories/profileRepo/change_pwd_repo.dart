import 'package:dio/dio.dart';
import 'package:fin_wise/core/Routes/Api_endpoints/api_endpoints.dart';
import 'package:fin_wise/core/connection/network.dart';
import 'package:fin_wise/data/dataSource/api_service.dart';
import 'package:fin_wise/core/resources/data_state.dart';

class ChangePwdRepo {
  final ApiServices apiServices;
  final InternetInfo internet;

  ChangePwdRepo(this.apiServices, this.internet);

  Future<DataState> submitPwd({
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
            error: 'No internet connection',
          ),
        );
      }
      final result = await apiServices.postRequestsWithToken(ApiEndpoints.changePwd,
          token,
          {
        'current_pwd': currentPwd,
        'new_pwd': newPwd,
        'confirm_pwd': confirmPwd,
      });
      return DataSuccess(result.data);
    } catch (e) {
      return DataFailed(
        DioException(
          requestOptions: RequestOptions(path: ''),
          error: 'Unable to change password: error ${e.toString()}',
        ),
      );
    }
  }
}
