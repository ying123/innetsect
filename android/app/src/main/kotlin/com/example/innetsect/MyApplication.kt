package com.example.innetsect

import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.graphics.Color
import android.os.AsyncTask
import android.os.Build
import android.util.Log
import com.alibaba.sdk.android.push.CloudPushService.LOG_INFO
import com.alibaba.sdk.android.push.CommonCallback
import com.alibaba.sdk.android.push.noonesdk.PushServiceFactory
import com.jarvanmo.rammus.RammusPushIntentService
import io.flutter.app.FlutterApplication
class MyApplication:FlutterApplication() {
    override fun onCreate() {
        super.onCreate()
        PushServiceFactory.init(applicationContext)
        val pushService = PushServiceFactory.getCloudPushService()
        val callback = object : CommonCallback {
            override fun onSuccess(response: String?) {
                Log.e("TAG","success $response")
            }
            override fun onFailed(errorCode: String?, errorMessage: String?) {
                Log.e("TAG","error $errorMessage")
            }
        }
        pushService.register(applicationContext,callback)
        //一定要添加这一句代码
        pushService.setPushIntentService(RammusPushIntentService::class.java)
    }
}