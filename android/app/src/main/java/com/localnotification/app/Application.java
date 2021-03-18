package com.localnotification.app;

import android.os.Build;
import com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin;
import io.flutter.app.FlutterApplication;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback;

public class Application
  extends FlutterApplication
  implements PluginRegistrantCallback {

  @Override
  public void onCreate() {
    super.onCreate();
  }

  @Override
  public void registerWith(PluginRegistry registry) {
    FlutterLocalNotificationsPlugin.registerWith(
      registry.registrarFor(
        "com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin"
      )
    );
  }
}
