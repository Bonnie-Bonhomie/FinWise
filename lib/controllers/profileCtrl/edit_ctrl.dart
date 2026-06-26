import 'dart:io';
import 'dart:nativewrappers/_internal/vm/lib/convert_patch.dart';

import 'package:dio/dio.dart';
import 'package:fin_wise/controllers/loader_contrl.dart';
import 'package:fin_wise/core/resources/data_state.dart';
import 'package:fin_wise/core/resources/storage_keys.dart';
import 'package:fin_wise/data/dataSource/storage_file.dart';
import 'package:fin_wise/data/models/profile_model.dart';
import 'package:fin_wise/data/repositories/profileRepo/edit_profile_repo.dart';
import 'package:fin_wise/utils/Helpers/share_prefer_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/utils_export.dart';

class EditProfileCtrl extends GetxController{

  final EditProfileRepo repo;
  final StorageFile store;
  final SharedPreferService storage;
  EditProfileCtrl(this.repo, this.store, this.storage);

  @override
  void onInit() {
    // TODO: implement onInit
    getProfile();
    getSavedPro();
    super.onInit();
  }

  final nameCtrl = TextEditingController();
  final numberCtrl = TextEditingController();
  final dobCtrl = TextEditingController();
  final mailCtrl = TextEditingController();
  ProfileModel? userProfile;
  RxString profileErr = ''.obs;

  Rxn<ProfileModel> profile = Rxn<ProfileModel>();

  var loading = false.obs;
  RxString name = ''.obs;
  RxString email = ''.obs;
  RxString phone = ''.obs;

  RxString referralErr = ''.obs;
  var loadRef = false.obs;
  var referralList = <ReferModel>[].obs;

  void getSavedPro() async{
    name.value =  await storage.retrieve(PrefStoreKeys.username);
    email.value =  await storage.retrieve(PrefStoreKeys.mail);
    phone.value =  await storage.retrieve(PrefStoreKeys.phone);
  }

  Future<void> getProfile() async {
    try{
      loading.value = true;
      final String? token = await store.getToken();
      if (token == null) {
        CustomSnackbar.showSnackbar(message: 'Unauthenticated');
      } else {
        final response = await repo.getProfile(token);
        print(response.data);
        if (response is DataSuccess) {
          final data = response.data;

          if (data['status'] == true) {

            userProfile = ProfileModel.fromJson(data['data']['user']);
            setProfile(userProfile);

          } else {
            // backend handled inside success (if API returns 200 with status false)

          }
        } else if (response is DataFailed) {
          final err = response.exception;

          if (err is DioException) {
            //  Network issues
            if (err.type == DioExceptionType.connectionError ||
                err.type == DioExceptionType.receiveTimeout ||
                err.type == DioExceptionType.connectionTimeout) {
              CustomSnackbar.showSnackbar(title: 'No internet connection', message: 'Check your internet connection');
            return;
            }

            //  Server error
            final errData = err.response?.data;

            if (errData != null && errData['message'] != null) {
              CustomSnackbar.showSnackbar(message: errData['message']);
            } else {
              CustomSnackbar.showSnackbar(
                message: 'Server error, try again later,',
              );
              return;
            }
          } else {
            CustomSnackbar.showSnackbar(message: 'Unknown error occurred, try again later.');
          }
        }
      }
    }catch(e){
      print(e);
      CustomSnackbar.showSnackbar(message: 'Unknown error occurred, try again later.');
    }
    loading.value = false;
  }


  Future<void> getReferrals() async {
    try{
      loadRef.value = true;
      final String? token = await store.getToken();
      if (token == null) {
        CustomSnackbar.showSnackbar(message: 'Unauthenticated');
      } else {
        final response = await repo.getReferrals(token);

        print(' Referral Response: ${response.data}');
        if (response is DataSuccess) {


          if (response.data['status'] == true) {

            final data = response.data['data'];
            List refer = data['referrals'] as List;
            final ref = refer.map((e)=> ReferModel.fromJson(e)).toList();

            print(refer);
            if(refer.isEmpty){
              referralErr.value = 'No Referrals';
            }else{
              referralList.assignAll(ref);
            }


          }
        } else if (response is DataFailed) {
          final err = response.exception;

          if (err is DioException) {
            //  Network issues
            if (err.type == DioExceptionType.connectionError ||
                err.type == DioExceptionType.receiveTimeout ||
                err.type == DioExceptionType.connectionTimeout) {
              referralErr.value= 'No internet connection';
              return;
            }

            //  Server error
            final errData = err.response?.data;

            if (errData != null && errData['message'] != null) {
              referralErr.value = errData['message'];
            } else {
              referralErr.value = 'Server error';
            }
          } else {
            referralErr.value = 'Unknown error occurred';
          }
        }
      }
    }catch(e){
      print(e);
      referralErr.value = 'Unknown error occurred';
    }
    finally{
      loadRef.value = false;
    }
  }


  Future<void> updateProfile({
    required String name,
    required String phone,
    required String dob,
    required String mail,
  }) async {
    final String? token = await store.getToken();
    if (token == null) {
      CustomSnackbar.showSnackbar(message: 'You are unauthorized to set pin');
    } else {
      final response = await repo.updateProfile(name: name, phone: phone, dob: dob, mail: mail, token: token);
      print(response.data);
      if (response is DataSuccess) {
        final data = response.data;

        if (data['status'] == true) {
        } else {
          // backend handled inside success (if API returns 200 with status false)
          CustomSnackbar.showSnackbar(message: data['message']);
        }
      } else if (response is DataFailed) {
        final err = response.exception;

        if (err is DioException) {
          //  Network issues
          if (err.type == DioExceptionType.connectionError ||
              err.type == DioExceptionType.receiveTimeout ||
              err.type == DioExceptionType.connectionTimeout) {
            CustomSnackbar.showSnackbar(title: 'No internet connection', message: 'Check your internet connection');
            return;
          }

          //  Server error
          final errData = err.response?.data;

          if (errData != null && errData['message'] != null) {
            CustomSnackbar.showSnackbar(message: errData['message']);
          } else {
            CustomSnackbar.showSnackbar(
              message: 'Server error, try again later',
            );
          }
        } else {
          CustomSnackbar.showSnackbar(message: 'Unknown error occurred');
        }
      }
    }
  }

  void setProfile(ProfileModel? user)async{
    profile.value = user;

    nameCtrl.text = user?.name ?? name.value;
    numberCtrl.text = user?.phone ?? phone.value;
    mailCtrl.text = user?.email ?? email.value;
    // dobCtrl.text = user.dateOfBirth;

  }
  @override
  void onClose() {
    nameCtrl.dispose();
    mailCtrl.dispose();
    numberCtrl.dispose();
    dobCtrl.dispose();

    super.onClose();
  }


  // // Image picker function and the control
  ImagePicker imagePicker = ImagePicker();

  final  picked = Rx<File?>(null);

  Future<void> selectImage() async {

    final selected = await imagePicker.pickImage(source: ImageSource.gallery);
    if(selected != null){
      LoaderController.to.show();
      Future.delayed(Duration(seconds: 1));
      picked.value = File(selected.path);
      LoaderController.to.hide();
    }
    else{
      Get.snackbar("No image", "Select an Image");
    }
  }
}


class ReferModel{
  String refereeName;
  String bonus;
  String userId;

  ReferModel({
    required this.refereeName,
    required this.userId,
    required this.bonus
});

  factory ReferModel.fromJson(Map<String, dynamic> json){
    return ReferModel(refereeName: json['referees']['name'], userId: json['user_id'], bonus: json['bonus']);
  }
}