import 'package:dio/dio.dart';
import 'package:fin_wise/core/Routes/Api_endpoints/api_endpoints.dart';
import 'package:fin_wise/core/connection/network.dart';
import 'package:fin_wise/data/dataSource/api_service.dart';
import 'package:fin_wise/data/models/transaction_model.dart';
import 'package:fin_wise/data_state.dart';

class TransactionRepo {

  final ApiServices apiServices;
  final InternetInfo internetInfo;

  TransactionRepo({required this.internetInfo, required this.apiServices});

  Future<DataState> getTransact(String token) async {
    try {
      if (!await internetInfo.connected) {
        return DataFailed(DioException(requestOptions: RequestOptions(path: ''),
            error: "No Internet Connection"));
      }

      final transact = await apiServices.getRequest(
        ApiEndpoints.transact, //Url
        token,);
      return DataSuccess(TransactionModel.fromJson(transact.data));

    }on DioException catch (e) {
      return DataFailed(DioException(requestOptions: RequestOptions(path: ''),
          error: e.toString()));
    }
  }
}