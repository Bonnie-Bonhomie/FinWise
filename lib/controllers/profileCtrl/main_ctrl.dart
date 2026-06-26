import 'dart:io';

import 'package:fin_wise/controllers/loader_contrl.dart';
import 'package:fin_wise/views/profiles/screens/profile_export.dart';
import 'package:fin_wise/binding/binding_exports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/Routes/routes.dart';



class ProfileMainControl extends GetxController{

  final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  final pages = <Page>[
    GetPage(name: '/', page: () => ProfileView(), binding: EditBinding())
  ].obs;

  void toRefer(){
    pages.add(GetPage(name: Routes.refer, page: () => ReferralsView(), binding: EditBinding()));
    update();
  }

  void toEdit(){
    pages.add(GetPage(name: Routes.editPro, page: () => EditProfile(), binding: EditBinding()));
    update();
  }
  //Security Parts
  void toSecurity(){
    pages.add(GetPage(name: Routes.security, page: () => SecurityPage()));
    update();
  }
  void toChangePin(){
    pages.add(GetPage(name: Routes.changePin, page: () => ChangePinView()));
    update();
  }
  void toFingerPrints(){
    pages.add(GetPage(name: Routes.setFingerprint, page: ()=> FingerprintListView()));
    update();
  }
  void addFinger(){
    pages.add(GetPage(name: Routes.addFinger, page: () => AddFingerprint(),));
    update();
  }
  void delFinger(){
    pages.add(GetPage(name: Routes.deleteFinger, page: () => DeleteFingerprint(), ));
    update();
  }

  ///Security Ends

  //Settings Pages
  void toSettings(){
    pages.add(GetPage(name: Routes.settings, page: () => SettingsView()));
    update();
  }
  void toChangePwd(){
    pages.add(GetPage(name: Routes.changePass, page: () => ChangePassword(), binding: ChangePwdBinding()));
    update();
  }
  void toNoteSettings(){
    pages.add(GetPage(name: Routes.noteSetting, page: () => NotificationSettings(), binding: NotifySettingBinding()));
    update();
  }
  void toDelAccount(){
    pages.add(GetPage(name: Routes.delAcc, page: () => DeleteAccount(), binding: DeleteBinding()));
    update();
  }
  /// Settings End

  //Help Pages
  void toHelp(){
    pages.add(GetPage(name: Routes.help, page: () => HelpCenter(), binding: HelpCenterBinding()));
    update();
  }
  void toOnlineHelp(){
    pages.add(GetPage(name: Routes.onlineSupport, page: () => OnlineSupportView()));
    update();
  }
//Help End

  void back(){
    if(pages.length > 1){
      pages.removeLast();
      update();
    }
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