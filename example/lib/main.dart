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
    // ignore: avoid_print
    print(data);
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
                // var data = await SentianceFlutter.getSentianceData;
                // print(data);
                await SentianceFlutter.initialiseSentiance({
                  "data": {
                    "sentiance_secret":"3831007f47033a9c9a90ffa415da1465130e3cec6d974f17fe16e0c6229a00398173509b41c78b4e290323c4cfc415029ed1abbcca1dc70fc58a8ce0a874ef4b",
                    "app_id":"61409961d07ba10900000277",
                    "email": "easwalanidumolu@gmail.com",
                    "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImtpZCI6Ilg1ZVhrNHh5b2pORnVtMWtsMll0djhkbE5QNC1jNTdkTzZRR1RWQndhTmsifQ.eyJpc3MiOiJodHRwczovL2RldnNhZmV0Y29ubmVjdC5iMmNsb2dpbi5jb20vNTAzODc0ZjQtNDdjNS00Y2E4LWJjODctMjE1NjljNjI5MTU5L3YyLjAvIiwiZXhwIjoxNjM2NzE3MjAzLCJuYmYiOjE2MzY2MzA4MDMsImF1ZCI6IjVjZWNiZDBlLWFjM2MtNDE4OC04MmQ2LWFiZTMxYmZmNTE3OCIsImlkcCI6IkxvY2FsQWNjb3VudCIsInN1YiI6IjgyZDA0ODU2LTFjNmUtNDQ2Zi1iZWVlLTAzYTQwNGRjOWM5YSIsImdpdmVuX25hbWUiOiJUYW5tb3kiLCJlbWFpbHMiOlsidGFubW95a2FybWFrYXJAZ3l0d29ya3ouY29tIl0sInRmcCI6IkIyQ18xX2xvZ2luIiwiYXpwIjoiNWNlY2JkMGUtYWMzYy00MTg4LTgyZDYtYWJlMzFiZmY1MTc4IiwidmVyIjoiMS4wIiwiaWF0IjoxNjM2NjMwODAzfQ.Vg9J1gpwxeeTu1dYaEvwbAkOwwpzORT2_aER_H5m2O4o36VnYFPhHclJDRglm2Ve35Nf6f7jNq2FfnpWQyBQoYurDFZr2-paicmsXNbmmYJIXtSpzXObBQEFCMxGcDwY5ZH0suC9EjwpPBzV4W-uyRj9twuBZszoSPQn36rFIoOnkffLT7TwHsLqeM5PVR3OMMgWXon6RpVWmFhsrdNBaUoO34GfzIw_DPyO-Rh84s1e1C8ray13kJHxjB6NVb68q87UiwB0BF8oaKesQvg4d389eC2tIr7ceVxXsxncSmFoko3Iw72l4BHFUgCz2pEVF-FAU7z4dhcWHhjvLVKKuw"      //  "

                   }});
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