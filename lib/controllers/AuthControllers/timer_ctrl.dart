import 'dart:async';

import 'package:get/get.dart';

class TimerCtrl extends GetxController{

  var seconds = 59.obs;
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
    seconds.value = 59;
    // _inCorrectCode = false;
  }
  void cancelTimer(){
    _timer?.cancel();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    _timer?.cancel();
    super.dispose();
  }

}