import 'dart:async';

import 'package:flutter/services.dart';

class SentianceFlutter {
  static const MethodChannel _channel = MethodChannel('sentiance_flutter');
  static const MethodChannel _channel1 =
      MethodChannel('flutter.sentiance/helper');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('intialiseSdk');
    return version;
  }

  static Future<dynamic> enableLocation(Map<dynamic, dynamic> data) async {
    var initSentiance = await _channel.invokeMethod('enableLocation');
    return initSentiance;
  }

  static initialiseSentiance(Map<dynamic, dynamic> data) async {
    var initSentiance = await _channel.invokeMethod('intialiseSdk', data);
    return initSentiance;
  }

  static Future<dynamic> get getSentianceData async {
    var sentianceData = await _channel.invokeMethod('getSentianceData');
    return sentianceData;
  }

  static Future<dynamic> get startSentianceSDK async {
    var startSentiance = await _channel.invokeMethod('startSdk');
    return startSentiance;
  }

  static Future<String?> get stopSentianceSDK async {
    var stopSentiance = await _channel.invokeMethod('stopSdk');
    return stopSentiance;
  }

  static Future<dynamic> get getSentianceStatus async {
    var sentianceStatus = await _channel.invokeMethod('statusSdk');
    return sentianceStatus;
  }

  static Future<dynamic> get getSentianceInitial async {
    var sentianceStatus = await _channel1.invokeMethod('statusSdk');
    return sentianceStatus;
  }
}
