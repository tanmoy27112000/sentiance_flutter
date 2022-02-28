import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sentiance_flutter/sentiance_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: _getPaymentMethodOption(context),
      ),
    );
  }

  String token = // we get the token from the app
      "";
  String sentianceSecret = ""; //constant
  String appId = ""; // constant
  String userLinkUrl = ""; // constant
  String cashDetectionUrl = "";
  String mobileHealthUrl = ""; //constant

  // used for the payment option
  Widget _getPaymentMethodOption(
    BuildContext context,
  ) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () async {
                await SentianceFlutter.initialiseSentiance(
                    token: token,
                    sentianceSecret: sentianceSecret,
                    appId: appId,
                    userLinkUrl: userLinkUrl,
                    crashDetectionUrl: cashDetectionUrl,
                    mobileHealthUrl: mobileHealthUrl);
              },
              child: const Text(
                "Initialise SDK",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              )),
          ElevatedButton(
              onPressed: () async {
                MobileHealthData data =
                    await SentianceFlutter.getMobileHealthData;
                if (kDebugMode) {
                  print(data.androidsdkVersion);
                }
              },
              child: const Text("Get Mobile Health Data",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ))),
          ElevatedButton(
              onPressed: () async {
                await SentianceFlutter.stopSentianceSDK;
              },
              child: const Text(
                "Stop SDK",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ],
      ),
    );
  }
}
