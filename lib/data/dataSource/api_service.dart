import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fin_wise/data/dataSource/dio_client.dart';
import 'package:fin_wise/data_state.dart';

class ApiServices {
  final Dio mDio = DioClients.dio;

  Future<Response> postRequests(
    String endPoint,
    Map<String, dynamic>? data,
  ) async {
    final response = await mDio.post(
      endPoint,
      data: data,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    return response.data;
  }

  Future<Response> postRequestsWithToken(
      String endPoint,
      String token,
      Map<String, dynamic>? data,
      ) async {
    final response = await mDio.post(
      endPoint,
      data: data,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      ),
    );
    return response.data;
  }


  Future<Response> getRequest(
    String endpoint, String token,{
    Map<String, dynamic>? queryParam,
  }) async {
      final response = await mDio.get(
        endpoint,
        queryParameters: queryParam,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        }),
      );
      return response;

  }


  Future<Response> updateProfile({
    required String endPoint,
    required String name,
    required String phone,
    required String dob,
    File? profileImg,
    required token,
  }) async {
    final formData = FormData.fromMap({
      'name': name,
      'phone': phone,
      'dob': dob,
      if (profileImg != null)
        'profileImg': await MultipartFile.fromFile(
          profileImg.path,
          filename: profileImg.path.split('/').last,
        ),
    });

    final response = await mDio.post(
      endPoint,
      data: formData,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'multipart/form-data',
        },
      ),
    );

    return response;
  }
}
