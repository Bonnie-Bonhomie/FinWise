import 'package:fin_wise/binding/CategorieBindings/market_binding.dart';
import 'package:fin_wise/binding/binding_exports.dart';
import 'package:fin_wise/views/categories/screens/MarketPlace/availble_view.dart';
import 'package:fin_wise/views/transaction/deposits_receipt.dart';
import 'package:fin_wise/views/view_export.dart';
import 'package:fin_wise/core/Routes/routes.dart';
import 'package:fin_wise/views/analysisViews/searchView/search_view.dart';
import 'package:get/get.dart';


class AppRoutes{

  static final pageRoutes =[
//Auth Routes
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


//Services Pages
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
    GetPage(name: Routes.depoReceipt, page: () => DepositsReceipt()),
    GetPage(name: Routes.market, page: () => ProductView(), binding: MarketBinding()),


  ];
}