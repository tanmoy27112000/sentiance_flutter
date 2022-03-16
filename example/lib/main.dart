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
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijg1YzI4ZGRjLTQzYjEtNDUyYi05NzYyLTU4NDc1ZWI5ZGFjNSIsImlhdCI6MTY0NzQwODAxOX0.1S8fMXC0va6h0rE6uFnmeWBjW0ejyoh06QskyEBHNns";
  String sentianceSecret =
      "a2bc95ee20eacc70fbfb4bb15122356a0fcc11ebec0bfad76dfa6338caf74a7871c7ebe3fb6cb02633905ac61673bace5322f5352da9e24a67f1f51957ba2325"; //constant
  String appId = "5faaa10ea972a10600000027"; // constant
  String userLinkUrl =
      "https://devmobileapi.safetyconnect.io/user/link"; // constant
  String cashDetectionUrl = "https://devmobileapi.safetyconnect.io/crash";
  String mobileHealthUrl =
      "https://devmobileapi.safetyconnect.io/me/mobilehealth"; //constant
  String customerId = "f87accfa-8dd5-4ee1-bf63-8f643b0dbb46";
  String userId = "7d34e85c-5aad-4022-8b47-2216224c97e7";

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
                    mobileHealthUrl: mobileHealthUrl,
                    customerId: customerId,
                    userId: userId);
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
