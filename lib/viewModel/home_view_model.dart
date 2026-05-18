import 'package:intl/intl.dart';

class HomeViewModel{

  String greeting(){
    final time = DateTime.now().hour;
    String greet;
    if(time <= 12){
      greet = 'Good Morning';
    }else
    {greet = 'Good Day';}
    return greet;
  }
//Account state
  int getState(percent) {
    final int index;
    if (percent < 70) {
      index = 0;
    } else {
      index = 1;
    }
    return index;
  }

  String formatMoney(double amount){
    final formatted = NumberFormat('#,##0.00').format(amount);
    return formatted;
  }



}