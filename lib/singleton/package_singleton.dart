import "package:package_info_plus/package_info_plus.dart";

class PackageSingleton {
  factory PackageSingleton() {
    return _singleton;
  }

  PackageSingleton._internal();
  static final PackageSingleton _singleton = PackageSingleton._internal();

  late PackageInfo packageInfo;

  Future<void> initPackageInfo() async {
    packageInfo = await PackageInfo.fromPlatform();
    return Future<void>.value();
  }
}
