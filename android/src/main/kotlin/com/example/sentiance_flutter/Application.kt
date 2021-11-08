package com.example.sentiance_flutter

import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry

class Application : FlutterApplication(), PluginRegistry.PluginRegistrantCallback {

    override fun onCreate() {
        super.onCreate()
        SentianceWrapper(this).initializeSentianceSdk()
        android.util.Log.e("TAG", "onCreate:initt " )
    }

    override fun registerWith(registry: PluginRegistry?) {
        TODO("Not yet implemented")
    }
}
