import 'package:dio/dio.dart';
import 'package:data_boot/core/Routes/Api_endpoints/api_endpoints.dart';

class DioClients{

  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      receiveTimeout: Duration(seconds: 40),
      connectTimeout: Duration(seconds: 40),
    )
  );

}