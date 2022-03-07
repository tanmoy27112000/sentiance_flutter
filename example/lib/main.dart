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
                      "token": "",
                      "sentiance_secret" :"",
                  //: "3831007f47033a9c9a90ffa415da1465130e3cec6d974f17fe16e0c6229a00398173509b41c78b4e290323c4cfc415029ed1abbcca1dc70fc58a8ce0a874ef4b",
                  "app_id": "",
                  "user_link_url":
                  "",
                  "email": ""

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