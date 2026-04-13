
import 'package:fin_wise/core/resources/data_state.dart';
import 'package:fin_wise/data/repositories/virtual_repo.dart';
import 'package:fin_wise/utils/Helpers/loader_helper.dart';
import 'package:fin_wise/utils/widgets/custom_snackbar.dart';
import 'package:get/get.dart';

class AccBalanceCtrl extends GetxController{

  final VirtualRepo repo;
  AccBalanceCtrl(this.repo);

  var accountBalance = 7777.63.obs;
  var expense = 1000.00.obs;
  var income = 4000.45.obs;
  var spendingLimit = 2000.00.obs;
  var virtualAcc = ''.obs;
  var selectPay =''.obs;
  var filled = false.obs;





  double get spentPercent => expense.value /spendingLimit.value;

  void fillVirtualAcc(String accNumber){
    virtualAcc.value = accNumber.toString();
  }
 var paymentGateWay = <BankModel>[
   BankModel(name: 'Nomba', availbaleServ: ['Pay with card', 'Transfer and USSD'], imgUrl: ''),
   BankModel(name: 'PayStack', availbaleServ: ['PayStack'], imgUrl: ''),
   BankModel(name: 'Nomba', availbaleServ: ['Pay with card', 'Transfer and USSD'], imgUrl: ''),
 ].obs;


  //
  Future<void> generateVirtual({
    required String fullname, required String phoneNumber, required String bvn, required String dob
}) async{
    await runWithLoader(() async{
      final result = await repo.generateVirtual(fullname: fullname, bvn: bvn, phoneNumber: phoneNumber, dob: dob);

      if(DataState == DataSuccess && result.data['status'] == 'success'){
        virtualAcc.value = result.data['accountNumber'];
      }
      else{
        CustomSnackbar.showSnackbar(message: 'Unable to generate virtual account');
      }
    });
  }

}


 class BankModel{
    final String name;
    final List<String> availbaleServ;
    final String imgUrl;

    BankModel({required this.name,
    required this.availbaleServ,
      required this.imgUrl
    });
 }