package com.example.sentiance_flutter;

import static com.sentiance.sdk.InitState.NOT_INITIALIZED;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.util.Log;

import androidx.annotation.Nullable;
import androidx.core.app.NotificationCompat;
import androidx.localbroadcastmanager.content.LocalBroadcastManager;
import androidx.multidex.BuildConfig;

import com.sentiance.sdk.MetaUserLinker;
import com.sentiance.sdk.OnInitCallback;
import com.sentiance.sdk.OnSdkStatusUpdateHandler;
import com.sentiance.sdk.OnStartFinishedHandler;
import com.sentiance.sdk.ResetCallback;
import com.sentiance.sdk.SdkConfig;
import com.sentiance.sdk.SdkStatus;
import com.sentiance.sdk.Sentiance;
import com.sentiance.sdk.Token;
import com.sentiance.sdk.TokenResultCallback;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Locale;
import java.util.concurrent.TimeUnit;

import okhttp3.Call;
import okhttp3.Callback;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

public class SentianceWrapper implements MetaUserLinker, OnSdkStatusUpdateHandler, OnInitCallback, OnStartFinishedHandler {
    //PROD
    private static final String SDK_STATUS_URL = "https://devmobileapi.safetyconnect.io/me/mobilehealth";

    private static final String TAG = "SentianceWrapper";

    public static final String ACTION_SDK_STATUS_UPDATED = "com.sentiance.ACTION_SDK_STATUS_UPDATED";
    public static final String ACTION_INIT_SUCCEEDED = "com.sentiance.ACTION_INIT_SUCCEEDED";
    public static final String ACTION_INIT_FAILED = "com.sentiance.ACTION_INIT_FAILED";
    public static final String ACTION_INIT_RESET = "com.sentiance.ACTION_INIT_FAILED";

    private Context mContext;
    private Cache mCache;
    String _installId="";
    private SimpleDateFormat dateFormatter;


    public SentianceWrapper(Context context) {
        dateFormatter = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ", Locale.ENGLISH);
        mContext = context.getApplicationContext();
        mCache = new Cache(context);
    }

    public void initializeSentianceSdk () {
        if (mCache.getUserId() == null) {
            // Cannot initialize the SDK since the user has not logged in yet.
            return;
        }

        if (mCache.getAppSecret() == null) {
            // Cannot initialize the SDK since the app secret is missing.
            return;
        }
        if (mCache.getAppId() == null) {
            // Cannot initialize the SDK since the app Id is missing.
            return;
        }
        if (mCache.getKeyUserLinkUrl() == null) {
            // Cannot initialize the SDK since the app Id is missing.
            return;
        }

        Log.e(TAG, "link: "+mCache.getAppId() );
        Log.e(TAG, "link: "+mCache.getAppSecret() );

       // Create the config.
        SdkConfig config = new SdkConfig.Builder(mCache.getAppId(), mCache.getAppSecret(), createNotification())
                .setOnSdkStatusUpdateHandler(this)
                .setMetaUserLinker(this)  // pass your implementation of the linker here
                .build();

        if(Sentiance.getInstance(mContext).getInitState()== NOT_INITIALIZED){
            Log.e(TAG, "initializeSentianceSdk: " + Sentiance.getInstance(mContext).getInitState());

            Sentiance.getInstance(mContext).init(config, this);
           }else{
            Log.e(TAG, "initializeSentianceSdk: " + Sentiance.getInstance(mContext).getInitState());

        }
    }

    public void stopSentianceSdk () {
        Sentiance.getInstance(mContext).reset(new ResetCallback() {
            @Override
            public void onResetSuccess() {
                Log.e(TAG, "Sentiance SDK was successfully reset");

            }

            @Override
            public void onResetFailure(ResetFailureReason reason) {
                Log.e(TAG, "Sentiance SDK reset failed with reason " + reason.name());
            }
        });

    }

    public void startSentianceSdk () {
        Sentiance.getInstance(mContext).start(this);
        LocalBroadcastManager.getInstance(mContext).sendBroadcast(new Intent(ACTION_SDK_STATUS_UPDATED));
    }

    @Override
    public void onInitSuccess () {
        printInitSuccessLogStatements();

        mCache.setInitialize("initialized");
        // Sentiance SDK was successfully initialized, we can now start it.

        Sentiance.getInstance(mContext).start(this);
        LocalBroadcastManager.getInstance(mContext).sendBroadcast(new Intent(ACTION_INIT_SUCCEEDED));
    }

    @Override
    public void onInitFailure (InitIssue initIssue, @Nullable Throwable throwable) {
        LocalBroadcastManager.getInstance(mContext).sendBroadcast(new Intent(ACTION_INIT_FAILED));
        Log.e(TAG, "Could not initialize SDK: " + initIssue);

        switch (initIssue) {
            case INVALID_CREDENTIALS:
                Log.e(TAG, "Make sure SENTIANCE_APP_ID and SENTIANCE_SECRET are set correctly.");
                break;
            case CHANGED_CREDENTIALS:
                Log.e(TAG, "The app ID and secret have changed; this is not supported. If you meant to change the app credentials, please uninstall the app and try again.");
                break;
            case SERVICE_UNREACHABLE:
                Log.e(TAG, "The Sentiance API could not be reached. Double-check your internet connection and try again.");
                break;
            case LINK_FAILED:
                Log.e(TAG, "An issue was encountered trying to link the installation ID to the metauser.");
                break;
            case INITIALIZATION_ERROR:
                Log.e(TAG, "An unexpected exception or an error occurred during initialization.", throwable);
                break;
        }
    }

    @Override
    public void onStartFinished (SdkStatus sdkStatus) {
        Log.i(TAG, "SDK start finished with status: " + sdkStatus.startStatus);
        LocalBroadcastManager.getInstance(mContext).sendBroadcast(new Intent(ACTION_SDK_STATUS_UPDATED));
    }

    @Override
    public void onSdkStatusUpdate (SdkStatus sdkStatus) {
        Log.i(TAG, "SDK status updated:" + sdkStatus.toString());

        // The status update is broadcast internally; this is so the other components of the app
        // (specifically MainActivity) can react on this.
        LocalBroadcastManager.getInstance(mContext).sendBroadcast(new Intent(ACTION_SDK_STATUS_UPDATED));
        updateToServer(sdkStatus);
    }

    private void updateToServer(SdkStatus sdkStatus) {

        OkHttpClient client = new OkHttpClient();
        SdkStatus sdkstats = sdkStatus;

        JSONObject jsonObject = new JSONObject();
        try {
            jsonObject.put("isGooglePlayServicesMissing", sdkstats.isGooglePlayServicesMissing );
            jsonObject.put("BRAND", Build.BRAND );
            jsonObject.put("DEVICE", Build.DEVICE );
            jsonObject.put("MANUFACTURER", Build.MANUFACTURER );
            jsonObject.put("SDKstartStatus", sdkstats.startStatus );
            jsonObject.put("androidsdkVersion", Build.VERSION.RELEASE );
            jsonObject.put("appVersion", BuildConfig.VERSION_NAME );
            jsonObject.put("canDetect", sdkstats.canDetect );
            jsonObject.put("diskQuotaStatus", sdkstats.diskQuotaStatus );
            jsonObject.put("isAccelPresent", sdkstats.isAccelPresent );
            jsonObject.put("isActivityRecognitionPermGranted", sdkstats.isActivityRecognitionPermGranted );
            jsonObject.put("isAirplaneModeEnabled", sdkstats.isAirplaneModeEnabled );
            jsonObject.put("isBackgroundProcessingRestricted", sdkstats.isBackgroundProcessingRestricted );
            jsonObject.put("isBatteryOptimizationEnabled", sdkstats.isBatteryOptimizationEnabled );
            jsonObject.put("isBatterySavingEnabled", sdkstats.isBatterySavingEnabled );
            jsonObject.put("isGpsPresent", sdkstats.isGpsPresent );
            jsonObject.put("isGyroPresent", sdkstats.isGyroPresent );
            jsonObject.put("isLocationAvailable", sdkstats.isLocationAvailable );
            jsonObject.put("isLocationPermGranted", sdkstats.isLocationPermGranted );
            jsonObject.put("isRemoteEnabled", sdkstats.isRemoteEnabled );
            jsonObject.put("locationSetting", sdkstats.locationSetting );
            jsonObject.put("mobileQuotaStatus", sdkstats.mobileQuotaStatus );
            jsonObject.put("modelName", Build.MODEL );
            jsonObject.put("osVersion", Build.VERSION.SDK_INT);
            jsonObject.put("install_id", mCache.getInstallId() );
            jsonObject.put("sentiance_user_id", mCache.getInstallId() );
            jsonObject.put("sdkUserID", mCache.getUserId() );
            jsonObject.put("wifiQuotaStatus", sdkstats.wifiQuotaStatus );

        } catch (JSONException e) {
            e.printStackTrace();
        }

        Log.i("TAG", "Receiver" + jsonObject);
        MediaType JSON = MediaType.parse("application/json; charset=utf-8");
        RequestBody body = RequestBody.create(JSON, jsonObject.toString());

        Request request1 = new Request.Builder()
                .url(SDK_STATUS_URL)
                .header("Authorization", mCache.getUserToken())
                .post(body)
                .build();

        client.newCall(request1).enqueue(new Callback() {
            @Override
            public void onFailure(Call call, IOException e) {
                Log.e("fail", e.toString());
            }
            @Override
            public void onResponse(Call call, Response response) throws IOException {
                Log.e("updated mobile api", response.body().string());
            }
        });

    }


    private Notification createNotification () {
        // PendingIntent that will start your application's MainActivity
//        Intent intent = new Intent(mContext, SentianceFlutterPlugin.class);
//        PendingIntent pendingIntent = PendingIntent.getActivity(mContext, 0, intent, 0);

        // On Oreo and above, you must create a notification channel
        String channelId = "trips";
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
            NotificationChannel channel = new NotificationChannel(channelId, "Trips", NotificationManager.IMPORTANCE_MIN);
            channel.setShowBadge(false);
            NotificationManager notificationManager = (NotificationManager)mContext.getSystemService(Context.NOTIFICATION_SERVICE);
            notificationManager.createNotificationChannel(channel);
        }

        return new NotificationCompat.Builder(mContext, channelId)
                .setContentTitle("Safetyconnect" + " is running")
                .setContentText("Touch to open.")
               // .setContentIntent(pendingIntent)
                .setShowWhen(false)
               // .setSmallIcon(R.mipmap.ic_launcher)
                .setPriority(NotificationCompat.PRIORITY_MIN)
                .build();
    }

    // print success log statements
    private void printInitSuccessLogStatements () {
        Log.i(TAG, "Sentiance SDK initialized, version: " + Sentiance.getInstance(mContext).getVersion());
        Log.i(TAG, "Sentiance platform user id for this install: " + Sentiance.getInstance(mContext).getUserId());

        OkHttpClient client = new OkHttpClient();

        String jsonBody1 = "{\"sentiance_user_id\": \"" + Sentiance.getInstance(mContext).getUserId() + "\"," +
                " \"install_id\": \"" + _installId + "\"}";
        Log.e(TAG, "sentiance json " + jsonBody1);

        Request request1 = new Request.Builder()
                .url(mCache.getKeyUserLinkUrl())
                .header("Authorization", getAuthHeader())
                .patch(RequestBody.create(MediaType.parse("application/json"), jsonBody1))
                .build();


        client.newCall(request1).enqueue(new Callback() {
            @Override
            public void onFailure(Call call, IOException e) {
                Log.e(TAG, e.toString());

            }

            @Override
            public void onResponse(Call call, Response response) throws IOException {
                Log.w(TAG, response.body().string());

            }

        });

        Sentiance.getInstance(mContext).getUserAccessToken(new TokenResultCallback() {
            @Override
            public void onSuccess (Token token) {

                Log.i(TAG, "Access token to query the HTTP API: Bearer " + token.getTokenId());
                // Using this token, you can query the Sentiance API.
            }

            @Override
            public void onFailure () {
                Log.e(TAG, "Couldn't get access token");
            }
        });
    }

    @Override
    public boolean link (String installId) {
        _installId= installId;
        mCache.setInstallId(installId);

        Log.e(TAG, "link: "+_installId );
        String jsonBody = "{ \"installId\": \"" + installId + "\"}";
        Log.e(TAG, "link: "+ jsonBody );
        MediaType mediaType = MediaType.parse("application/json");
        RequestBody body = RequestBody.create(mediaType, jsonBody);
        Log.e(TAG, "link: "+ body.toString() );
        Request request = new Request.Builder()
                .url(mCache.getKeyUserLinkUrl())
                .put(body)
                .header("Authorization", mCache.getUserToken())
                .addHeader("Content-Type", "application/json")
                .build();
        Log.e(TAG, "link: "+request );
        try {
            Response response = getClient().newCall(request).execute();
            Log.e(TAG, "link: "+response );
            return response.isSuccessful();
        } catch (IOException e) {
            Log.e(TAG, e.getMessage()+" failure" + "\n" + Log.getStackTraceString(e));
        }
        return false;
    }

    private String getAuthHeader() {
        return  mCache.getUserToken();  // replace with your app's authorization token
    }

    private OkHttpClient getClient() {
        return new OkHttpClient.Builder()
                .readTimeout(60, TimeUnit.SECONDS)
                .build();
    }

}
