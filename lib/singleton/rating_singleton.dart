import "dart:developer";
import "dart:io";

import "package:flutter/material.dart";
import "package:in_app_review_demo/singleton/device_singleton.dart";
import "package:in_app_review_demo/singleton/navigation_singleton.dart";
import "package:rate_my_app/rate_my_app.dart";

class RatingSingleton {
  factory RatingSingleton() {
    return _singleton;
  }

  RatingSingleton._internal();
  static final RatingSingleton _singleton = RatingSingleton._internal();

  // It has minDays, remindDays, minLaunches, remindLaunches & etc. properties.
  final RateMyApp rateMyApp = RateMyApp(
    googlePlayIdentifier: "com.psiphon3.subscription",
    appStoreIdentifier: "1276263909",
  );

  Future<void> initRateMyApp() async {
    await rateMyApp.init();
    return Future<void>.value();
  }

  Future<bool> isNativeReviewDialogSupportedFunction() async {
    final bool isNativeReviewDialogSupported =
        await RatingSingleton().rateMyApp.isNativeReviewDialogSupported ??
            false;
    log("isNativeReviewDialogSupported: $isNativeReviewDialogSupported");
    return Future<bool>.value(isNativeReviewDialogSupported);
  }

  Future<void> launchNativeReviewDialogFunction() async {
    log("Calling launchNativeReviewDialogFunction");
    await rateMyApp.launchNativeReviewDialog();
    return Future<void>.value();
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      showSnackBarFunction(String message) {
    log("Calling showSnackBarFunction");
    final GlobalKey<NavigatorState> state = NavigationSingleton().navigatorKey;
    final BuildContext context = state.currentContext!;
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<void> launchStoreFunction() async {
    log("Calling launchStoreFunction");
    if (Platform.isIOS && !DeviceSingleton().iosDeviceInfo.isPhysicalDevice) {
      showSnackBarFunction("This Feature is Unsupported on iOS Simulator.");
    } else {
      final LaunchStoreResult launchStoreResult = await rateMyApp.launchStore();
      log("launchStoreResult.name: ${launchStoreResult.name}");
    }
    return Future<void>.value();
  }
}
