package com.example.sentiance_flutter

import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry

class Application : FlutterApplication(), PluginRegistry.PluginRegistrantCallback {
    override fun registerWith(registry: PluginRegistry?) {
        TODO("Not yet implemented")
    }

}
//package  com.fleet.fleetroadsafety;
//
//import android.app.Notification
//import android.app.NotificationChannel
//import android.app.NotificationManager
//import android.app.PendingIntent
//import android.content.Context
//import android.content.Intent
//import android.location.Location
//import android.os.Build
//import android.util.Log
//import androidx.core.app.NotificationCompat
//import androidx.multidex.MultiDex
//import com.sentiance.sdk.*
//import com.sentiance.sdk.OnInitCallback.InitIssue
//import io.flutter.app.FlutterApplication
//import io.flutter.plugin.common.PluginRegistry
//import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback
//import io.flutter.plugins.pathprovider.PathProviderPlugin
//import io.flutter.view.FlutterMain
//import java.text.SimpleDateFormat
//import java.util.*
//
//import rekab.app.background_locator.IsolateHolderService
//
//class Application : FlutterApplication(), PluginRegistrantCallback {
//    override fun onCreate() {
//
//        super.onCreate()
//        //  LocatorService.setPluginRegistrant(this)
//        IsolateHolderService.setPluginRegistrant(this)
//        FlutterMain.startInitialization(this)
//        SentianceWrapper(this).initializeSentianceSdk()
//        MultiDex.install(this)
//
//    }
//
//    override fun registerWith(registry: PluginRegistry?) {
//        if (!registry!!.hasPlugin("io.flutter.plugins.pathprovider")) {
//            PathProviderPlugin.registerWith(registry.registrarFor("io.flutter.plugins.pathprovider"))
//        }
//    }
//
//
//}
