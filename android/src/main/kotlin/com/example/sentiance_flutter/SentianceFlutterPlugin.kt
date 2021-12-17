package com.example.sentiance_flutter

import android.app.Activity
import android.app.AlarmManager
import android.app.PendingIntent
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.Intent.FLAG_ACTIVITY_NEW_TASK
import android.os.Build
import android.util.Log
import androidx.annotation.NonNull
import androidx.core.content.ContextCompat.startActivity
import com.example.sentiance_flutter.sentiance.PermissionCheckActivity
import com.example.sentiance_flutter.sentiance.PermissionManager
import com.example.sentiance_flutter.model.SentianceDataStatus
import com.sentiance.sdk.*
import io.flutter.embedding.android.FlutterActivity

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar


/** FluttertoastPlugin */
class SentianceFlutterPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  private lateinit var channel : MethodChannel
  private lateinit var activity:Activity
  private lateinit var context: Context
  private lateinit var sentianceToken : String

  private val statusUpdateReceiver: BroadcastReceiver = object : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
      refreshStatus()
    }
  }

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.flutterEngine.dartExecutor, "sentiance_flutter")
    channel.setMethodCallHandler(this)
    this.context = flutterPluginBinding.applicationContext
  }

  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "sentiance_flutter")
      channel.setMethodCallHandler(SentianceFlutterPlugin())
    }
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "enableLocation") {
      // Toast.makeText(activity,"Hello!",Toast.LENGTH_SHORT).show()
      if (!PermissionManager(activity).getNotGrantedPermissions().isEmpty()) {
        val intent = Intent(activity, PermissionCheckActivity::class.java)
        intent.flags = FLAG_ACTIVITY_NEW_TASK
        startActivity(context,intent, null);
      }
      //result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else if(call.method == "intialiseSdk"){
      if (!PermissionManager(activity).getNotGrantedPermissions().isEmpty()) {
        val intent = Intent(activity, PermissionCheckActivity::class.java)
        intent.flags = FLAG_ACTIVITY_NEW_TASK
        startActivity(context,intent, null);
      }


      var data = call.arguments as HashMap<String, Any>

      var data1= data["data"] as HashMap<String,Any>

      if(data1["email"]!=null && data1["email"].toString().isNotEmpty()== true){


        val cache = Cache(activity)

          cache.setUserId(data1["email"].toString())
          cache.setUserToken(data1["token"].toString())
          cache.setAppSecret(data1["sentiance_secret"].toString())
          cache.setKeyAppId(data1["app_id"].toString())
          cache.setKeyUserLinkUrl(data1["user_link_url"].toString())
        SentianceWrapper(context).initializeSentianceSdk()
      }

    }else if(call.method == "getSentianceData"){
      if (Sentiance.getInstance(context).initState == InitState.INITIALIZED) {
        refreshStatus()
        result.success(Sentiance.getInstance(context).sdkStatus.startStatus.name)
      }else{
        result.success("NOT_INITIALIZED")
      }
    }else if(call.method == "stopSdk"){
      if (Sentiance.getInstance(context).initState == InitState.INITIALIZED) {
        SentianceWrapper(context).stopSentianceSdk()
      }
    }else if(call.method == "startSdk"){
      if (Sentiance.getInstance(context).initState == InitState.INITIALIZED) {
        SentianceWrapper(context).startSentianceSdk()
      }else{

      }
    }else if(call.method == "statusSdk"){
      if (Sentiance.getInstance(context).initState == InitState.INITIALIZED) {
        var data = Sentiance.getInstance(context).sdkStatus;
        if(Sentiance.getInstance(context).sdkStatus == SdkStatus.StartStatus.STARTED){
          result.success(SentianceDataStatus(Sentiance.getInstance(context).userId, data.startStatus.name,
            data.canDetect, data.isRemoteEnabled, data.isLocationPermGranted,
            data.isActivityRecognitionPermGranted, data.isAirplaneModeEnabled, data.isLocationAvailable,
            data.isAccelPresent, data.isGyroPresent, data.isGpsPresent, data.isGooglePlayServicesMissing,
            data.isBatteryOptimizationEnabled, data.isBatterySavingEnabled,
            data.isBackgroundProcessingRestricted
          ).toJSON());
        }else{
          result.success(SentianceDataStatus(Sentiance.getInstance(context).userId, data.startStatus.name,
            data.canDetect, data.isRemoteEnabled, data.isLocationPermGranted,
            data.isActivityRecognitionPermGranted, data.isAirplaneModeEnabled, data.isLocationAvailable,
            data.isAccelPresent, data.isGyroPresent, data.isGpsPresent, data.isGooglePlayServicesMissing,
            data.isBatteryOptimizationEnabled, data.isBatterySavingEnabled,
            data.isBackgroundProcessingRestricted
          ).toJSON());
        }
      }else{
        result.success("NOT_INITIALIZED");
      }

    }else {
      result.notImplemented()
    }

  }

  fun refreshStatus() {
    if (Sentiance.getInstance(context).initState == InitState.INITIALIZED) {
      getToken()
      updateDataToApi();
     }else{
      Log.e("TAG", "refreshStatus: NOT_INITIALIZED " )
    }
  }

  fun updateDataToApi(){

    val alarmManager = context.getSystemService(FlutterActivity.ALARM_SERVICE) as AlarmManager
    val i = Intent(context, MyAlarmReceiver::class.java)
    val pendingIntent = PendingIntent.getBroadcast(context, 0, i, PendingIntent.FLAG_UPDATE_CURRENT);

    if (Build.VERSION.SDK_INT >= 19){
      alarmManager.setRepeating(AlarmManager.RTC_WAKEUP, System.currentTimeMillis(), 60*60*1000, pendingIntent);
      Log.e("TAG", "onCreate: ");
    }else{
      alarmManager.set(AlarmManager.RTC_WAKEUP, System.currentTimeMillis(), pendingIntent);
    }
  }

  //get token
  private fun getToken() {

    Sentiance.getInstance(context).getUserAccessToken(object : TokenResultCallback {
      override fun onSuccess(token: Token) {
        sentianceToken = token.tokenId.toString()
        Log.e("TAG", "onSuccess: "+sentianceToken )
        Log.e("TAG", "onSuccess: "+Sentiance.getInstance(context).userId )
      }

      override fun onFailure() {
      }
    })

  }


  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
  override fun onDetachedFromActivity() {}

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    onAttachedToActivity(binding)
  }
  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
//    (binding.lifecycle as HiddenLifecycleReference)
//      .lifecycle
//      .addObserver(LifecycleEventObserver { source, event ->
//        Log.e("Activity state: ", event.toString())
//       // updateActivityState(event.toString());
//      })
    this.activity = binding.activity

  }

//  private fun updateActivityState(event: String) {
//    when (event) {
//      "ON_RESUME" ->   //Log.e("Activity state: resume")  //LocalBroadcastManager.getInstance(context).registerReceiver(statusUpdateReceiver, IntentFilter(SdkStatusUpdateHandler.ACTION_SENTIANCE_STATUS_UPDATE))
//
//      "ON_PAUSE" ->      Log.e("Activity state: pause")//LocalBroadcastManager.getInstance(context).unregisterReceiver(statusUpdateReceiver)
//
//
//      else -> Log.e("TAG", "updateActivityState:  default" )
//    }
//  }

  override fun onDetachedFromActivityForConfigChanges() {}
}
