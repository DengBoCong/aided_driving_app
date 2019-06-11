package com.power.aided_driving_app.Plugin.AI;

import android.app.Activity;
import android.content.Intent;
import android.nfc.Tag;
import android.widget.Toast;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public class AINativePlugin implements MethodChannel.MethodCallHandler {
    public static String CHANNEL = "com.power/AI";
    static MethodChannel channel;
    private Activity activity;
    private AINativePlugin(Activity activity){
        this.activity = activity;
    }

    public static void registerWith(PluginRegistry.Registrar registrar){
        channel = new MethodChannel(registrar.messenger(), CHANNEL);
        AINativePlugin instance = new AINativePlugin(registrar.activity());
        channel.setMethodCallHandler(instance);
    }

    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        if(methodCall.method.equals("enterIvwActivity")){
            Intent intent = new Intent(activity, IvwActivity.class);
            activity.startActivity(intent);
        }else{
            result.notImplemented();
        }
    }
}
