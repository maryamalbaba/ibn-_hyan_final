
import 'package:device_info_plus/device_info_plus.dart';

Future<String> getDeviceId() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  WebBrowserInfo webinfo = await deviceInfo.webBrowserInfo;
  String deviceid =
      "${webinfo.userAgent}-${webinfo.deviceMemory}-${webinfo.hardwareConcurrency}-${webinfo.platform}";
print("deviceid for web is:${deviceid}");
  return deviceid;
}
