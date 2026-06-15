import 'package:dio/dio.dart';
import 'package:fin_wise/core/resources/data_state.dart';
import 'package:fin_wise/data/dataSource/storage_file.dart';
import 'package:fin_wise/data/models/notification_model.dart';
import 'package:fin_wise/data/repositories/notification_repo.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../utils/utils_export.dart';

class NotifyCtrl extends GetxController{

  final NotificationRepo repo;
  final StorageFile store;

  NotifyCtrl(this.repo, this.store);

  @override
  onInit(){
    super.onInit();
    Future.microtask(() async{
      await getNotification();
    });
    // sortByDay();
  }

  List<NotifyModel> todayNote =[];
  List<NotifyModel> yesterNote =[];
  List<NotifyModel> otherNote= [];
  DateTime now = DateTime.now().toUtc();
  var isRead = false.obs;
  var notifications = <NotifyModel>[].obs;
  var noteErr = ''.obs;
  var deleteLoad = false.obs;
  var loading = false.obs;



  void markAsRead(index){
    isRead.value = true;
    update();
  }


  Future<void> deleteNotify(index, List list) async {
    print('Delete called');
    try{
      String? token = await store.getToken();
      if(token == null){
        CustomSnackbar.showSnackbar(message: 'Unauthenticated');
        return;
      }
      final response = await repo.deleteSingleNotify(token, index+1);
      print(response.data);
      if(response is DataSuccess){
        if(response.data['status'] == true){
          print('I worked');
          // list.removeAt(index);
          // update();

        }else{
          CustomSnackbar.showSnackbar(message: 'Unable to delete notifications');
        }
      }else if(response is DataFailed){
        final err = response.exception;

        if (err is DioException) {
          //  Network issues
          if (err.type == DioExceptionType.connectionError || err.type == DioExceptionType.connectionTimeout|| err.type == DioExceptionType.receiveTimeout) {
            CustomSnackbar.showSnackbar(title: 'No internet connection', message: 'Check your internet connection and try again' );
            return;
          }

          //  Server error
          final errData = err.response?.data;
          print(err.response?.data);

          if (errData != null && errData['message'] != null) {
            CustomSnackbar.showSnackbar(message: errData['message'].toString());
          } else {
            CustomSnackbar.showSnackbar(message: 'Unable to delete all notifications, try again later');
          }
        } else{
          CustomSnackbar.showSnackbar(message: 'Unable to delete all notifications, try again later');
        }
      }
    }catch(e){
      print(e);
      CustomSnackbar.showSnackbar(message: 'Unable to delete all notifications, try again later');
    }

  }



  ///Delete all Notification
  Future<void> deleteAll() async {
    try{
      deleteLoad.value = true;
        String? token = await store.getToken();
        if(token == null){
          CustomSnackbar.showSnackbar(message: 'Unauthenticated');
          return;
        }
        final response = await repo.deleteAllNotify(token);
        if(response is DataSuccess){
          if(response.data['status'] == true){
            notifications.clear();
            update();
            print(response.data);
          }else{
            CustomSnackbar.showSnackbar(message: 'Unable to delete notifications');
          }
        }else if(response is DataFailed){
          final err = response.exception;

          if (err is DioException) {
            //  Network issues
            if (err.type == DioExceptionType.connectionError || err.type == DioExceptionType.connectionTimeout) {
              CustomSnackbar.showSnackbar(title: 'No internet connection', message: 'Check your internet connection and try again' );
              return;
            }

            //  Server error
            final errData = err.response?.data;
            print(err.response?.data);

            if (errData != null && errData['message'] != null) {
              CustomSnackbar.showSnackbar(message: errData['message'].toString());
            } else {
              CustomSnackbar.showSnackbar(message: 'Unable to delete all notifications, try again later');
            }
          } else{
            CustomSnackbar.showSnackbar(message: 'Unable to delete all notifications, try again later');
          }
        }
    }catch(e){
      print(e);
      CustomSnackbar.showSnackbar(message: 'Unable to delete all notifications, try again later');
    }finally{
      deleteLoad.value = false;
    }

  }

  ///Get all Notification
  Future<void> getNotification() async {

    try{
      loading.value = true;
      final String? token = await store.getToken();
      if(token == null){
        noteErr.value = 'Unauthenticated';
        return;
      }

      final response = await repo.getNotification(token);
      print(response.data);
      if (response is DataSuccess) {
        final data = response.data;

        if (data['status'] == true) {

          List notes = data['data']['notifications'];

          final allNote = notes.map((e) => NotifyModel.fromJson(e)).toList();

          notifications.assignAll(allNote);


          if(notifications.isEmpty){
            noteErr.value = 'No notification for you';
          }
          sortByDay();
        } else {
          // backend handled inside success (if API returns 200 with status false)
         noteErr.value =  data['message'] ?? 'This is the error';
        }
      } else if (response is DataFailed) {
        final err = response.exception;

        if (err is DioException) {
          //  Network issues
          if (err.type == DioExceptionType.connectionError || err.type == DioExceptionType.connectionTimeout) {
            noteErr.value = 'No internet connection';
            return;
          }

          //  Server error
          final errData = err.response?.data;
          print(err.response?.data);

          if (errData != null && errData['message'] != null) {
            noteErr.value = errData['message'];
          } else {
            noteErr.value = 'Server error, reload page';
          }
        } else {
          noteErr.value = 'Unknown error occurred, reload page';
        }
      }
    }catch(e){
      print(e);
     noteErr.value = 'Something went wrong, reload page';
    }finally{
      loading.value = false;
    }
  } ///Get Notification

  void sortByDay(){
    DateTime today = DateTime(now.year, now.month, now.day);

    DateTime yesterday = today.subtract(Duration(days: 1));

    todayNote.clear();
    yesterNote.clear();
    otherNote.clear();


    DateTime toDate(String source){
      DateTime date = DateTime.parse(source);
      return date;
    }
    for(final note in notifications){


      if(isSameDay(toDate(note.date), today)){
        todayNote.add(note);
      }
      else if(isSameDay(toDate(note.date), yesterday)){
        yesterNote.add(note);
      }
      else{
        otherNote.add(note);
      }
    }
  }


}