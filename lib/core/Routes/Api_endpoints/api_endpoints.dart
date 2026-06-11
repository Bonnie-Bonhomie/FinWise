class ApiEndpoints{

  static const String url = "https://pantherfinder.online/api/v1/";
  static const String api = 'api/v1/';

  static const String baseUrl = url;
  static const String register = 'auth/register';
  static const String verifyAcc = 'auth/verify_account';
  static const String resendOtp = 'auth/resend_activation';
  static const String login = 'auth/login';
  static const String logOut = 'auth/logout';
  static const String forgetPwd = 'auth/forget_password';
  static const String verifyPwd = 'auth/verify_password';
  static const String updatePwd = 'auth/update_password';

  static const String transactPin = 'profile/update_pin';
  // static const String accDetail = 'profile/accdetails';
  static const String balance = 'profile/walletbalance';
  static const String profile = 'profile/dashboard';
  static const String referralList = 'profile/referrals';
  static const String bonusBal = 'profile/bonusbalance';
  static const String withdrawBonus = 'profile/updatewithdrawbonus';

  static const String changePwd = 'auth/user/acc';
  static const String changePin = 'auth/user/acc';
  static const String forgetPin = 'auth/user/acc';
  static const String recoverPwd = 'auth/user/acc';

  ///Payment GateWay
  static const String paymentInit = 'payment/paystack-init';

  //Services
  static const String airtimeNetwork = 'airtime/networks';
  static const String buyAirtime = 'airtime/buy';

  static const String buyData = 'data/data_charge';
  static const String dataNet = 'data/networks';
  static const String dataPlans = 'data/data_plans';


  static const String buyElect = 'electricity/buy';
  static const String electDisco = 'electricity/discos';
  static const String verifyMeter = 'electricity/verify_meter_no';


  static const String cableDisco = 'cable/discos';
  static const String cableBundle = 'cable/bundle';
  static const String verifySmartCard = 'cable/verify_smart_card';
  static const String buyCable = 'cable/buy';


  static const String buyEduCard = 'education/buy';
  static const String examCard = 'education/exam_card';
  static const String verifyEduCard = 'education/exam-card-verify';


///Not yet in use for real API call
  static const String virtual = 'virtual';
  static const String transact = 'transaction';
  static const String deposits = 'deposits';
}