import 'package:fin_wise/core/resources/storage_keys.dart';
import 'package:fin_wise/utils/Helpers/share_prefer_services.dart';
import 'package:get/get.dart';

class NoteSettingsCtrl extends GetxController{

  final SharedPreferService service;
  NoteSettingsCtrl(this.service);

  RxBool general = true.obs;
  var transUpdate = false.obs;
  var lowBalance = true.obs;
  var pushNotify = true.obs;
  var mailNotify = true.obs;

  Future<void> saveTransUpdate() async{
    await service.saveData<bool>('transUpdate', general.value);
  }


  Future<void> getBool() async {
   final bool? value = await service.retrieve(PrefStoreKeys.generalNot);
   general.value = value ?? true;
  }
}