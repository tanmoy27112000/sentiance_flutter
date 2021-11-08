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
                await SentianceFlutter.initialiseSentiance({

                  "data": {
                    "sentiance_secret":"591ea03cf8f8410c4d15d8372e2bbbb7e2f6565aeaf8acfbd474357a4db5bfa7782a3aa3d77f5b12a33a84c9de7091bda55cd7379aaa18ba4ebc0b0e5e99e342",
                    "app_id":"5faab0afcc53bf0700000028",

    "_id": "60b6094da2dc0d26b1105298",
    "role": "driver",
    "fullname": "Tanmoy ",
    "email": "tanmoykarmakar@gytworkz.com",
    "contact": "7031932380",
    "profile_image": "https://s3.ap-south-1.amazonaws.com/iotrl.io/documentwallet_fleetconnect/5fbce530189a1a59c88e8b3b/1629279532/55b5fb36-2afe-4b43-9c5a-6a8408f8861c1261746366705314863.jpg",
    "customer": "5fbce530189a1a59c88e8b3b",
    "incident_reporting_enabled": true,
    "attendance_reporting_enabled": false,
    "location_reporting_enabled": false,
    "knowledge_centre_enabled": true,
    "workorder_reporting_enabled": false,
    "checklist_enabled": false,
    "country_code": "+91",
    "emergency_contact_details": {
    "emergency_contact_name": "7031932380",
    "emergency_contact_number": "7031932380"
    },
    "profile_details": {
    "is_updated": false,
    "sex": "",
    "age": "",
    "experience": ""
    },
    "vehicle_details": {
    "vehicle_type": "car",
    "make": "nithin",
    "model": "IoTRL"
    },
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MGI2MDk0ZGEyZGMwZDI2YjExMDUyOTgiLCJyb2xlIjoiZHJpdmVyIiwiZnVsbG5hbWUiOiJUYW5tb3kgIiwiZW1haWwiOiJ0YW5tb3lrYXJtYWthckBneXR3b3Jrei5jb20iLCJjb250YWN0IjoiNzAzMTkzMjM4MCIsInByb2ZpbGVfaW1hZ2UiOiJodHRwczovL3MzLmFwLXNvdXRoLTEuYW1hem9uYXdzLmNvbS9pb3RybC5pby9kb2N1bWVudHdhbGxldF9mbGVldGNvbm5lY3QvNWZiY2U1MzAxODlhMWE1OWM4OGU4YjNiLzE2MjkyNzk1MzIvNTViNWZiMzYtMmFmZS00YjQzLTljNWEtNmE4NDA4Zjg4NjFjMTI2MTc0NjM2NjcwNTMxNDg2My5qcGciLCJjdXN0b21lciI6IjVmYmNlNTMwMTg5YTFhNTljODhlOGIzYiIsImluY2lkZW50X3JlcG9ydGluZ19lbmFibGVkIjp0cnVlLCJhdHRlbmRhbmNlX3JlcG9ydGluZ19lbmFibGVkIjpmYWxzZSwibG9jYXRpb25fcmVwb3J0aW5nX2VuYWJsZWQiOmZhbHNlLCJrbm93bGVkZ2VfY2VudHJlX2VuYWJsZWQiOnRydWUsIndvcmtvcmRlcl9yZXBvcnRpbmdfZW5hYmxlZCI6ZmFsc2UsImNoZWNrbGlzdF9lbmFibGVkIjpmYWxzZSwiY291bnRyeV9jb2RlIjoiKzkxIiwiZW1lcmdlbmN5X2NvbnRhY3RfZGV0YWlscyI6eyJlbWVyZ2VuY3lfY29udGFjdF9uYW1lIjoiNzAzMTkzMjM4MCIsImVtZXJnZW5jeV9jb250YWN0X251bWJlciI6IjcwMzE5MzIzODAifSwicHJvZmlsZV9kZXRhaWxzIjp7ImlzX3VwZGF0ZWQiOmZhbHNlLCJzZXgiOiIiLCJhZ2UiOiIiLCJleHBlcmllbmNlIjoiIn0sInZlaGljbGVfZGV0YWlscyI6eyJ2ZWhpY2xlX3R5cGUiOiJjYXIiLCJtYWtlIjoibml0aGluIiwibW9kZWwiOiJJb1RSTCJ9LCJpYXQiOjE2MzYzNzE5OTR9.n8HADbYgNGW8xjbAQL1Kc76ham6joOuHfBo-rBb6G7s"
    }
    });
                // await SentianceFlutter.initialiseSentiance(
                //     {}); // send data  with sentiance secret and app id

                // log(result);
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