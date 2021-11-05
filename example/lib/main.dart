import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sentiance_flutter/sentiance_flutter.dart';

import 'SentianceDataModel.dart';

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
   var sentianceHelper = const MethodChannel('flutter.sentiance/helper');

  @override
  void initState() {
    super.initState();
    _getSentianceData();
  }

  _getSentianceData() async {
   var data = await SentianceFlutter.getSentianceData;
   print(data);
  }

  Future<dynamic> _handleMethod(MethodCall call) async {
    switch (call.method) {
      case "Sentiance Initial":
        SentianceDataModel sentianceDataModel =
        sentianceDataModelFromJson(call.arguments);
        if (sentianceDataModel.sentianceStatus == "STARTED") {
          print(sentianceDataModel.toJson());
          setState(() {
            isLocationEnabled = true;
          });
          print("location enabled true");
        } else if (sentianceDataModel.sentianceStatus == "NOT_STARTED") {
          print(sentianceDataModel.toJson());
          setState(() {
            isLocationEnabled = false;
          });
          await SentianceFlutter.startSentianceSDK;

        } else {
          setState(() {
            isLocationEnabled = false;
          });

        }

        break;
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

  // used for the payment option
  Widget _getPaymentMethodOption(
      BuildContext context,
      String paymentName,
      ) {
    return Column(
      children: [
        ListTile(
          title: Text(
            "enable location",
            style: TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,),
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
                await SentianceFlutter.initialiseSentiance();// send data  with sentiance secret and app id

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
        )
      ],
    );
  }
}
