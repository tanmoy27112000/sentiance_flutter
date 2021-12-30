import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sentiance_flutter/sentiance_flutter.dart';

//! 1. make a model that needs to be sent to the sentiance
//! 2. health packet
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

  @override
  void initState() {
    super.initState();
     _getSentianceData();
  }

  _getSentianceData() async {
    var data = await SentianceFlutter.getSentianceData;
    print("got data in app"+data);
    if(data =="STARTED"){
      setState(() {
        isLocationEnabled = true;
      });
    }else{
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
                  {
                    "data": {
                      "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjU0ODc0YzkyLWM2MzgtNGZiZi04ZjcwLWY0YmE3NGQxMTg1ZSIsImlhdCI6MTY0MDg2MDg1MH0.ZqNp_NNvBPXvX306EHHRdvvahZG_Ps1BhMQ_BqgZw9g",
                      "sentiance_secret" :"a2bc95ee20eacc70fbfb4bb15122356a0fcc11ebec0bfad76dfa6338caf74a7871c7ebe3fb6cb02633905ac61673bace5322f5352da9e24a67f1f51957ba2325",
                  //: "3831007f47033a9c9a90ffa415da1465130e3cec6d974f17fe16e0c6229a00398173509b41c78b4e290323c4cfc415029ed1abbcca1dc70fc58a8ce0a874ef4b",
                  "app_id": "5faaa10ea972a10600000027",
                  "user_link_url":
                  "https://mobileapi.safetyconnect.io/user/link",
                  "email": ""
                      // "sentiance_secret":
                      // "a2bc95ee20eacc70fbfb4bb15122356a0fcc11ebec0bfad76dfa6338caf74a7871c7ebe3fb6cb02633905ac61673bace5322f5352da9e24a67f1f51957ba2325",
                      // "app_id": "5faaa10ea972a10600000027",
                      // "user_link_url":
                      // "https://devmobileapi.safetyconnect.io/user/link",
                      //  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjliOWI5OTc4LWQxNjEtNDNmNy1hOTU0LWU4OTMyY2I2ZGUzZSIsImlhdCI6MTYzOTczNjEzNn0.vXgqIKHZ3DWv89cC2xSqStVpd1icb5Zdc1lbMsk3DE8",
                      // "email": "tanmoykarmakar@gytworkz.com"
                    }
                  },
                );
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


//devSecret:""
//prodSreSecret:""