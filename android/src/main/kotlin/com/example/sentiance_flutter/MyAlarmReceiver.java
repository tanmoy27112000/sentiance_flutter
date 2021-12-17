package com.example.sentiance_flutter;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.util.Log;

import androidx.multidex.BuildConfig;

import com.sentiance.sdk.InitState;
import com.sentiance.sdk.SdkStatus;
import com.sentiance.sdk.Sentiance;

import java.io.IOException;

import okhttp3.Call;
import okhttp3.Callback;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

public class MyAlarmReceiver extends BroadcastReceiver {
    Cache mCache;
    private static final String SDK_STATUS_URL = "https://devmobileapi.safetyconnect.io/me/mobilehealth";

    @Override
    public void onReceive(Context context, Intent intent) {
        mCache = new Cache(context);

        Log.e("TAG", "onReceive: hello receiverrrr" + mCache.getUserId());

        if (Sentiance.getInstance(context).getInitState() == InitState.INITIALIZED)  {
            updateToServer(context,Sentiance.getInstance(context).getSdkStatus());

        }else{
            Log.e("TAG", "onReceive: sdk not initialized" + Sentiance.getInstance(context).getInitState());
        }


    }

    private void updateToServer(Context context,SdkStatus sdkStatus) {
        OkHttpClient client = new OkHttpClient();
        SdkStatus sdkstats = sdkStatus;

        String statusbody = "{" +
                "\" isGooglePlayServicesMissing \":\""+sdkstats.isGooglePlayServicesMissing + "\"," +
                "\"BRAND\":\"" + Build.BRAND + "\"," +
                "\"DEVICE\":\"" + Build.DEVICE + "\"," +
                "\"MANUFACTURER\":\"" + Build.MANUFACTURER + "\"," +
                "\"SDKstartStatus\":\"" + sdkstats.startStatus + "\"," +
                "\"androidsdkVersion\":\"" + Build.VERSION.RELEASE + "\"," +
                "\"appVersion\":\"" + BuildConfig.VERSION_NAME+ "\"," +
                "\"canDetect\":\"" + sdkstats.canDetect + "\"," +
                "\"diskQuotaStatus\":\""+ sdkstats.diskQuotaStatus + "\"," +
                "\"isAccelPresent\":\""+ sdkstats.isAccelPresent + "\"," +
                "\"isActivityRecognitionPermGranted\":\""+ sdkstats.isActivityRecognitionPermGranted+ "\"," +
                "\"isAirplaneModeEnabled\":\""+ sdkstats.isAirplaneModeEnabled + "\"," +
                "\"isBackgroundProcessingRestricted\":\""+ sdkstats.isBackgroundProcessingRestricted +
                "\"isBatteryOptimizationEnabled\":\""+sdkstats.isBatteryOptimizationEnabled + "\"," +
                "\"isBatterySavingEnabled\":\""+ sdkstats.isBatterySavingEnabled + "\"," +
                "\"isGpsPresent\":\""+sdkstats.isGpsPresent + "\"," +
                "\"isGyroPresent\":\""+sdkstats.isGyroPresent + "\"," +
                "\"isLocationAvailable \":\""+sdkstats.isLocationAvailable + "\"," +
                "\"isLocationPermGranted\": \""+  sdkstats.isLocationPermGranted + "\"," +
                "\"isRemoteEnabled\":\""+  sdkstats.isRemoteEnabled+ "\"," +
                "\"locationSetting\":\""+ sdkstats.locationSetting.name() + "\"," +
                "\"mobileQuotaStatus\":\""+sdkstats.mobileQuotaStatus + "\"," +
                "\"wifiQuotaStatus\":\""+ sdkstats.wifiQuotaStatus + "\"," +
                "\"modelName\":\"" + Build.MODEL + "\"," +
                "\"osVersion\":\"" + Build.VERSION.SDK_INT + "\"," +

                "\"sdk\":" +
                "{" +
                "\"install_id\":\""+ mCache.getInstallId() +"\"," +
                "\"sentiance_user_id\":\""+ Sentiance.getInstance(context).getUserId() +"\"" +
                "}," +
                "\"sdkUserID\":\"" +Sentiance.getInstance(context).getUserId()+ "\"," +

                "\"}";

        Log.i("TAG", "Receiver" + statusbody);

        Request request1 = new Request.Builder()
                .url(SDK_STATUS_URL)
                .header("Authorization", getAuthHeader())
                .post(RequestBody.create(MediaType.parse("application/json"), statusbody))
                .build();


        client.newCall(request1).enqueue(new Callback() {
            @Override
            public void onFailure(Call call, IOException e) {
                Log.i("fail", e.toString());

            }

            @Override
            public void onResponse(Call call, Response response) throws IOException {
                Log.i("updated mobile api", response.body().string());

            }

        });

    }

    private String getAuthHeader() {
        return "Bearer "+ mCache.getUserToken();  // replace with your app's authorization token
    }

}
