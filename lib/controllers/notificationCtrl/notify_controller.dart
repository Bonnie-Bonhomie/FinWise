import 'package:fin_wise/data/models/notification_model.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class NotifyCtrl extends GetxController{
  @override
  onInit(){
    super.onInit();
    sortByDay();
  }

  List<NotifyModel> todayNote =[];
  List<NotifyModel> yesterNote =[];
  List<NotifyModel> otherNote= [];
  DateTime now = DateTime.now().toUtc();
  var isRead = false.obs;




  // void filterByDate(DateTime date){
  //   todayNote = notifications.where((e) => isSameDay(e.date, date)).toList();
  //   update();
  // }
  void sortByDay(){
    DateTime today = DateTime(now.year, now.month, now.day);

    DateTime yesterday = today.subtract(Duration(days: 1));

    todayNote.clear();
    yesterNote.clear();
    otherNote.clear();

    for(final note in notifications){

      if(isSameDay(note.date, today)){
        todayNote.add(note);
      }
      else if(isSameDay(note.date, yesterday)){
        yesterNote.add(note);
      }
      else{
        otherNote.add(note);
      }
    }
  }


  void deleteNotify(index, List list){
    list.removeAt(index);
    update();
  }

  void deleteAll(){
    notifications.clear();
    update();
  }
  void markAsRead(index, List list){
    list[index];
    isRead.value = true;
    update();
  }

  var notifies = <NotifyModel>[].obs;


      List<NotifyModel> notifications =[
    NotifyModel(id: '2', title: 'Reminder', description: 'This the new reminder for you, This the new reminder for you, This the new reminder for you', date: DateTime(2026,2,1,10,10)),
    NotifyModel(id: '3', title: 'Alert', description: 'This the new reminder for you, This the new reminder for you,This the new reminder for you', date: DateTime.now()),
    NotifyModel(id: '5', title: 'New Update', description: 'This the new reminder for you, This the new reminder for you,This the new reminder for you', date: DateTime.now()),
    NotifyModel(id: '6', title: 'Transaction', description: 'This the new reminder for you, This the new reminder for you,This the new reminder for you', date: DateTime(2026,1,2,10,7)),
    NotifyModel(id: '7', title: 'expense Warning', description: 'This the new reminder for you, This the new reminder for you,This the new reminder for you,', date: DateTime(2026,2,4,10,7)),
    NotifyModel(id: '8', title: 'Reminder', description: 'This the new reminder for you, This the new reminder for you,This the new reminder for you', date: DateTime(2026,2,3,10,7)),

  ].obs;


}