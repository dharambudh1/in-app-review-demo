import "dart:developer";
import "dart:io";

import "package:device_info_plus/device_info_plus.dart";

class DeviceSingleton {
  factory DeviceSingleton() {
    return _singleton;
  }

  DeviceSingleton._internal();
  static final DeviceSingleton _singleton = DeviceSingleton._internal();

  late AndroidDeviceInfo androidDeviceInfo;
  late IosDeviceInfo iosDeviceInfo;
  late Map<String, dynamic> deviceInfoDataMap;

  Future<void> initDeviceInfo() async {
    Platform.isIOS
        ? iosDeviceInfo = await DeviceInfoPlugin().iosInfo
        : Platform.isAndroid
            ? androidDeviceInfo = await DeviceInfoPlugin().androidInfo
            : log("Unsupported Platform");

    Platform.isIOS
        ? deviceInfoDataMap = iosDeviceInfo.data
        : Platform.isAndroid
            ? deviceInfoDataMap = androidDeviceInfo.data
            : log("Unsupported Platform");
    return Future<void>.value();
  }
}
