import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

Future<String> getDeviceId() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    AndroidDeviceInfo androidinf = await deviceInfo.androidInfo;
    print("deviceid for Android is:${androidinf}");
    return androidinf.id;
  } else if (Platform.isWindows) {
    WindowsDeviceInfo windowsinfo = await deviceInfo.windowsInfo;
    print("deviceid for windows is:${windowsinfo}");
    return windowsinfo.computerName;
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      print("deviceid for ios is:${iosInfo}");
    return iosInfo.identifierForVendor ?? "unknown_ios_device";
  }

  
  else {
    return "12345678";
  }
}
