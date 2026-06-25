import 'package:dio/dio.dart';
import 'package:fin_wise/Services/device_info_service.dart';
import 'package:fin_wise/core/connection/network.dart';
import 'package:fin_wise/data/dataSource/api_service.dart';
import 'package:fin_wise/core/resources/data_state.dart';

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
    String referral = ''
  })
  async {
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
        'referid': referral,
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
  })
  async {
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
      final response = await apiServices.postRequests(ApiEndpoints.login, {
        'email': email,
        'password': password,
      });
      // print(response.data);
      return DataSuccess(response.data);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }//Login

  Future<DataState> verifyEmail({required int otp, required String email,}) async {
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
            type: DioExceptionType.connectionError,
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
  Future<DataState> setTransactPin({required int oldPin, required int newPin, required int cfmPin, required String token}) async {
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
      final response = await apiServices.postRequestsWithToken(ApiEndpoints.transactPin, token,{
        'newpin': newPin,
        'cnewpin': cfmPin,
        'oldpin': oldPin,
      });
      return DataSuccess(response.data);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }  // Transaction pin

  //Log out function
  Future<String> logOut(String token) async {
    try {
      if (!await internetInfo.connected) {
        return 'No internet connection';
      }
      final response = await apiServices.getRequestWIthToken(ApiEndpoints.logOut, token);
      if(response.statusCode == 200){
        return 'Log out successfully';
      }return 'Something went wrong';

    } catch (e) {
      return e.toString();
    }
  }  //Logout function

  Future<DataState> forgetPwd({required String email}) async {
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
      final response = await apiServices.postRequests(ApiEndpoints.forgetPwd, {
        'email': email
      });
      return DataSuccess(response.data);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }  // forget password

  Future<DataState> verifyPwd({required String email, required int token}) async {
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
      final response = await apiServices.postRequests(ApiEndpoints.verifyPwd, {
        'email': email,
        'token': token,
      });
      return DataSuccess(response.data);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }  // forget password


  Future<DataState> updatePwd({required String email, required int token, required String pwd}) async {
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
      final response = await apiServices.postRequests(ApiEndpoints.updatePwd, {
        'email': email,
        'token': token,
        'password': pwd,
      });
      return DataSuccess(response.data);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }  // forget password



  Future<void> updateDeviceToken(String fireToken, String token) async {

    final device = await getDeviceInfo();


      final response = await apiServices.postRequestsWithToken(
        ApiEndpoints.deviceToken,
        token,
        {
          'device_token': fireToken,
          'device_type': device['deviceType'],
          'device_name': device['deviceName'],
        },
      );
      print(response.data);

  }
}

// if(response.statusCode == 200){
//   return DataSuccess(response.data);
// }
// else{
//   return DataFailed(DioException(requestOptions: RequestOptions(), error: 'Something went wrong'));
// }
