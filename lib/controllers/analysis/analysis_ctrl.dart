import 'package:fin_wise/data/models/AuthModel/user_model.dart';
import 'package:fin_wise/data/repositories/analysis_repo.dart';
import 'package:get/get.dart';

import '../../core/constant.dart';
import '../../data/models/analysis_model.dart';

class AnalysisCtrl extends GetxController{

  final AnalysisRepo repo;
  AnalysisCtrl(this.repo);



  RxInt selectIndex = 0.obs;

  List<String> segmentTitle =['Daily', 'Weekly', 'Month', 'Year'].obs;

  // final UserModel user;
  final daily = <AnlysModel>[].obs;
  final weekly = <AnlysModel>[].obs;
  final monthly = <AnlysModel>[].obs;
  final yearly = <AnlysModel>[].obs;

  var selectPeriod = ChartPeriod.daily.obs;
  var expenseData = <double>[].obs;
  var incomeData = <double>[].obs;
  var bottomTitles = <String>[].obs;

  var today = DateTime.now();
  var focusDay = DateTime.now().obs;

  //

  final List<String> secHalf = ['Jul','Aug', 'Sept', 'Oct', 'Nov', 'Dec'];
  final List<String> firstHalf = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];

 @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    fetchChartData();
  }

  void changePeriod(ChartPeriod period){
    selectPeriod.value = period;
    fetchChartData();
  }

  void analysisData(){


  }

  void fetchChartData(){

    int month = today.month;

    switch (selectPeriod.value){
      case ChartPeriod.daily:
        expenseData.value =[1000, 2000, 13000, 4000, 5000, 4000,2000];
        incomeData.value= [3000,4000, 6000, 4000, 8000,9000,4000];
        bottomTitles.value = ['Mon', 'Tue', 'Wed', 'Thr', 'Fri', 'Sat', 'Sun'];
        break;

      case ChartPeriod.weekly:
        expenseData.value =[1000,7000, 1000, 15000];
        incomeData.value = [12000, 2000, 13000, 2000];
        bottomTitles.value = ['1st', '2nd', '3rd', '4th'];
        break;
      case ChartPeriod.monthly:
        expenseData.value =[12000, 3000, 4000, 5000, 15000, 4000];
        incomeData.value =[2000, 5000, 10000, 1000,700, 13000];
        if(month >= 6){ bottomTitles.value = firstHalf;}else{bottomTitles.value = secHalf;}
        break;
      case ChartPeriod.yearly:
        expenseData.value = [80000, 80000, 60000, 40000, 80000];
        incomeData.value = [50000, 70000, 40000, 60000, 100000];
        bottomTitles.value = ['2021', '2022', '2023', '2024', '2025'];
        break;
    }
  }




}