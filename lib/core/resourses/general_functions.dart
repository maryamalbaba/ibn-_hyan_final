import 'package:package_info_plus/package_info_plus.dart';

Future<String> getLocalversion() async {
  PackageInfo current_version = await PackageInfo.fromPlatform();
  return current_version.version;
}
