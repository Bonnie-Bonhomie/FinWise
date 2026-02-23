import 'package:dio/dio.dart';
import 'package:fin_wise/core/Routes/Api_endpoints/api_endpoints.dart';

class DioClients{

  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      receiveTimeout: Duration(seconds: 20),
      connectTimeout: Duration(seconds: 20),
    )
  );

}