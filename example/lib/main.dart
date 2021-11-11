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
    // _getSentianceData();
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
                    "sentiance_secret":"3831007f47033a9c9a90ffa415da1465130e3cec6d974f17fe16e0c6229a00398173509b41c78b4e290323c4cfc415029ed1abbcca1dc70fc58a8ce0a874ef4b",
                    "app_id":"61409961d07ba10900000277",

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
    "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImtpZCI6Ilg1ZVhrNHh5b2pORnVtMWtsMll0djhkbE5QNC1jNTdkTzZRR1RWQndhTmsifQ.eyJpc3MiOiJodHRwczovL2RldnNhZmV0Y29ubmVjdC5iMmNsb2dpbi5jb20vNTAzODc0ZjQtNDdjNS00Y2E4LWJjODctMjE1NjljNjI5MTU5L3YyLjAvIiwiZXhwIjoxNjM2NzE3MjAzLCJuYmYiOjE2MzY2MzA4MDMsImF1ZCI6IjVjZWNiZDBlLWFjM2MtNDE4OC04MmQ2LWFiZTMxYmZmNTE3OCIsImlkcCI6IkxvY2FsQWNjb3VudCIsInN1YiI6IjgyZDA0ODU2LTFjNmUtNDQ2Zi1iZWVlLTAzYTQwNGRjOWM5YSIsImdpdmVuX25hbWUiOiJUYW5tb3kiLCJlbWFpbHMiOlsidGFubW95a2FybWFrYXJAZ3l0d29ya3ouY29tIl0sInRmcCI6IkIyQ18xX2xvZ2luIiwiYXpwIjoiNWNlY2JkMGUtYWMzYy00MTg4LTgyZDYtYWJlMzFiZmY1MTc4IiwidmVyIjoiMS4wIiwiaWF0IjoxNjM2NjMwODAzfQ.Vg9J1gpwxeeTu1dYaEvwbAkOwwpzORT2_aER_H5m2O4o36VnYFPhHclJDRglm2Ve35Nf6f7jNq2FfnpWQyBQoYurDFZr2-paicmsXNbmmYJIXtSpzXObBQEFCMxGcDwY5ZH0suC9EjwpPBzV4W-uyRj9twuBZszoSPQn36rFIoOnkffLT7TwHsLqeM5PVR3OMMgWXon6RpVWmFhsrdNBaUoO34GfzIw_DPyO-Rh84s1e1C8ray13kJHxjB6NVb68q87UiwB0BF8oaKesQvg4d389eC2tIr7ceVxXsxncSmFoko3Iw72l4BHFUgCz2pEVF-FAU7z4dhcWHhjvLVKKuw",
                    //  "

                    //// "token_type": "Bearer",
                    //   "expires_in": "86400",
                    //   "refresh_token": "eyJraWQiOiJjcGltY29yZV8wOTI1MjAxNSIsInZlciI6IjEuMCIsInppcCI6IkRlZmxhdGUiLCJzZXIiOiIxLjAifQ..tZt8mHeehreEAREL.RTZmkJi0c0AlmGdUJnsq10_9_b9K4V9h0g5Ov7b8y8VOhciBecAvzQ4eV1qlIeAbz_yWjbhubjMz777-aoONmUzpBHwF1PL_l9CtZ9kjla6w9rPZHD9P_u-NAqo_sJn6xH1DIXUs0wxvdPx37HEB9M6YUeTI0dd6TUQWDOOrM6gaEo0N0LMWvh42R8pCXcuczqHMGunnV4zj-S9o_XOAiQCIMPhIvw3AmlTlw6a73XpR3mekvQDsv-q4_yzPkjgBUPAXFfIpB_L4RQ6zOva4FXLUfo7JGDZEjOqaj1WHm-xn17fYQXOJ6qFJi8BimLwkSnp0HYovphUpgOgMHb2IEfm6VlUJ5cfZuwk5pcKMpztucDtNDrJcg9_xu97yjQ1BvomgUZ_aZ9u6JYuNlmJIwAzl7M4Fh3Co21L-u9cEY9l127WpbSGq_cKTzSna_nRb5c8NGmmfk0ZISvmp-ljwsUBMnOajvqkWHampMNbFCPVzd4O-OEJNAhVR0cARgxrzvbW5P3A4031UT1dOy9pk0anfBhxUDbma-qmE6I8PSjcCRZ_LmT-FUbi8GKdNoLWWJbghDFMT828JfHAJBGDqBkmh0IiU0o7ske9jUdHOy69GP55Lo5k_8rq77l3mT-tW9qnLUtevWLxFC-iVAKuSyoE9JKVkFncQ_9s.v-Pneh-BOSO8Ai7YMvB8gg",
                    //   "id_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImtpZCI6Ilg1ZVhrNHh5b2pORnVtMWtsMll0djhkbE5QNC1jNTdkTzZRR1RWQndhTmsifQ.eyJleHAiOjE2MzY3MTcyMDMsIm5iZiI6MTYzNjYzMDgwMywidmVyIjoiMS4wIiwiaXNzIjoiaHR0cHM6Ly9kZXZzYWZldGNvbm5lY3QuYjJjbG9naW4uY29tLzUwMzg3NGY0LTQ3YzUtNGNhOC1iYzg3LTIxNTY5YzYyOTE1OS92Mi4wLyIsInN1YiI6IjgyZDA0ODU2LTFjNmUtNDQ2Zi1iZWVlLTAzYTQwNGRjOWM5YSIsImF1ZCI6IjVjZWNiZDBlLWFjM2MtNDE4OC04MmQ2LWFiZTMxYmZmNTE3OCIsImlhdCI6MTYzNjYzMDgwMywiYXV0aF90aW1lIjoxNjM2NjMwODAzLCJpZHAiOiJMb2NhbEFjY291bnQiLCJnaXZlbl9uYW1lIjoiVGFubW95IiwiZW1haWxzIjpbInRhbm1veWthcm1ha2FyQGd5dHdvcmt6LmNvbSJdLCJ0ZnAiOiJCMkNfMV9sb2dpbiIsImF0X2hhc2giOiJJSkdWdmNmdWo2bWh0Q3RxdVp6NGNnIn0.Wfrc50mIDFZZeVlD7OriBxg6_-KMTrShNZj3KcIfr8di5fi7q09hocDI1acVxjJ2KQX_KiwbiSVxpgZFKgfPe352rAXNi1-TXyN-EW1KhiZ7Njg81v-xzRhpFzD3h46DQgk18EzHrLHkRfcQC75NDADfO1UWsDHiUPZLf93gz6YxXM-4bVraKDuewflb_XbmhaJBW9kBXQqKj7wGIlYbpX-nDq5R4wQD8CcWlMziII6CIYSHKE5dQGTG_xAN6NfaZXkGivH2_FuVc0SljVUf2MPtNJ0HX6C1u-5tW6WqGPcoyb4YpUUTgKeJDRfQPoWsW4l6YqRFRz2lZL6WVbPLSg
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