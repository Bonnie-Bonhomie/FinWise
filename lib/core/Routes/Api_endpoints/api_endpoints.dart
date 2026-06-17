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
  static const String notification = 'profile/notifications';
  static const String deleteAllNote = 'profile/delete_all_notifications';
  static const String deleteAccount = 'profile/delete_account';

  ///Terms and Policy
  static const String terms = 'https://pantherfinder.online/term-and-condition';
  static const String policy = 'https://pantherfinder.online/privacy-policy';

///Not in use
  static const String changePwd = 'auth/user/acc';


  ///Payment GateWay
  static const String paymentChannel = 'payment/channels';
  static const String payment = 'payment';
  static const String paySuccess = 'payment/success';
  static const String payFailed = 'payment/failed';

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

  static const String fishMarket = 'fish/products';
  static const String singleFish = 'fish/product';
  static const String buyFish = 'fish/buy';

///Transaction Api endpoint///
  static const String virtual = 'virtual';
  static const String transact = 'transaction';
  static const String deposits = 'deposits';
}