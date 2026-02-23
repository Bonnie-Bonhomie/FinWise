
import 'dart:io';
import 'package:fin_wise/views/analysisViews/analysis_view.dart';
import 'package:fin_wise/views/categories/categories.dart';
import 'package:fin_wise/views/categories/screens/category_page.dart';
import 'package:fin_wise/views/home/home.dart';
import 'package:fin_wise/views/profiles/screens/edit&view/profile.dart';
import 'package:fin_wise/views/profiles/screens/edit&view/profile_view.dart';

import 'package:fin_wise/views/transaction/transaction_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../core/app_colors.dart';

class NavControl extends GetxController{

  final Rx<int> selectInd = 0.obs;


  bool changColor(index){
    icons[selectInd.value] == index;
    return false;
  }
// Bottom navigation bar function
  List<Widget> screens =[
    HomePage(),
    AnalysisPage(),
    TransactionView(),
    CategoryPage(),
    Profiles(),

  ];


  List<IconData> icons =[Icons.home_outlined, Icons.analytics_outlined, Icons.wifi_protected_setup, Icons.layers_outlined, Icons.person_outline_outlined];


  // OnWillPop control function

  DateTime? whenPressed;
  Future<bool> willPopHandler() async{

    final now = DateTime.now();
    if(whenPressed == null || now.difference(whenPressed!) > Duration(seconds: 2)){
      whenPressed = now;

      Fluttertoast.showToast(msg: "Press again to exit", backgroundColor: AppColors.primary);
      return false;
    }

    return true;
  }

}

