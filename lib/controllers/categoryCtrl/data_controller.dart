import 'package:fin_wise/data/models/data_model.dart';
import 'package:get/get.dart';

class DataController extends GetxController{

  var sections = ['HotUp', 'Daily', 'Weekly', 'Monthly'];

  var hotUp = [
    DataPlan(name: '7', days: 'GB', uid: '10', price: 3500, type: 'GB'),
    DataPlan(name: '8', days: '30 days', uid: '10', price: 3700, type: 'GB'),
    DataPlan(name: '6', days: '7 days', uid: '10', price: 3000, type: 'GB'),
    DataPlan(name: '4', days: '3 day', uid: '10', price: 1500, type: 'GB'),
    DataPlan(name: '10', days: '7 days', uid: '10', price: 5000, type: 'GB'),

    DataPlan(name: '8', days: '30 days', uid: '10', price: 3700, type: 'GB'),
    DataPlan(name: '6', days: '7 days', uid: '10', price: 3000, type: 'GB'),
    DataPlan(name: '4', days: '3 day', uid: '10', price: 1500, type: 'GB'),
    DataPlan(name: '10', days: '7 days', uid: '10', price: 5000, type: 'GB'),

  ].obs;

  var weekly = [
    DataPlan(name: '7', days: '7 days', uid: '10', price: 3500, type: 'GB'),
    DataPlan(name: '10', days: '7 days', uid: '10', price: 5000, type: 'GB'),
    DataPlan(name: '8', days: '7 days', uid: '10', price: 4500, type: 'GB'),
    DataPlan(name: '10', days: '14 days', uid: '10', price: 5500, type: 'GB'),
    DataPlan(name: '9', days: '7 days', uid: '10', price: 5000, type: 'GB'),
    DataPlan(name: '15', days: '14 days', uid: '10', price: 6000, type: 'GB'),
  ].obs;
  var daily = [
    DataPlan(name: '1', days: 'Daily', uid: '20', price: 350, type: 'GB'),
    DataPlan(name: '2', days: 'Daily', uid: '20', price: 350, type: 'GB'),
    DataPlan(name: '1', days: 'Daily', uid: '20', price: 350, type: 'GB'),
    DataPlan(name: '500', days: 'Daily', uid: '20', price: 350, type: 'MB'),
    DataPlan(name: '1', days: 'Daily', uid: '20', price: 350, type: 'GB'),
  ];

}