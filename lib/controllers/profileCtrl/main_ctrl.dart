import 'package:fin_wise/binding/profileBindings/change_pin_binding.dart';
import 'package:fin_wise/binding/profileBindings/change_pwd_binding.dart';
import 'package:fin_wise/binding/profileBindings/edit_profile_binding.dart';
import 'package:fin_wise/binding/profileBindings/notification_setting_binding.dart';
import 'package:fin_wise/views/profiles/screens/edit&view/edit_profile.dart';
import 'package:fin_wise/views/profiles/screens/helpScreens/help_center.dart';
import 'package:fin_wise/views/profiles/screens/edit&view/profile_view.dart';
import 'package:fin_wise/views/profiles/screens/helpScreens/online_support.dart';
import 'package:fin_wise/views/profiles/screens/security/add_fingerprint.dart';
import 'package:fin_wise/views/profiles/screens/security/change_pin.dart';
import 'package:fin_wise/views/profiles/screens/security/delete_fingerprint.dart';
import 'package:fin_wise/views/profiles/screens/security/fingerprint.dart';
import 'package:fin_wise/views/profiles/screens/security/security_page.dart';
import 'package:fin_wise/views/profiles/screens/security/terms_condition.dart';
import 'package:fin_wise/views/profiles/screens/settings/change_password.dart';
import 'package:fin_wise/views/profiles/screens/settings/delete_account.dart';
import 'package:fin_wise/views/profiles/screens/settings/notification_settings.dart';
import 'package:fin_wise/views/profiles/screens/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/Routes/routes.dart';

class ProfileMainControl extends GetxController{

  final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  final pages = <Page>[
    GetPage(name: '/', page: () => ProfileView())
  ].obs;

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
    pages.add(GetPage(name: Routes.changePin, page: () => ChangePinView(), binding: ChangePinBinding()));
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
  // void toTerms(){
  //   pages.add(GetPage(name: Routes.terms, page: () => TermsAndCondition()));
  //   update();
  // }
  //Security Ends
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
    pages.add(GetPage(name: Routes.delAcc, page: () => DeleteAccount()));
    update();
  }
  // Settings End
  //Help Pages
  void toHelp(){
    pages.add(GetPage(name: Routes.help, page: () => HelpCenter()));
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

}