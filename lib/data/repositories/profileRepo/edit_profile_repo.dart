import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fin_wise/core/Routes/Api_endpoints/api_endpoints.dart';
import 'package:fin_wise/core/connection/network.dart';
import 'package:fin_wise/data/dataSource/api_service.dart';
import 'package:fin_wise/data/dataSource/storage_file.dart';
import 'package:fin_wise/data_state.dart';
import 'package:get/get.dart';

class EditProfileRepo {
  final ApiServices api;
  final InternetInfo info;

  EditProfileRepo(this.api, this.info);

  Future<DataState> updateProfile({
    required String name,
    required String phone,
    required String dob,
    required String mail,
    File? img,
  }) async {
    try {
      if (!await info.connected) {
        return DataFailed(
          DioException(
            requestOptions: RequestOptions(path: ''),
            error: 'No internet Connection',
          ),
        );
      }

      final response = await api.updateProfile(
        endPoint: ApiEndpoints.profile,
        name: name,
        phone: phone,
        dob: dob,
        token: Get.find<StorageFile>(),
      );
      return DataSuccess(response.data);
    } catch (e) {
      if (e is DioException) {
        print('Upload failed: ${e.response?.data}');
      }
      return DataFailed(
        DioException(
          requestOptions: RequestOptions(),
          error: 'Failed to upload profile, $e',
        ),
      );
    }
  }
}
