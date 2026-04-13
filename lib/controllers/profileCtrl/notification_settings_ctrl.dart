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
  var loading = false.obs;

  Future<void> saveUpdate(String key, bool value) async{
    await service.saveData<bool>(key, value);
  }


  Future<void> getGeneral() async {
   final bool? value = await service.retrieve(PrefStoreKeys.generalNot);
   general.value = value!;
   print(value);
  }
  Future<void> getTrans() async {
    final bool? value = await service.retrieve(PrefStoreKeys.transactionUpdate);
    transUpdate.value = value!;
    print(value);
  }
  Future<void> getLowBal() async {
    final bool? value = await service.retrieve(PrefStoreKeys.lowBalance);
    lowBalance.value = value!;
    print(value);
  }
  Future<void> getPush() async {
    final bool? value = await service.retrieve(PrefStoreKeys.pushNot);
    pushNotify.value = value!;
    print(value);
  }
  Future<bool> getMailNot() async {
    final bool? value = await service.retrieve(PrefStoreKeys.mailNot);
    mailNotify.value = value!;
    return value;
  }

  @override
  void onReady() {
    // TODO: implement onInit
    getGeneral();
    getLowBal();
    getMailNot();
    getTrans();
    getPush();
    super.onReady();
  }
}