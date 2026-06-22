import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

Future<Map<String, String>> getDeviceInfo() async {
  final deviceInfo = DeviceInfoPlugin();

  String deviceName;
  String deviceType;

  if (Platform.isAndroid) {
    final android = await deviceInfo.androidInfo;

    deviceName = '${android.brand} ${android.model}';
    deviceType = 'android';
  } else if (Platform.isIOS) {
    final ios = await deviceInfo.iosInfo;

    deviceName = ios.name;
    deviceType = 'ios';
  } else {
    deviceName = 'Unknown';
    deviceType = 'unknown';
  }

  return {
    'deviceName': deviceName,
    'deviceType': deviceType,
  };
}