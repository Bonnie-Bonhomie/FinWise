import 'package:fin_wise/core/constant.dart';
import 'package:fin_wise/core/resources/data_state.dart';
import 'package:fin_wise/data/models/education_model.dart';
import 'package:fin_wise/data/repositories/CategoriesRepo/education_repo.dart';
import 'package:fin_wise/utils/Helpers/loader_helper.dart';
import 'package:fin_wise/utils/widgets/custom_snackbar.dart';
import 'package:get/get.dart';

class EducationController extends GetxController{

  final EducationRepo repo;
  EducationController(this.repo);

 List<EduModel> schools = [
   EduModel(schoolName: 'WAEC', abbrev: 'WAEC', imgPath: 'onboard-1.png', serviceName:'Result Checker Pin', amount: 3500),
   EduModel(schoolName: 'NECO', abbrev: 'NECO', imgPath: 'onboard-2.png', serviceName: 'Result Checker Pin', amount: 2500),
   EduModel(schoolName: 'JAMB', abbrev: 'JAMB', imgPath: 'onboard-1.png', serviceName: 'Registration Pin', amount: 5100),
 ];
 List services = [
    'Result Checker PIN',  'School Fees Payment'
 ].obs;

 var selectServ = 'Result Checker PIN'.obs;
 var selectedProvider = ServiceProvider.glo.label.obs;
 var error = ''.obs;


  Future<void> buyEduCard({
    required double amount,
    required int number,
    required String serviceType,
  }) async{
    await runWithLoader(() async{
      final result = await repo.buyEduCard(amount: amount, phoneNumber: number, serviceType: serviceType);

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


