import 'package:dio/dio.dart';
import 'package:fin_wise/core/connection/network.dart';
import 'package:fin_wise/data/dataSource/api_service.dart';
import 'package:fin_wise/data/models/AuthModel/user_model.dart';
import 'package:fin_wise/data/models/profile_model.dart';
import 'package:fin_wise/data_state.dart';

import '../../../core/Routes/Api_endpoints/api_endpoints.dart';

class AuthRepository{

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
  }) async{
    try{
      if (!await internetInfo.connected) {
        return DataFailed(DioException(requestOptions: RequestOptions(path: ''),
            error: "No Internet Connection"));
      }
      final response = await apiServices.postRequests(ApiEndpoints.register, {
        'name': name,
        'mail': mail,
        'dob': dob,
        'phone': phone,
        'password': password,
        'confirmPwd': confirmPassword,
      });
      return DataSuccess(ProfileModel.fromJson(response.data));
    } catch (e){
      return DataFailed(DioException(
        requestOptions: RequestOptions(),
        error:  e.toString(),
      ));
    }
  }

  Future<DataState> loginUser({
    required String mail,
    required String password,
  }) async{
    try {
      final response = await apiServices.postRequests(ApiEndpoints.login, {
        'mail': mail,
        'password': password,
      });
      return DataSuccess(ProfileModel.fromJson(response.data));
    } catch(e){
      return DataFailed(DioException(requestOptions: RequestOptions(
        path: ''),
        error: e.toString()
      ));
    }
  }


}