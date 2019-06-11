package com.power.aided_driving_app;

import android.os.Bundle;

import com.power.aided_driving_app.Plugin.AI.AINativePlugin;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    registerCustomPlugin(this);
  }

  private void registerCustomPlugin(PluginRegistry registry){
    AINativePlugin.registerWith(registry.registrarFor(AINativePlugin.CHANNEL));
  }
}
