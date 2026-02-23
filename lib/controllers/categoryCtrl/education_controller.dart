import 'package:fin_wise/core/constant.dart';
import 'package:fin_wise/data/models/education_model.dart';
import 'package:get/get.dart';

class EducationController extends GetxController{

 List<EduModel> schools = [
   EduModel(schoolName: 'WAEC', abbrev: 'WAEC', imgPath: 'onboard-1.png'),
   EduModel(schoolName: 'NECO', abbrev: 'NECO', imgPath: 'onboard-2.png'),
   EduModel(schoolName: 'JAMB', abbrev: 'JAMB', imgPath: 'onboard-1.png'),
 ];
 List<String> services = [
   'Result Checker PIN',
   'School Fees Payment'
 ].obs;

 var selectServ = 'Result Checker PIN'.obs;
 var selectedProvider = ServiceProvider.glo.label.obs;
}