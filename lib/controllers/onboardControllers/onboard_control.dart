
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/Routes/routes.dart';

class OnboardControl extends GetxController{

  Rx<int> dotNumber = 0.obs;
  var loading = false.obs;
  List<String> topText =[
    "Welcome to Expense Manager",
    "¿Are You Ready To Take Control Of Your Finances?"
  ];
  List<String> imagePath =[
    "Assets/images/onboard-1.png",
    "Assets/images/onboard-2.png"
  ];

  void nextPage(BuildContext context){
    if(dotNumber.value < 1){
     dotNumber.value =  dotNumber.value + 1;
    }
    else{
      loading.value = true;
      Future.delayed(Duration(seconds: 2));
      Navigator.popAndPushNamed(context, Routes.signIn);
    }
    loading.value = false;
  }
}