package com.valkdokk.open_dual_view

import android.annotation.SuppressLint
import android.app.Activity
import android.app.ActivityManager
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** OpenDualViewPlugin */
class OpenDualViewPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    private lateinit var channel: MethodChannel

    private var activity: Activity? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "open_dual_view")
        channel.setMethodCallHandler(this)
    }

    @SuppressLint("QueryPermissionsNeeded")
    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "openDualView" -> openApp(call,result)
            "getAvailablePackagesName" -> getAvailablePackagesName(result)
            else -> result.notImplemented()
        }
    }

    private fun getAvailablePackagesName(result: MethodChannel.Result) {
        val packageManager =  activity?.packageManager
        val packageNames = packageManager?.getInstalledApplications(PackageManager.GET_META_DATA)?.map { it.packageName }
        result.success(packageNames)
    }

    private fun openApp(call: MethodCall, result: MethodChannel.Result) {
        try {
            val args = call.arguments<Map<String, Any>>()
            val packageName = args?.get("packageName") as? String
            val uriString = args?.get("uri") as? String

            if (packageName == "" && uriString == "") {
                result.error(
                    "INVALID_ARGUMENT",
                    "Either package name or URI is required",
                    null
                )
                return
            }

            val intent: Intent = when {
                uriString != null-> {
                    // If uri is provided, create an intent with the uri
                    val uri = Uri.parse(uriString)
                    Intent(Intent.ACTION_VIEW, uri).apply {
                        addFlags(
                            Intent.FLAG_ACTIVITY_LAUNCH_ADJACENT or
                                    Intent.FLAG_ACTIVITY_NEW_TASK or
                                    Intent.FLAG_ACTIVITY_MULTIPLE_TASK
                        )
                        if (packageName != null) {
                            setPackage(packageName)
                        }
                    }
                }

                packageName != null -> {
                    val intent = Intent(Intent.ACTION_MAIN)
                    intent.addCategory(Intent.CATEGORY_LAUNCHER)
                    intent.setPackage(packageName)
                    intent.addFlags(
                        Intent.FLAG_ACTIVITY_LAUNCH_ADJACENT or
                                Intent.FLAG_ACTIVITY_NEW_TASK or
                                Intent.FLAG_ACTIVITY_MULTIPLE_TASK
                    )
                }

                else -> throw Exception("Unexpected case")
            }
            activity?.startActivity(intent)
            result.success(true)
        } catch (e: Exception) {
            result.error("EXCEPTION", e.message, e)
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivity() {
        activity = null
    }
}
