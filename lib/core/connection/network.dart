
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class InternetInfo{
  Future<bool> get connected;
  Stream<InternetConnectionStatus> get onStatusChanged;
}

class InternetService implements InternetInfo{

  final InternetConnectionChecker checker = InternetConnectionChecker.instance;

  @override
  Future<bool> get connected async {
    return await checker.hasConnection;
  }
  @override
  Stream<InternetConnectionStatus> get onStatusChanged => checker.onStatusChange;
}
