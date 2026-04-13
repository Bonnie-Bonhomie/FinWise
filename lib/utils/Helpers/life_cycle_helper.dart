import 'dart:async';

import 'package:fin_wise/core/Routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppLifeCycleHelper extends StatefulWidget {

  final Widget child;
  const AppLifeCycleHelper({super.key, required this.child});

  @override
  State<AppLifeCycleHelper> createState() => _AppLifeCycleHelperState();
}

class _AppLifeCycleHelperState extends State<AppLifeCycleHelper> with WidgetsBindingObserver {

  Timer? _timer;

  final Duration timeOut = const Duration(hours: 24);

  @override
  void initState() {

    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.paused){
      startTimer();
    }
    if(state == AppLifecycleState.resumed){
      _timer?.cancel();
    }
    super.didChangeAppLifecycleState(state);
  }
  void startTimer(){
    _timer?.cancel();
    _timer = Timer(timeOut, (){
      print(_timer);
      navigate();});
  }
  //Navigate to login screen after 30 seconds
  void navigate(){
    if(!mounted)return;

    Get.toNamed(Routes.login);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
