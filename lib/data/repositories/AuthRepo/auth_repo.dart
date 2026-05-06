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

  //Register function
  Future<DataState> registerUser({
    required String name,
    required String mail,
    required String dob,
    required String phone,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      if (!await internetInfo.connected) {

        return DataFailed(
          DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.connectionError,
            error: "No Internet Connection",
          ),
        );
      }
      final response = await apiServices.postRequests(ApiEndpoints.register, {
        'name': name,
        'email': mail,
        'dob': dob,
        'phone': phone,
        'username': name,
        'password': password,
      });
      return DataSuccess(response.data);
    } on DioException catch (e) {
      print(e.response?.data);
      //Passing the real error by returning DataFailed(e)
      return DataFailed(e);
    }
  }
  //Register function end

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
      return DataSuccess(ProfileModel.fromJson(response.data));
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  Future<DataState> verifyEmail({
    required int otp,
    required String email,
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
      final response = await apiServices.postRequests(ApiEndpoints.verifyAcc, {
        'email': email,
        'token': otp,
      });
      return DataSuccess(response.data);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }//Verify Email

//Resend OTP function
  Future<DataState> resendOtp({required String email,}) async {
    try {
      if (!await internetInfo.connected) {
        return DataFailed(
          DioException(
            requestOptions: RequestOptions(path: ''),
            error: "No Internet Connection",
          ),
        );
      }
      final response = await apiServices.getRequest('${ApiEndpoints.resendOtp}/$email');
      return DataSuccess(response.data);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  } // Resend OTP function

  //Transaction Pin function
  Future<DataState> setTransactPin({required int pin,}) async {
    try {
      if (!await internetInfo.connected) {
        return DataFailed(
          DioException(
            requestOptions: RequestOptions(path: ''),
            error: "No Internet Connection",
          ),
        );
      }
      final response = await apiServices.postRequests(ApiEndpoints.transactPin, {
        'pin': pin,
      });
      return DataSuccess(response.data);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }  // Transaction pin

  //Log out function
  Future<DataState> logOut() async {
    try {
      if (!await internetInfo.connected) {
        return DataFailed(
          DioException(
            requestOptions: RequestOptions(path: ''),
            error: "No Internet Connection",
          ),
        );
      }
      final response = await apiServices.getRequest(ApiEndpoints.logOut );
      return DataSuccess(response.data);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }  //Logout function

}

// if(response.statusCode == 200){
//   return DataSuccess(response.data);
// }
// else{
//   return DataFailed(DioException(requestOptions: RequestOptions(), error: 'Something went wrong'));
// }
