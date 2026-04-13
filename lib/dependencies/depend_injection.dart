
import 'package:fin_wise/controllers/analysis/analysis_ctrl.dart';
import 'package:fin_wise/controllers/balance_ctrl/balance_ctrl.dart';
import 'package:fin_wise/controllers/categoryCtrl/category_nav_ctrl.dart';
import 'package:fin_wise/controllers/loader_contrl.dart';
import 'package:fin_wise/controllers/profileCtrl/main_ctrl.dart';
import 'package:fin_wise/controllers/transaction/transaction_ctrl.dart';
import 'package:fin_wise/core/connection/network.dart';
import 'package:fin_wise/data/dataSource/api_service.dart';
import 'package:fin_wise/controllers/AuthControllers/auth_ctrl.dart';
import 'package:fin_wise/data/dataSource/storage_file.dart';
import 'package:fin_wise/data/repositories/AuthRepo/auth_repo.dart';
import 'package:fin_wise/data/repositories/analysis_repo.dart';
import 'package:fin_wise/data/repositories/transacetionRepository/transact_repo.dart';
import 'package:fin_wise/data/repositories/virtual_repo.dart';
import 'package:fin_wise/utils/Helpers/CustomKeyPad/keypad_ctrl.dart';
import 'package:fin_wise/utils/Helpers/share_prefer_services.dart';
import 'package:get/get.dart';

class DependencyInjection{

  static void init(){
    final apiService = ApiServices();
    final internetService = InternetService();
    final store = StorageFile();
    final authRepo = AuthRepository(apiServices: apiService, internetInfo: internetService);
    final sharedPref = SharedPreferService();
    final authCtrl = AuthCtrl(authRepo, store,sharedPref);
    final accRepo = VirtualRepo(apiService, internetService);




    Get.put<ApiServices>(apiService, permanent: true);
    Get.put<StorageFile>(store, permanent: true);
    Get.put<InternetService>(internetService, permanent: true);
    Get.put<SharedPreferService>(SharedPreferService(), permanent: true);
    //Auth
    Get.put<AuthRepository>(authRepo, permanent: true);
    Get.put<AuthCtrl>(authCtrl, permanent: true);

    //Pages
    Get.put(accRepo, permanent: true);
    Get.put(AccBalanceCtrl(accRepo), permanent: true);
    //Transaction
    Get.put(TransactionRepo(internetInfo: internetService, apiServices: apiService), permanent: true);
    Get.put<TransactionCtrl>(TransactionCtrl(Get.find<TransactionRepo>(), Get.find()), permanent: true);
    //Analysis
    Get.put<AnalysisRepo>(AnalysisRepo(apiService, internetService), permanent: true);
    Get.put<AnalysisCtrl>(AnalysisCtrl(Get.find()), permanent: true);
    Get.put(ProfileMainControl(), permanent: true);
    Get.put(CategoryNavCtrl(), permanent:  true);


    Get.lazyPut(()=> KeyPadController(), fenix: true);
    Get.lazyPut(() => LoaderController(), fenix: true);

  }

}