import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sentiance_flutter/models/mobile_health_data.dart';
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
  var isLocationEnabled = false;
  var isSentianceStoped = false;
  var isHealthDataFetched = false;

  @override
  void initState() {
    super.initState();
    _getSentianceData();
  }

  _getSentianceData() async {
    var data = await SentianceFlutter.getSentianceData;
    print("got data in app" + data);
    if (data == "STARTED") {
      setState(() {
        isLocationEnabled = true;
      });
    } else {
      setState(() {
        isLocationEnabled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _getPaymentMethodOption(context, "Enable Permissions"),
          ],
        ),
      ),
    );
  }

  String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjI5MjBmZjc0LTE1ZGItNGJiMy04ZWRjLTdhYjUzNjhkYTc3ZCIsImlhdCI6MTY0NTUwNzIxM30.o8RDqLsHR0nixlna1u53UV7EnA5B7M6SqhrwfzFKSuk";
  String sentianceSecret =
      "a2bc95ee20eacc70fbfb4bb15122356a0fcc11ebec0bfad76dfa6338caf74a7871c7ebe3fb6cb02633905ac61673bace5322f5352da9e24a67f1f51957ba2325";
  String appId = "5faaa10ea972a10600000027";
  String userLinkUrl = "https://devmobileapi.safetyconnect.io/user/link";
  String cashDetectionUrl = "";
  String mobileHealthUrl =
      "https://devmobileapi.safetyconnect.io/me/mobilehealth";

  // used for the payment option
  Widget _getPaymentMethodOption(
    BuildContext context,
    String paymentName,
  ) {
    return Column(
      children: [
        ListTile(
          title: const Text(
            "enable location",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: CupertinoSwitch(
            trackColor: Colors.grey[300], // **INACTIVE STATE COLOR**
            activeColor: Colors.black, // **ACTIVE STATE COLOR**
            value: isLocationEnabled,
            onChanged: (bool value) async {
              if (isLocationEnabled == true) {
                setState(() {
                  isLocationEnabled = value;
                });
              } else {
                setState(() {
                  isLocationEnabled = true;
                });
                await SentianceFlutter.initialiseSentiance(
                    token,
                    sentianceSecret,
                    appId,
                    userLinkUrl,
                    cashDetectionUrl,
                    mobileHealthUrl);
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Divider(
            color: Colors.blue[500],
            height: 4,
          ),
        ),
        ListTile(
          title: const Text(
            "Stop the SDK",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: CupertinoSwitch(
              trackColor: Colors.grey[300], // **INACTIVE STATE COLOR**
              activeColor: Colors.black, // **ACTIVE STATE COLOR**
              value: isSentianceStoped,
              onChanged: (bool value) async {
                if (value) {
                  await SentianceFlutter.stopSentianceSDK;
                }
                setState(() {
                  isSentianceStoped = !isSentianceStoped;
                });
              }),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Divider(
            color: Colors.blue[500],
            height: 4,
          ),
        ),
        ListTile(
          title: const Text(
            "Get health Data",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: CupertinoSwitch(
              trackColor: Colors.grey[300], // **INACTIVE STATE COLOR**
              activeColor: Colors.black, // **ACTIVE STATE COLOR**
              value: isHealthDataFetched,
              onChanged: (bool value) async {
                if (value) {
                  var data = await SentianceFlutter.getMobileHealthData;
                  print(data.brand);
                }
                setState(() {
                  isHealthDataFetched = !isHealthDataFetched;
                });
              }),
        ),
      ],
    );
  }
}
