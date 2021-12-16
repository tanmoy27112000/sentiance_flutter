package com.example.sentiance_flutter.model;

import org.json.JSONException;
import org.json.JSONObject;

public class SentianceDataStatus {

    String userId;
    String sentianceStatus;
    boolean canDetect;
    boolean isRemoteEnabled;
    boolean isLocationPermGranted;
    boolean isActivityRecognitionPermGranted;
    boolean isAeroplaneModeEnabled;
    boolean isLocationAvailable;
    boolean isAccelPresent;
    boolean isGyroPresent;
    boolean isGpsPresent;
    boolean isGooglePlayServicesMissing;
    boolean isBatteryOptimizationEnabled;
    boolean isBatterySavingEnabled;
    boolean isBackgroundProcessingRestricted;

    public SentianceDataStatus(String userId,
                               String sentianceStatus,
                               boolean canDetect,
                               boolean isRemoteEnabled,
                               boolean isLocationPermGranted,
                               boolean isActivityRecognitionPermGranted,
                               boolean isAeroplaneModeEnabled,
                               boolean isLocationAvailable,
                               boolean isAccelPresent,
                               boolean isGyroPresent,
                               boolean isGpsPresent,
                               boolean isGooglePlayServicesMissing,
                               boolean isBatteryOptimizationEnabled,
                               boolean isBatterySavingEnabled,
                               boolean isBackgroundProcessingRestricted) {
        this.userId = userId;
        this.sentianceStatus = sentianceStatus;
        this.canDetect = canDetect;
        this.isRemoteEnabled = isRemoteEnabled;
        this.isLocationPermGranted = isLocationPermGranted;
        this.isActivityRecognitionPermGranted = isActivityRecognitionPermGranted;
        this.isAeroplaneModeEnabled = isAeroplaneModeEnabled;
        this.isLocationAvailable = isLocationAvailable;
        this.isAccelPresent = isAccelPresent;
        this.isGyroPresent = isGyroPresent;
        this.isGpsPresent = isGpsPresent;
        this.isGooglePlayServicesMissing = isGooglePlayServicesMissing;
        this.isBatteryOptimizationEnabled = isBatteryOptimizationEnabled;
        this.isBatterySavingEnabled = isBatterySavingEnabled;
        this.isBackgroundProcessingRestricted = isBackgroundProcessingRestricted;
    }

    public String toJSON() {

        JSONObject jsonObject = new JSONObject();
        try {

            jsonObject.put("userId", userId);
            jsonObject.put("sentianceStatus", sentianceStatus);
            jsonObject.put("canDetect" , canDetect);
            jsonObject.put("isRemoteEnabled" , isRemoteEnabled);
            jsonObject.put("isLocationPermGranted" , isLocationPermGranted);
            jsonObject.put("isActivityRecognitionPermGranted" , isActivityRecognitionPermGranted);
            jsonObject.put("isAeroplaneModeEnabled" , isAeroplaneModeEnabled);
            jsonObject.put("isLocationAvailable" , isLocationAvailable);
            jsonObject.put("isAccelPresent" ,isAccelPresent);
            jsonObject.put("isGyroPresent" ,isGyroPresent);
            jsonObject.put("isGpsPresent" ,isGpsPresent);
            jsonObject.put("isGooglePlayServicesMissing" , isGooglePlayServicesMissing);
            jsonObject.put("isBatteryOptimizationEnabled" ,isBatteryOptimizationEnabled);
            jsonObject.put("isBatterySavingEnabled" ,isBatterySavingEnabled);
            jsonObject.put("isBackgroundProcessingRestricted" ,isBackgroundProcessingRestricted);

            return jsonObject.toString();
        } catch (JSONException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            return "";
        }

    }

}

