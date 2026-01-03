package com.yourdomain.your_app_name

import android.content.Context
import android.os.Build
import android.os.Handler
import android.os.Looper
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.nativebridge.*
import io.nativebridge.FlutterNativeBridge

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        FlutterNativeBridge.register(this)
        val buildService = BuildService(applicationContext)
    }
}

@NativeBridge
class BuildService (private val context: Context){
    fun getBuildType(): String = context.getString(R.string.BUILD_ENV)
}