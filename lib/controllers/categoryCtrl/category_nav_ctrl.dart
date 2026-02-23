
import 'package:fin_wise/core/constant.dart';
import 'package:fin_wise/data/models/numbers_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryNavCtrl extends GetxController{

  var selected = ServiceProvider.glo.label.obs;
  var amountCtrl = TextEditingController().obs;
  var cleared = false.obs;
  var hasText = false.obs;

  var allNumbers = [
    AirtimeModel(provider: ServiceProvider.glo, number: 07067890967, id: '6'),
    AirtimeModel(provider: ServiceProvider.glo, number: 08067543678, id: '5'),
    AirtimeModel(provider: ServiceProvider.mtn, number: 09034092345, id: '7'),
    AirtimeModel(provider: ServiceProvider.airtel, number: 09075789045, id: '9'),
  ].obs;

  void deleteNumber(index){
    allNumbers.removeAt(index);
    update();
  }
}