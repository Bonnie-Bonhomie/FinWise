import 'package:data_boot/core/constant.dart';
import 'package:data_boot/core/resources/storage_keys.dart';
import 'package:data_boot/utils/Helpers/share_prefer_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoteSettingsCtrl extends GetxController {
  final SharedPreferService service;

  NoteSettingsCtrl(this.service);

  RxBool general = true.obs;
  var transUpdate = false.obs;
  var lowBalance = true.obs;
  var pushNotify = true.obs;
  var mailNotify = true.obs;
  var systemMode = true.obs;
  var appMode = true.obs;
  var loading = false.obs;

  final themeMode = AppThemeMode.system.obs;

  void changeTheme(AppThemeMode mode,{bool save = true}) async{
    themeMode.value = mode;

    switch (mode) {
      case AppThemeMode.system:
        Get.changeThemeMode(ThemeMode.system);
        break;
      case AppThemeMode.light:
        Get.changeThemeMode(ThemeMode.light);
        break;
      case AppThemeMode.dark:
        Get.changeThemeMode(ThemeMode.dark);
        break;
    }
    if(save){
      await service.saveData<String>(PrefStoreKeys.appMode, mode.name);
    }
  }


  Future<void> getAppMode() async {
    final value = await service.retrieve(PrefStoreKeys.appMode);

    final mode = AppThemeExten.getMode(value);
    changeTheme(mode, save: false);
  }
  Future<void> saveUpdate(String key, bool value) async {
    await service.saveData<bool>(key, value);
  }

  Future<void> getGeneral() async {
    final bool? value = await service.retrieve(PrefStoreKeys.generalNot);
    general.value = value ?? true;
    print(value);
  }

  Future<void> getTrans() async {
    final bool? value = await service.retrieve(PrefStoreKeys.transactionUpdate);
    transUpdate.value = value ?? false;
    print(value);
  }

  Future<void> getLowBal() async {
    final bool? value = await service.retrieve(PrefStoreKeys.lowBalance);
    lowBalance.value = value ?? true;
    print(value);
  }

  Future<void> getPush() async {
    final bool? value = await service.retrieve(PrefStoreKeys.pushNot);
    pushNotify.value = value ?? true;
    print(value);
  }

  Future<bool> getMailNot() async {
    final bool? value = await service.retrieve(PrefStoreKeys.mailNot);
    mailNotify.value = value ?? true;
    return value ?? true;
  }

  @override
  void onReady() {
    // TODO: implement onInit
    getGeneral();
    getLowBal();
    getMailNot();
    getTrans();
    getPush();
    getAppMode();
    super.onReady();
  }
}
