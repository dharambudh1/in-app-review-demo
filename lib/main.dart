import "package:flutter/material.dart";
import "package:in_app_review_demo/screen/home_screen.dart";
import "package:in_app_review_demo/singleton/device_singleton.dart";
import "package:in_app_review_demo/singleton/navigation_singleton.dart";
import "package:in_app_review_demo/singleton/package_singleton.dart";
import "package:in_app_review_demo/singleton/rating_singleton.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DeviceSingleton().initDeviceInfo();
  await PackageSingleton().initPackageInfo();
  await RatingSingleton().initRateMyApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigationSingleton().navigatorKey,
      title: "In-App Review Demo",
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: Colors.blue,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.blue,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
