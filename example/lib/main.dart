import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  String _platformVersion = 'Unknown';
  // var sentianceHelper = const MethodChannel('flutter.sentiance/helper');
  // var platformHelper = const MethodChannel('flutter.native/helper');

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    await SentianceFlutter.platformVersion;

    //await platformHelper.invokeMethod("getPermissions");
    //sentianceHelper.setMethodCallHandler(_handleMethod);
    // String platformVersion;
    // // Platform messages may fail, so we use a try/catch PlatformException.
    // // We also handle the message potentially returning null.
    // try {
    //   platformVersion = await SentianceFlutter.platformVersion
    //        ?? 'Unknown platform version';
    // } on PlatformException {
    //   platformVersion = 'Failed to get platform version.';
    // }
    //
    // // If the widget was removed from the tree while the asynchronous platform
    // // message was in flight, we want to discard the reply rather than calling
    // // setState to update our non-existent appearance.
    // if (!mounted) return;
    //
    // setState(() {
    //   _platformVersion = platformVersion;
    // });
  }

Future<dynamic> _handleMethod(MethodCall call) async {
  switch (call.method) {
    case "SENTIANCE_INTIAL":
    print(call.arguments);
  }
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Running on: \n'),
        ),
      ),
    );
  }
}
