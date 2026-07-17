import 'package:dio/dio.dart';
import 'package:data_boot/core/resources/data_state.dart';
import 'package:data_boot/data/dataSource/storage_file.dart';
import 'package:data_boot/data/repositories/CategoriesRepo/market_repo.dart';
import 'package:get/get.dart';

import '../../data/models/product_model.dart';

class SolarCtrl extends GetxController{

  final MarketRepo repo;
  final StorageFile store;

  SolarCtrl(this.repo,this.store);
  RxString productErr = ''.obs;
  var solarProduct = <ProductModel>[].obs;
  var loadingProd = false.obs;

  Future<void> getProducts() async{
    try{
      String? token = await store.getToken();
      if(token == null){
        productErr.value = 'Unauthenticated';
        return;
      }

      final response = await repo.getProducts(token, 'solar');
      if(response is DataSuccess){
        if(response.data['status'] == true){
          final data = response.data['data'];
          print(data);
          List products = data['data'];

          if(products.isEmpty){
            productErr.value = 'Fish products is not available';
          }else{
            final prod = products.map((e) => ProductModel.fromJson(e)).toList();
            solarProduct.assignAll(prod);
          }

        }
      }else if (response is DataFailed){
        final err = response.exception;
        if(err is DioException){
          if(err.type ==DioExceptionType.connectionError || err.type == DioExceptionType.connectionTimeout || err.type == DioExceptionType.receiveTimeout){
            productErr.value = 'No internet connection';
          }
          final errData = err.response?.data;
          if(errData != null && errData['message'] != null){
            productErr.value = errData['message'];
          }
        }else{
          productErr.value = 'Server error, reload page';
        }
      }
    }catch(e) {
      print(e);
      productErr.value = 'Unknown err occur';
    }
  } ///Get available products



  Future<void> loadFresh() async {
    try{
      loadingProd.value = true;
      await getProducts();
    }catch(e){
      print(e);
    }finally{
      loadingProd.value = false;
    }
  }
}