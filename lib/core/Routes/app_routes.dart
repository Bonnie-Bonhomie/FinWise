
import 'package:fin_wise/binding/CategorieBindings/airtime_binding.dart';
import 'package:fin_wise/binding/CategorieBindings/data_binding.dart';
import 'package:fin_wise/binding/CategorieBindings/education_category_binding.dart';
import 'package:fin_wise/binding/CategorieBindings/electricity_binding.dart';
import 'package:fin_wise/binding/CategorieBindings/television_bindings.dart';
import 'package:fin_wise/binding/calender_binding.dart';
import 'package:fin_wise/binding/notification_binding.dart';
import 'package:fin_wise/core/Routes/routes.dart';
import 'package:fin_wise/views/AuthViews/screens/biometric_screen.dart';
import 'package:fin_wise/views/AuthViews/screens/forget_pwd_view.dart';
import 'package:fin_wise/views/AuthViews/screens/login_view.dart';
import 'package:fin_wise/views/AuthViews/screens/otp_screen.dart';
import 'package:fin_wise/views/AuthViews/screens/pwd_reset_successful.dart';
import 'package:fin_wise/views/AuthViews/screens/reset_password.dart';
import 'package:fin_wise/views/AuthViews/screens/sign_in_view.dart';
import 'package:fin_wise/views/AuthViews/screens/transaction_pin.dart';
import 'package:fin_wise/views/AuthViews/screens/verify_email.dart';
import 'package:fin_wise/views/analysisViews/analysis_view.dart';
import 'package:fin_wise/views/analysisViews/calender_page.dart';
import 'package:fin_wise/views/analysisViews/searchView/search_view.dart';
import 'package:fin_wise/views/categories/screens/Electricity/electricity.dart';
import 'package:fin_wise/views/categories/screens/airtime.dart';
import 'package:fin_wise/views/categories/screens/data.dart';
import 'package:fin_wise/views/categories/screens/education/buy_pin.dart';
import 'package:fin_wise/views/categories/screens/education/education_view.dart';
import 'package:fin_wise/views/categories/screens/Electricity/electricity_view.dart';
import 'package:fin_wise/views/categories/screens/tv/tv_subscription.dart';
import 'package:fin_wise/views/home/create_virtual_account.dart';
import 'package:fin_wise/views/home/fund_wallet_page.dart';
import 'package:fin_wise/views/transaction/transaction_receipt.dart';
import 'package:fin_wise/views/categories/screens/tv/television_bill_view.dart';
import 'package:fin_wise/views/home/notification.dart';
import 'package:fin_wise/views/main_screens/main_screen.dart';
import 'package:fin_wise/views/onboards/onboard-1.dart';
import 'package:fin_wise/views/onboards/pre_onboard.dart';
import 'package:fin_wise/views/onboards/splash_screen.dart';
import 'package:fin_wise/views/profiles/screens/edit&view/profile.dart';
import 'package:fin_wise/views/profiles/screens/security/terms_condition.dart';
import 'package:fin_wise/views/profiles/screens/edit&view/successful_page.dart';
import 'package:fin_wise/views/categories/screens/transaction_successful_view.dart';
import 'package:fin_wise/views/transaction/transaction_view.dart';
import 'package:get/get.dart';

import '../../views/home/home.dart';

class AppRoutes{

  static final pageRoutes =[

    GetPage(name: Routes.initRoute, page: ()=> SplashScreen()),
    GetPage(name: Routes.onboard, page: ()=> OnboardOne()),
    GetPage(name: Routes.pre, page: () => PreOnboard()),
    GetPage(name: Routes.login, page: () => LoginView()),
    GetPage(name: Routes.signIn, page: ()=> SignInView(),),
    GetPage(name: Routes.forget, page: ()=> ForgetPwdView()),
    GetPage(name: Routes.reset, page: ()=> ResetPassword()),
    GetPage(name: Routes.otp, page: ()=> OtpScreen()),
    GetPage(name: Routes.biometric, page: ()=> BiometricScreen(),),
    GetPage(name: Routes.rst, page: ()=> ResetSuccessful()),
    GetPage(name: Routes.verAcc, page: () => VerifyEmail()),
    GetPage(name: Routes.transPin, page: () => TransactionPin()),

    GetPage(name: Routes.mainS, page: ()=> MainScreen()),
    GetPage(name: Routes.home, page: ()=> HomePage()),
    GetPage(name: Routes.generateVirtual, page: () => CreateVirtualAccount()),
    GetPage(name: Routes.fundWallet, page: () => FundWalletPage()),


    GetPage(name: Routes.transact, page: ()=> TransactionView(),),
    GetPage(name: Routes.notify, page: ()=> Notification(), binding: NotifyBinding()),
    GetPage(name: Routes.analysis, page: () => AnalysisPage()),
    GetPage(name: Routes.calender, page: () => CalenderPage(), binding: CalenderBinding()),
    GetPage(name: Routes.search, page: ()=>  SearchView()),

    GetPage(name: Routes.profileNav, page: () => Profiles()),
    GetPage(name: Routes.successful, page: () => SuccessfulPage()),
    GetPage(name: Routes.terms, page: () => TermsAndCondition()),
//Categories Pages
    GetPage(name: Routes.airtime, page: () => AirtimeView(), binding: AirtimeBinding()),
    GetPage(name: Routes.data, page: () => DataView(), binding: DataBindings()),
    GetPage(name: Routes.elect, page: () => ElectricityView(), binding: ElectricityBinding()),
    GetPage(name: Routes.availableElect, page: () => AvailableElect(), binding: ElectricityBinding()),

    GetPage(name: Routes.tv, page: () => TelevisionBillView(), binding: TvBindings()),
    GetPage(name: Routes.tvSubscription, page: () => TvSubscription(), binding: TvBindings()),
    GetPage(name: Routes.education, page: () => EducationView(), binding: EducationBinding()),
    GetPage(name: Routes.buyPin, page: () => BuyPinView(), binding: EducationBinding()),

    GetPage(name: Routes.transSuccess, page: () => TransactionSuccessfulView()),
    GetPage(name: Routes.transReceipt, page: () => TransactionReceipt()),


  ];
}