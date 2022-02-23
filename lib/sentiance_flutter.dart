import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:sentiance_flutter/models/mobile_health_data.dart';

class SentianceFlutter {
  static Map getCredentails(token, sentianceSecret, appId, userLinkUrl,
      crashDetectionUrl, mobileHealthUrl) {
    return {
      "data": {
        "token": token,
        "sentiance_secret": sentianceSecret,
        "app_id": appId,
        "user_link_url": userLinkUrl,
        "crash_detection_url": crashDetectionUrl,
        "mobile_health_url": mobileHealthUrl
      }
    };
  }

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

  static initialiseSentiance(String token, String sentianceSecret, appId,
      userLinkUrl, crashDetectionUrl, mobileHealthUrl) async {
    var credentials = getCredentails(token, sentianceSecret, appId, userLinkUrl,
        crashDetectionUrl, mobileHealthUrl);
    var initSentiance =
        await _channel.invokeMethod('intialiseSdk', credentials);
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
    var sentianceStatus = await _channel1.invokeMethod('sentiance_initial');
    return sentianceStatus;
  }

  static Future<MobileHealthData> get getMobileHealthData async {
    var sentianceMobileHealthData =
        await _channel.invokeMethod('getMobileHealthData');
    return MobileHealthData.fromJson(jsonDecode(sentianceMobileHealthData));
  }
}
