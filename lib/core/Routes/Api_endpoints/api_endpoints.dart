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
  static const String accDetail = 'profile/accdetails';
  static const String balance = 'profile/walletbalance';
  static const String profile = 'profile/';
  static const String changePwd = 'auth/user/acc';
  static const String changePin = 'auth/user/acc';
  static const String forgetPin = 'auth/user/acc';
  static const String recoverPwd = 'auth/user/acc';

  //Services
  static const String airtimeNetwork = 'airtime/networks';
  static const String buyAirtime = 'airtime/buy';

  static const String buyData = 'data/data_charge';
  static const String dataNet = 'data/networks';
  static const String dataPlans = 'data/data_plans';
  static const String buyTv = 'tv';
  static const String buyEduCard = 'education';
  static const String buyElect = 'elect';

  static const String virtual = 'virtual';
  static const String transact = 'auth/user/transact';
}