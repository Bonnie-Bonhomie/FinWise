import 'package:fin_wise/data/models/transaction_model.dart';
import 'package:get/get.dart';

class CalenderCtrl extends GetxController{



  final Map<DateTime, List<TransactionModel>> events = {};
  var focusDay = DateTime.now().obs;
  var lastDay = DateTime(2100).obs;
  var firstDay = DateTime(2000).obs;

  //Year Param
  var yC = 0.obs;
  var startY = 0.obs;
  var allYear = [].obs;
  var yIndex = 0.obs;
  var loading = false.obs;

  var focusedDate = DateTime.now().obs;
  var selectedDay = DateTime.now().obs;

  //Month Param
  var month = 0.obs;
  var startM = 0.obs;
  var now = DateTime.now();

  int s = 0;
  int y = 0;


  //For calender page
  @override
  void onReady() {
    // TODO: implement onInit
    super.onReady();
    getYe();
    currentY();
  }


  void getYe(){
    yC.value = (focusDay.value.year - 1);
    int i;
    for(i = 0; yC.value < 2100; i++ ){
      yC = yC++;
      allYear.add(yC.value);
    }
  }

  String currentY (){
    loading.value = true;
    final yn = allYear[yIndex.value].toString();
    // print(yn);
    loading.value = false;
    return yn;
  }

//Year Functions
  void selectYear (){
    startY.value = now.year;
     y= (yIndex.value);
    var slMont = DateTime(now.year +y ,now.month, now.day );
    print(y);
    focusedDate.value = slMont;
    print(slMont);

  }

//Month Logics

  void selectMth (){
     startM.value = now.month;
    s = (month.value + 1) - (startM.value);
    var slMont = DateTime(now.year + y,now.month + s, now.day );
    print(s);
    focusedDate.value = slMont;
   print(focusedDate);

  }
  String currentMonth (){
    final mth = months[focusedDate.value.month -1];
    return mth;
  }

  void onDaySelected(selectDay, focusDay){
    selectedDay.value = selectDay;
    focusedDate.value = focusDay;
  }
  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',].obs;


  //Events Loader
    DateTime normalize(DateTime day){
      return DateTime(day.year, day.month, day.day);
    }

    void loadTransactions (List<TransactionModel> trans){
      events.clear();
      for(var tx in trans){

        final day = normalize(tx.time);
        events.putIfAbsent(day, () => []);
        events[day]!.add(tx);
      }
      update();
  }

}