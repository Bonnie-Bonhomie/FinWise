import 'package:dio/dio.dart';
import 'package:fin_wise/core/Routes/routes.dart';
import 'package:fin_wise/core/constant.dart';
import 'package:fin_wise/core/resources/data_state.dart';
import 'package:fin_wise/data/dataSource/storage_file.dart';
import 'package:fin_wise/data/models/product_model.dart';
import 'package:fin_wise/data/models/transaction_model.dart';
import 'package:fin_wise/data/repositories/CategoriesRepo/market_repo.dart';
import 'package:fin_wise/utils/utils_export.dart';
import 'package:fin_wise/viewModel/home_view_model.dart';
import 'package:get/get.dart';

class MarketCtrl extends GetxController{

  final MarketRepo repo;
  final StorageFile store;

  MarketCtrl(this.repo, this.store);

  final HomeViewModel viewModel = HomeViewModel();
  List<String> categories = ['All', 'Fish'];

  RxString productErr = ''.obs;
  var loadingProd = false.obs;
  String category = 'fish';
  var fishProduct = <ProductModel>[].obs;

  Future<void> getProducts() async{
   try{
     String? token = await store.getToken();
     if(token == null){
       productErr.value = 'Unauthenticated';
       return;
     }

     final response = await repo.getProducts(token, category);
     if(response is DataSuccess){
       if(response.data['status'] == true){
         final data = response.data['data'];
         List products = data['data'];

         if(products.isEmpty){
           productErr.value = 'Fish products is not available';
         }else{
           final prod = products.map((e) => ProductModel.fromJson(e)).toList();
           fishProduct.assignAll(prod);
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


  Future<void> getSingleProduct(int id) async{
    try{
      loadingProd.value = true;
      String? token = await store.getToken();
      if(token == null){
        productErr.value = 'Unauthenticated';
        return;
      }

      final response = await repo.getSingle(token, id);
      if(response is DataSuccess){
        if(response.data['status'] == true){
          final data = response.data['data'];
          print(data);
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
    }catch(e){
      print(e);
      productErr.value = 'Unknown err occur';
    }finally {
      loadingProd.value = false;
    }
  } ///Get product by id

  Future<void> buyProduct({required String productId, required String deliveryAdd, required String phone, required int quantity, required String pin}) async{
    try{
      String? token = await store.getToken();
      if(token == null){
       CustomSnackbar.showSnackbar(message: 'Unauthenticated');
        return;
      }
      String phoneNo = viewModel.numberBack(phone);

      final response = await repo.buyProduct(token: token, productId: productId, deliveryAdd: deliveryAdd, phoneNo: phoneNo, transPin: pin, quantity: quantity.toString());
      if(response is DataSuccess){
        if(response.data['status'] == true){
          final data = response.data['data'];

          TransactionModel receipt = TransactionModel.fromJson(data);
          if (receipt.apiStatus == TransactionStatus.failed) {
            CustomSnackbar.showSnackbar(
                message: 'Unable to complete transaction, try again later');
          } else {
            Get.toNamed(Routes.transSuccess, arguments: receipt);
          }
          print(data);
        }
      }else if (response is DataFailed){
        final err = response.exception;
        if(err is DioException){
          if(err.type ==DioExceptionType.connectionError || err.type == DioExceptionType.connectionTimeout || err.type == DioExceptionType.receiveTimeout){
            CustomSnackbar.showSnackbar(message: 'Check your internet connection', title: 'No internet connection');
          }
          final errData = err.response?.data;
          if(errData != null && errData['message'] != null){
            CustomSnackbar.showSnackbar(message: errData['message']);
          }
        }else{
          CustomSnackbar.showSnackbar(message: 'Server error, try again later');
        }
      }
    }catch(e){
      print(e);
      CustomSnackbar.showSnackbar(message: 'Unknown err occur, ty again later');
    }
  }

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