import 'dart:io';

import 'package:dio/dio.dart';
import 'package:data_boot/core/Routes/Api_endpoints/api_endpoints.dart';
import 'package:data_boot/core/connection/network.dart';
import 'package:data_boot/data/dataSource/api_service.dart';
import 'package:data_boot/core/resources/data_state.dart';

class EditProfileRepo {
  final ApiServices api;
  final InternetInfo info;

  EditProfileRepo(this.api, this.info);

  Future<DataState> getProfile(String token) async {
    try {
      if (!await info.connected) {
        return DataFailed(
          DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.connectionError,
            error: 'No internet Connection',
          ),
        );
      }

      final response = await api.getRequestWIthToken(ApiEndpoints.profile, token);
      return DataSuccess(response.data);
    } on DioException catch(e){
      return DataFailed(e);
    }
  }

  Future<DataState> getReferrals(String token) async {
    try {
      if (!await info.connected) {
        return DataFailed(
          DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.connectionError,
            error: 'No internet Connection',
          ),
        );
      }

      final response = await api.getRequestWIthToken(ApiEndpoints.referralList, token);
      return DataSuccess(response.data);
    } on DioException catch(e){
      return DataFailed(e);
    }
  }


  Future<DataState> updateProfile({
    required String name,
    required String phone,
    required String dob,
    required String mail,
    required String token,
    File? img,
  }) async {
    try {
      if (!await info.connected) {
        return DataFailed(
          DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.connectionError,
            error: 'No internet Connection',
          ),
        );
      }

      final response = await api.updateProfile(
        endPoint: ApiEndpoints.profile,
        name: name,
        phone: phone,
        dob: dob,
        token: token,
      );
      return DataSuccess(response.data);
    } on DioException catch(e){
      return DataFailed(e);
    }
  }
}
