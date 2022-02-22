import 'dart:convert';

MobileHealthData mobileHealthDataFromJson(String str) =>
    MobileHealthData.fromJson(json.decode(str));

String mobileHealthDataToJson(MobileHealthData data) =>
    json.encode(data.toJson());

class MobileHealthData {
  MobileHealthData({
    required this.isGooglePlayServicesMissing,
    required this.brand,
    required this.device,
    required this.manufacturer,
    required this.sdKstartStatus,
    required this.androidsdkVersion,
    required this.appVersion,
    required this.canDetect,
    required this.diskQuotaStatus,
    required this.isAccelPresent,
    required this.isActivityRecognitionPermGranted,
    required this.isAirplaneModeEnabled,
    required this.isBackgroundProcessingRestricted,
    required this.isBatteryOptimizationEnabled,
    required this.isBatterySavingEnabled,
    required this.isGpsPresent,
    required this.isGyroPresent,
    required this.isLocationAvailable,
    required this.isLocationPermGranted,
    required this.isRemoteEnabled,
    required this.locationSetting,
    required this.mobileQuotaStatus,
    required this.modelName,
    required this.osVersion,
    required this.installId,
    required this.sentianceUserId,
    required this.sdkUserId,
    required this.wifiQuotaStatus,
  });

  final bool isGooglePlayServicesMissing;
  final String brand;
  final String device;
  final String manufacturer;
  final String sdKstartStatus;
  final String androidsdkVersion;
  final String appVersion;
  final bool canDetect;
  final String diskQuotaStatus;
  final bool isAccelPresent;
  final bool isActivityRecognitionPermGranted;
  final bool isAirplaneModeEnabled;
  final bool isBackgroundProcessingRestricted;
  final bool isBatteryOptimizationEnabled;
  final bool isBatterySavingEnabled;
  final bool isGpsPresent;
  final bool isGyroPresent;
  final bool isLocationAvailable;
  final bool isLocationPermGranted;
  final bool isRemoteEnabled;
  final String locationSetting;
  final String mobileQuotaStatus;
  final String modelName;
  final int osVersion;
  final String installId;
  final String sentianceUserId;
  final String sdkUserId;
  final String wifiQuotaStatus;

  factory MobileHealthData.fromJson(Map<String, dynamic> json) =>
      MobileHealthData(
        isGooglePlayServicesMissing: json["isGooglePlayServicesMissing"],
        brand: json["BRAND"],
        device: json["DEVICE"],
        manufacturer: json["MANUFACTURER"],
        sdKstartStatus: json["SDKstartStatus"],
        androidsdkVersion: json["androidsdkVersion"],
        appVersion: json["appVersion"],
        canDetect: json["canDetect"],
        diskQuotaStatus: json["diskQuotaStatus"],
        isAccelPresent: json["isAccelPresent"],
        isActivityRecognitionPermGranted:
            json["isActivityRecognitionPermGranted"],
        isAirplaneModeEnabled: json["isAirplaneModeEnabled"],
        isBackgroundProcessingRestricted:
            json["isBackgroundProcessingRestricted"],
        isBatteryOptimizationEnabled: json["isBatteryOptimizationEnabled"],
        isBatterySavingEnabled: json["isBatterySavingEnabled"],
        isGpsPresent: json["isGpsPresent"],
        isGyroPresent: json["isGyroPresent"],
        isLocationAvailable: json["isLocationAvailable"],
        isLocationPermGranted: json["isLocationPermGranted"],
        isRemoteEnabled: json["isRemoteEnabled"],
        locationSetting: json["locationSetting"],
        mobileQuotaStatus: json["mobileQuotaStatus"],
        modelName: json["modelName"],
        osVersion: json["osVersion"],
        installId: json["install_id"],
        sentianceUserId: json["sentiance_user_id"],
        sdkUserId: json["sdkUserID"],
        wifiQuotaStatus: json["wifiQuotaStatus"],
      );

  Map<String, dynamic> toJson() => {
        "isGooglePlayServicesMissing": isGooglePlayServicesMissing,
        "BRAND": brand,
        "DEVICE": device,
        "MANUFACTURER": manufacturer,
        "SDKstartStatus": sdKstartStatus,
        "androidsdkVersion": androidsdkVersion,
        "appVersion": appVersion,
        "canDetect": canDetect,
        "diskQuotaStatus": diskQuotaStatus,
        "isAccelPresent": isAccelPresent,
        "isActivityRecognitionPermGranted": isActivityRecognitionPermGranted,
        "isAirplaneModeEnabled": isAirplaneModeEnabled,
        "isBackgroundProcessingRestricted": isBackgroundProcessingRestricted,
        "isBatteryOptimizationEnabled": isBatteryOptimizationEnabled,
        "isBatterySavingEnabled": isBatterySavingEnabled,
        "isGpsPresent": isGpsPresent,
        "isGyroPresent": isGyroPresent,
        "isLocationAvailable": isLocationAvailable,
        "isLocationPermGranted": isLocationPermGranted,
        "isRemoteEnabled": isRemoteEnabled,
        "locationSetting": locationSetting,
        "mobileQuotaStatus": mobileQuotaStatus,
        "modelName": modelName,
        "osVersion": osVersion,
        "install_id": installId,
        "sentiance_user_id": sentianceUserId,
        "sdkUserID": sdkUserId,
        "wifiQuotaStatus": wifiQuotaStatus,
      };
}
