
import 'package:fin_wise/core/constant.dart';
import 'package:fin_wise/data/models/numbers_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryNavCtrl extends GetxController{


  var amountCtrl = TextEditingController().obs;
  var cleared = false.obs;
  var hasText = false.obs;
  var addBeneficiary = false.obs;
  var selectProvider = ServiceProvider.glo.obs;

  var allNumbers = [
    NumbersModel(provider: ServiceProvider.glo, number: '07067890967', amount: 0),
    NumbersModel(provider: ServiceProvider.glo, number: '08067543678', amount: 0),
    NumbersModel(provider: ServiceProvider.mtn, number:'09034092345', amount: 0),
    NumbersModel(provider: ServiceProvider.airtel, number: '09075789045', amount: 0),
  ].obs;

  bool checkProvider(text){
    if(text.length.substring(9,13) == 5656)return true;
    return false;
  }

  void addNumber(){

  }

  void deleteBene(index){
    allNumbers.removeAt(index);
    update();
  }
  void addBene(NumbersModel element){
    if(allNumbers.contains(element))return;
    else{
      allNumbers.add(element);
      update();
    }
  }
 void deleteAllBene(){
    allNumbers.clear();
    update();
 }

  void addBeneficiaries(List list, element){
    if(!list.contains(element)){
      list.add(element);
      update();
    }
  }

}