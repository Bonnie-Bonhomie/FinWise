import 'package:dio/dio.dart';
import 'package:fin_wise/core/connection/network.dart';
import 'package:fin_wise/data/dataSource/api_service.dart';
import 'package:fin_wise/data/models/AuthModel/user_model.dart';
import 'package:fin_wise/data/models/profile_model.dart';
import 'package:fin_wise/core/resources/data_state.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/Routes/Api_endpoints/api_endpoints.dart';

class AuthRepository {
  final ApiServices apiServices;
  final InternetInfo internetInfo;

  AuthRepository({required this.apiServices, required this.internetInfo});

  Future<DataState> registerUser({
    required String name,
    required String mail,
    required String dob,
    required String phone,
    required String password,
    required String confirmPassword,
  }) async {
    try{
    if (!await internetInfo.connected) {
      print('No internet');
      return DataFailed(
        DioException(
          requestOptions: RequestOptions(path: ''),
          error: "No Internet Connection",
        ),
      );
    }
    final response = await apiServices.postRequests(ApiEndpoints.register, {
      'name': name,
      'email': mail,
      'dob': dob,
      'phone': phone,
      'username': confirmPassword,
      'password': password,
    });
    // print('Response: ${response.data}');

      return DataSuccess(response.data);

    }
    on DioException catch (e){
      // print('Error: ${e.toString()}');
      return DataFailed(DioException(
        requestOptions: RequestOptions(),
        error:  e.toString(),
      ));
    }
  }

  Future<DataState> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      if (!await internetInfo.connected) {
        return DataFailed(
          DioException(
            requestOptions: RequestOptions(path: ''),
            error: "No Internet Connection",
          ),
        );
      }
      final response = await apiServices.postRequests(ApiEndpoints.login, {
        'email': email,
        'password': password,
      });
      return DataSuccess(response.data);
    } catch (e) {
      return DataFailed(
        DioException(
          requestOptions: RequestOptions(path: ''),
          error: e.toString(),
        ),
      );
    }
  }

  Future<DataState> verifyEmail({required int otp, required String email}) async {
    try {
      if (!await internetInfo.connected) {
        return DataFailed(
          DioException(
            requestOptions: RequestOptions(path: ''),
            error: "No Internet Connection",
          ),
        );
      }
      final response = await apiServices.postRequests(ApiEndpoints.verifyAcc, {
        'email': email,
        'token': otp,
      });
      return DataSuccess(response.data);
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
