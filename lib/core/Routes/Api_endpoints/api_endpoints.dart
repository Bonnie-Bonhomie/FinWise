class ApiEndpoints{

  static const String url = "https://pantherfinder.online";
  static const String api = 'api/v1/';

  static const String baseUrl = '$url/$api';
  static const String register = 'auth/register';
  static const String verifyAcc = 'auth/verify_account';
  static const String login = 'auth/login';
  static const String transact = 'auth/user/transact';
  static const String accDetail = 'auth/user/acc';
  static const String profile = 'auth/user/acc';
  static const String changePwd = 'auth/user/acc';
  static const String changePin = 'auth/user/acc';
  static const String forgetPin = 'auth/user/acc';
  static const String recoverPwd = 'auth/user/acc';
  static const String logOut = 'auth/user/acc';

  static const String buyTv = 'tv';
  static const String buyAirtime = 'airtime';
  static const String buyData = 'data';
  static const String buyEduCard = 'education';
  static const String buyElect = 'elect';

  static const String virtual = 'elect';
}