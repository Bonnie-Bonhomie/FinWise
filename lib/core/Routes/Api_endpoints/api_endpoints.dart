class ApiEndpoints{

  static const String url = "http://10.52.99.5";
  static const String api = 'api';

  static const baseUrl = '$url/$api';
  static const register = 'auth/user';
  static const login = 'auth/user/login';
  static const transact = 'auth/user/transact';
  static const accDetail = 'auth/user/acc';
  static const profile = 'auth/user/acc';
  static const changePwd = 'auth/user/acc';
  static const changePin = 'auth/user/acc';
  static const forgetPin = 'auth/user/acc';
  static const recoverPwd = 'auth/user/acc';
  static const logOut = 'auth/user/acc';
}