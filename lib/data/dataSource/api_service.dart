import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fin_wise/data/dataSource/dio_client.dart';

class ApiServices {
  final Dio mDio = DioClients.dio;
  final Dio dio = Dio();

  Future<Response> postRequests(
    String endPoint,
    Map<String, dynamic>? data,
  ) async {
    final response = await mDio.post(
      endPoint,
      data: data,
      options: Options(
        headers: {
          // 'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    return response;
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
          // 'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
    // print(response.data);
    return response;
  }

  Future<Response> getRequestWIthToken(
    String endpoint,
    String token, {
    Map<String, dynamic>? queryParam,
  }) async {
    final response = await mDio.get(
      endpoint,
      queryParameters: queryParam,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      ),
    );

    return response;
  }

  Future<Response> getRequest(String endpoint) async {
    final response = await mDio.get(
      endpoint,
      options: Options(headers: {'Accept': 'application/json'}),
    );
    return response;
  }

  Future<Response> getWIthUrlToken(
    String url,
    String token, {
    Map<String, dynamic>? queryParam,
  }) async {
    final response = await mDio.get(
      url,
      queryParameters: queryParam,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      ),
    );
    print(response.data);
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

  Future<Response> deleteRequestWIthToken(String endpoint, String token) async {
    final response = await mDio.delete(
      endpoint,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      ),
    );

    return response;
  }

  Future<Response> putRequestsWithToken(
    String endPoint,
    String token,
    Map<String, dynamic>? data,
  ) async {
    final response = await mDio.put(
      endPoint,
      data: data,
      options: Options(
        headers: {
          // 'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
    // print(response.data);
    return response;
  }
}
