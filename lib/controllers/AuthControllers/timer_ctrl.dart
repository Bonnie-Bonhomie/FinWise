import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimerCtrl extends GetxController{

  var seconds = 30.obs;
  Timer? _timer;

  void startTimer(){
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer){
      if(seconds > 0){
        seconds--;
        // print(_seconds);
      }else{
        timer.cancel();
      }
    });
  }

  void resetTimer(){
    _timer?.cancel();
    seconds.value = 30;
    // _inCorrectCode = false;
  }
  void cancelTimer(){
    _timer?.cancel();
  }

  void validateOtp(BuildContext context, String text)async{
    if(text == '123456'){
      // VerifyDialog().verifiedDialog(context,  "Account created", () {
      //   Navigator.pushNamedAndRemoveUntil(context, AppRoutes.mainScreen, (routes)=> false);
      // });
    }else{
      // _inCorrectCode = true;
      text = '';
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer?.cancel();
    super.dispose();
  }

}