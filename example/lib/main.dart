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
  var sentianceHelper = const MethodChannel('flutter.sentiance/helper');
  var platformHelper = const MethodChannel('flutter.native/helper');

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    platformHelper.invokeMethod("getPermissions");
    sentianceHelper.setMethodCallHandler(_handleMethod);
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
        appBar: AppBar(
          title: const Text('Sentiance plugin'),
        ),
        body: Center(
          child: Text('Running on')
        ),
      ),
    );
  }
}
