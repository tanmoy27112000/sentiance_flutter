package com.example.sentiance_flutter

import android.app.Activity
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.widget.Toast
import androidx.annotation.NonNull
import androidx.core.content.ContextCompat.startActivity
import com.example.sentiance_flutter.sentiance.PermissionCheckActivity
import com.example.sentiance_flutter.sentiance.PermissionManager
import io.flutter.embedding.android.FlutterActivity

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry

/** SentianceFlutterPlugin */
class SentianceFlutterPlugin: FlutterPlugin, MethodCallHandler, FlutterActivity() {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "sentiance_flutter")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else if(call.method=="getPermissions"){
      //result.success("easha 1st per")
      if (!PermissionManager(this).getNotGrantedPermissions().isEmpty()) {
        //startActivity(this, )
        startActivity(Intent(this, PermissionCheckActivity::class.java))
      }
    }else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}

//
//class SentianceFlutterPlugin: FlutterPlugin, FlutterActivity() {
//  private val SENTIANCE_SECRET = "591ea03cf8f8410c4d15d8372e2bbbb7e2f6565aeaf8acfbd474357a4db5bfa7782a3aa3d77f5b12a33a84c9de7091bda55cd7379aaa18ba4ebc0b0e5e99e342"//PROD
//  // private val SENTIANCE_SECRET = "a2bc95ee20eacc70fbfb4bb15122356a0fcc11ebec0bfad76dfa6338caf74a7871c7ebe3fb6cb02633905ac61673bace5322f5352da9e24a67f1f51957ba2325"//DEV
//
//  private val CHANNEL = "sentiance_flutter"//"flutter.native/helper"
//  private val CHANNEL1 = "flutter.sentiance/helper"
//  lateinit var resultVal: MethodChannel.Result
//  var sentianceToken: String? = null
//
//  private val statusUpdateReceiver: BroadcastReceiver = object : BroadcastReceiver() {
//    override fun onReceive(context: Context, intent: Intent) {
//      refreshStatus()
//    }
//  }
//
//  // on create
//  override fun onCreate(savedInstanceState: Bundle?) {
//    super.onCreate(savedInstanceState)
//
//
//    MethodChannel(flutterEngine?.dartExecutor?.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
//     print("call $call")
//      if (call.method == "getPerissions") {
//        result.success("easha success")
//      }
//
//      if (call.method == "enableLocation") {
//        if (!PermissionManager(this).getNotGrantedPermissions().isEmpty()) {
//          startActivity(Intent(this, PermissionCheckActivity::class.java))
//        }
//
//      }else if(call.method == "intialiseSdk"){
//        if (!PermissionManager(this).getNotGrantedPermissions().isEmpty()) {
//          startActivity(Intent(this, PermissionCheckActivity::class.java))
//        }
//
//
//
//        var data = call.arguments as HashMap<String, Any>
//
//        var data1= data["data"] as HashMap<String,Any>
//
//        if(data1["email"]!=null && data1["email"].toString().isNotEmpty()== true){
//
//          val cache = Cache(this@SentianceFlutterPlugin)
//
//          cache.setUserId(data1["email"].toString())
//          cache.setUserToken(data1["token"].toString())
//          cache.setAppSecret(SENTIANCE_SECRET)
//
//          //SentianceWrapper(this@SentianceFlutterPlugin).initializeSentianceSdk()
//        }
//
//      }else if(call.method == "getSentianceData"){
//        refreshStatus()
//      }
//
////      else if(call.method == "stopSdk"){
////        if (Sentiance.getInstance(this).initState == InitState.INITIALIZED) {
////          SentianceWrapper(this@MainActivity).stopSentianceSdk()
////          MethodChannel(flutterEngine?.dartExecutor?.binaryMessenger, CHANNEL1).invokeMethod("Sentiance Stop", "")
////
////        }
////      }
////      else if(call.method == "startSdk"){
////        if (Sentiance.getInstance(this).initState == InitState.INITIALIZED) {
////          SentianceWrapper(this@MainActivity).startSentianceSdk()
////          MethodChannel(flutterEngine?.dartExecutor?.binaryMessenger, CHANNEL1).invokeMethod("Sentiance Start", SentainceDataModel(Sentiance.getInstance(this).userId, Sentiance.getInstance(this).sdkStatus.startStatus.name, sentianceToken).toJSON())
////        }else{
////
////        }
////      }
////      else if(call.method == "statusSdk"){
////        if (Sentiance.getInstance(this).initState == InitState.INITIALIZED) {
////          result.success(Sentiance.getInstance(this).sdkStatus.startStatus.name);
////        }else{
////          result.success("not initialized");
////        }
////
////      }
//    }
//  }
//
//  //refresh status
//  fun refreshStatus() {
////    if (Sentiance.getInstance(this).initState == InitState.INITIALIZED) {
////      getToken()
////      updateDataToApi();
////      MethodChannel(flutterEngine?.dartExecutor?.binaryMessenger, CHANNEL1).invokeMethod("Sentiance Initial", SentainceDataModel(Sentiance.getInstance(this).userId, Sentiance.getInstance(this).sdkStatus.startStatus.name, sentianceToken).toJSON())
////    }
//  }
//
//  //get token
//  private fun getToken() {
//
////    Sentiance.getInstance(this).getUserAccessToken(object : TokenResultCallback {
////      override fun onSuccess(token: Token) {
////        sentianceToken = token.tokenId.toString()
////      }
////
////      override fun onFailure() {
////      }
////    })
//
//  }
//  // resume
//  override fun onResume() {
//    super.onResume()
//    // Register a receiver so we are notified by MyApplication when the Sentiance SDK status was updated.
//    //LocalBroadcastManager.getInstance(this).registerReceiver(statusUpdateReceiver, IntentFilter(SdkStatusUpdateHandler.ACTION_SENTIANCE_STATUS_UPDATE))
//  }
//
//  //pause
//  override fun onPause() {
//    super.onPause()
//    //LocalBroadcastManager.getInstance(applicationContext).unregisterReceiver(statusUpdateReceiver)
//  }
//
//  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
////    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "sentiance_flutter")
////    channel.setMethodCallHandler(this)
//  }
//
//  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
//  //  channel.setMethodCallHandler(null)
//  }
//}
