import 'package:dio/dio.dart';
import 'package:fin_wise/core/Routes/Api_endpoints/api_endpoints.dart';
import 'package:fin_wise/core/connection/network.dart';
import 'package:fin_wise/core/resources/data_state.dart';
import 'package:fin_wise/data/dataSource/api_service.dart';

class VirtualRepo{
  final ApiServices services;
  final InternetInfo info;
VirtualRepo(this.services, this.info);

  Future<DataState> generateVirtual({
    required String fullname,
    required String bvn,
    required String phoneNumber,
    required dob,
}) async{
    try{
      if(!await info.connected){
        return DataFailed(DioException(requestOptions: RequestOptions(path: ''), error: 'No internet connection'));
      }
      final result = await services.postRequests(ApiEndpoints.virtual, {
        'fullName': fullname,
        'bvn':bvn,
        'phoneNumber': phoneNumber,
        'dob': dob,
      });
      return DataSuccess(result.data);
    }on DioException catch(e){
      return DataFailed(DioException(requestOptions: RequestOptions(path: ''), error: e.toString()));
    }
  }

}