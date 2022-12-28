import "dart:io";

import "package:flutter/material.dart";
import "package:flutter_json_view/flutter_json_view.dart";
import "package:in_app_review_demo/singleton/device_singleton.dart";
import "package:in_app_review_demo/singleton/package_singleton.dart";
import "package:in_app_review_demo/singleton/rating_singleton.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  String storeName = "";

  @override
  void initState() {
    super.initState();
    storeName = Platform.isIOS
        ? "App"
        : Platform.isAndroid
            ? "Play"
            : "App";
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("In-App Review Demo"),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: IconButton(
              onPressed: showDeviceInfoDataMapDialog,
              icon: const Icon(Icons.perm_device_info_outlined),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: IconButton(
              onPressed: showDeviceInfoDataMapDialog1,
              icon: const Icon(Icons.info_outline),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text("App Name:"),
                Text(
                  checkIfUnknown(
                    PackageSingleton().packageInfo.appName,
                  ),
                ),
                const SizedBox(height: 10),
                const Text("Package Name | Bundle Identifier:"),
                Text(
                  checkIfUnknown(
                    PackageSingleton().packageInfo.packageName,
                  ),
                ),
                const SizedBox(height: 10),
                const Text("Version:"),
                Text(
                  checkIfUnknown(
                    PackageSingleton().packageInfo.version,
                  ),
                ),
                const SizedBox(height: 10),
                const Text("Build Number:"),
                Text(
                  checkIfUnknown(
                    PackageSingleton().packageInfo.buildNumber,
                  ),
                ),
                const SizedBox(height: 10),
                const Text("Build Signature:"),
                Text(
                  checkIfUnknown(
                    PackageSingleton().packageInfo.buildSignature,
                  ),
                ),
                const SizedBox(height: 10),
                const Text("Installer Store:"),
                Text(
                  checkIfUnknown(
                    PackageSingleton().packageInfo.installerStore,
                  ),
                ),
                const SizedBox(height: 10),
                const Text("Store Identifier:"),
                Text(
                  checkIfUnknown(
                    RatingSingleton().rateMyApp.storeIdentifier,
                  ),
                ),
                const SizedBox(height: 10),
                const Text("App Store Identifier:"),
                Text(
                  checkIfUnknown(
                    RatingSingleton().rateMyApp.appStoreIdentifier,
                  ),
                ),
                const SizedBox(height: 10),
                const Text("Google Play Identifier:"),
                Text(
                  checkIfUnknown(
                    RatingSingleton().rateMyApp.googlePlayIdentifier,
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: ElevatedButton(
                      onPressed: () async {
                        final bool isSupported = await RatingSingleton()
                            .isNativeReviewDialogSupportedFunction();
                        isSupported
                            ? await RatingSingleton()
                                .launchNativeReviewDialogFunction()
                            : RatingSingleton().showSnackBarFunction(
                                "Native Review Dialog is Unsupported.",
                              );
                      },
                      child: const Text(
                        "Open Native Review Dialog (If Supported)",
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: ElevatedButton(
                      onPressed: RatingSingleton().launchStoreFunction,
                      child: Text(
                        "Open $storeName Store Application",
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String checkIfUnknown(String? text) {
    return (text == null || text.isEmpty) ? "Unknown" : text;
  }

  Future<void> showDeviceInfoDataMapDialog() async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Device Information"),
          content: JsonView.map(
            DeviceSingleton().deviceInfoDataMap,
            theme: JsonViewTheme(
              defaultTextStyle: Theme.of(context).textTheme.labelSmall!,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              viewType: JsonViewType.base,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: Navigator.of(context).pop,
              child: const Text("Okay"),
            ),
          ],
        );
      },
    );
    return Future<void>.value();
  }

  Future<void> showDeviceInfoDataMapDialog1() async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("App Information"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  "This Demo application can open the Native Reviews & Rating pop-up dialogue. If you want to open the Reviews & Rating pop-up dialogue, you must require to match some criteria. ",
                ),
                SizedBox(height: 10),
                Text("Android:"),
                SizedBox(height: 10),
                Text(
                  "Only opens review dialogue if you have Google Play Services installed on the device & the app downloaded through the Google Play Store.",
                ),
                SizedBox(height: 10),
                Text("iOS:"),
                SizedBox(height: 10),
                Text(
                  "Later than iOS 10.3, the app will Request the App Review, Users can turn this off in settings for all apps, and Apple will manage when to request the review from the user.",
                ),
                SizedBox(height: 10),
                Text(
                  "There is one critical condition for android occurring at this moment while I am writing the code for this app. This library is accepting my request for review only for the first time. If I send the request for review multiple times, then this library doesn't allow my request & due to that, I'm unable to open the pop-up dialogue twice or more than that. Perhaps they've set their quota or limitation for such things.",
                ),
                SizedBox(height: 10),
                Text(
                  "There are a few tricks that you can use for debugging your app. Firstly, check if there are any rating/review that already exists on Google Play Store. If you found then either remove the rating/review or change your account. If this trick does not work, try using different physical devices / virtual devices.",
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: Navigator.of(context).pop,
              child: const Text("Okay"),
            ),
          ],
        );
      },
    );
    return Future<void>.value();
  }
}
