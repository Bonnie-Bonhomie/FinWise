import 'package:fin_wise/core/resources/data_state.dart';
import 'package:fin_wise/data/models/electric_model.dart';
import 'package:fin_wise/data/repositories/CategoriesRepo/electricity_repo.dart';
import 'package:fin_wise/utils/Helpers/loader_helper.dart';
import 'package:fin_wise/utils/widgets/custom_snackbar.dart';
import 'package:get/get.dart';

class ElectricityCtrl  extends GetxController{

  final ElectricityRepo repo;
  ElectricityCtrl(this.repo);

  var selectedElect = Rxn<ElectModel>();
  var error = ''.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  var availableElect = [
    ElectModel(name: 'Ikeja Electricity', abbrev: 'Ikeja'),
    ElectModel(name: 'IBEDC', abbrev: 'IBEDC'),
    // ElectModel(name: 'Ikeja Electricity', abbrev: 'Ikeja'),
    // ElectModel(name: 'IBEDC', abbrev: 'IBEDC'),
    // ElectModel(name: 'Ikeja Electricity', abbrev: 'Ikeja'),
    // ElectModel(name: 'IBEDC', abbrev: 'IBEDC'),
  ];

  void updateElect(ElectModel model){
    selectedElect.value = model;
  }

  Future<void> buyAirtime({
    required double amount,
    required int number,
  }) async{
    await runWithLoader(() async{
      final result = await repo.buyElect(amount: amount, meterNumber: number);

      if(DataState == DataSuccess && result.data['status'] == 'success'){
        // airtimeReceipt = result.data;
      }
      else{
        error.value = 'Unable to complete transaction';
        CustomSnackbar.showSnackbar(message: error.value, title:  'Oops');
      }
    });
  }

}
