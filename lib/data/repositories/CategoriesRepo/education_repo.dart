import 'package:dio/dio.dart';
import 'package:fin_wise/core/Routes/Api_endpoints/api_endpoints.dart';
import 'package:fin_wise/core/connection/network.dart';
import 'package:fin_wise/core/resources/data_state.dart';
import 'package:fin_wise/data/dataSource/api_service.dart';

class EducationRepo{

  final ApiServices services;
  final InternetInfo info;
  EducationRepo(this.services, this.info);

  Future<DataState> getEduCard(String token) async {
    try {
      if (!await info.connected) {
        return DataFailed(
          DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.connectionError,
            error: 'No internet connection',
          ),
        );
      }
      final result = await services.getRequestWIthToken(ApiEndpoints.examCard, token);
      return DataSuccess(result.data);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }


  Future<DataState> buyEduCard({required String transPin, required String phoneNumber, required String examId, required String token, required String profileCode}) async {
    try {
      if (!await info.connected) {
        return DataFailed(
          DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.connectionError,
            error: 'No internet connection',
          ),
        );
      }
      final result = await services.postRequestsWithToken(ApiEndpoints.buyEduCard, token, {
        'exam_id': examId,
        'phone_number': phoneNumber,
        'billers_code': profileCode,
        'transaction_pin': transPin,
      });
      return DataSuccess(result.data);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  Future<DataState> verifyEduCard({required String type, required String profileCode, required String examId, required String token}) async {
    try {
      if (!await info.connected) {
        return DataFailed(
          DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.connectionError,
            error: 'No internet connection',
          ),
        );
      }
      final result = await services.postRequestsWithToken(ApiEndpoints.verifyEduCard, token, {
        'service_id': examId,
        'billers_code': profileCode,
        'type': type,
      });
      return DataSuccess(result.data);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
