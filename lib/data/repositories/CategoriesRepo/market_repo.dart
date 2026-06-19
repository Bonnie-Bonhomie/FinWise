import 'package:dio/dio.dart';
import 'package:fin_wise/core/Routes/Api_endpoints/api_endpoints.dart';
import 'package:fin_wise/core/connection/network.dart';
import 'package:fin_wise/core/resources/data_state.dart';
import 'package:fin_wise/data/dataSource/api_service.dart';

class MarketRepo{

  final ApiServices services;
  final InternetInfo info;

  MarketRepo(this.services, this.info);

  Future<DataState> getProducts(String token, String category) async {
    try {
      if (!await info.connected) {
        return DataFailed(
          DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.connectionError,
            error: 'No internet connection',
          ),
        );
      } else {
        final result = await services.getRequestWIthToken('${ApiEndpoints.market}?category=$category', token);
        return DataSuccess(result.data);
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  Future<DataState> getSingle(String token, int id) async {
    try {
      if (!await info.connected) {
        return DataFailed(
          DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.connectionError,
            error: 'No internet connection',
          ),
        );
      } else {
        final result = await services.getRequestWIthToken('${ApiEndpoints.singleFish}/$id', token);
        return DataSuccess(result.data);
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  Future<DataState> buyProduct({required String token, required String productId, required String deliveryAdd, required String phoneNo, required String transPin, required String quantity}) async {
    try {
      if (!await info.connected) {
        return DataFailed(
          DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.connectionError,
            error: 'No internet connection',
          ),
        );
      } else {
        final result = await services.postRequestsWithToken(ApiEndpoints.buyFish, token, {
          'product_id': productId,
          'delivery_address': deliveryAdd,
          'quantity': quantity,
          'phone_number': phoneNo,
          'transaction_pin': transPin
        });
        return DataSuccess(result.data);
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}