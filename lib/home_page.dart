import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:random_string/random_string.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  var initializationSettings;
  var initializationSettingsAndroid;
  var initializationSettingsIOS;

  @override
  void initState() {
    super.initState();
    setupNotification();
  }

  void setupNotification() {
    initializationSettingsAndroid = AndroidInitializationSettings('ic_launcher');
    initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        // your call back to the UI
      },
    );
    initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> cancelNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> scheduleNotification() async {
    // var scheduleNotificationDateTime = DateTime.now().add(Duration(minutes: 10));
    // print('scheduleNotificationDateTime: $scheduleNotificationDateTime');
    // var androidChannelSpecifics = AndroidNotificationDetails(
    //   'Demo',
    //   'Demo Channel',
    //   'Send notification for test',
    //   enableLights: true,
    //   importance: Importance.Max,
    //   priority: Priority.High,
    //   playSound: true,
    //   styleInformation: DefaultStyleInformation(true, true),
    // );
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'every_hour_id',
      'every_hour_channel',
      'Send notification for test',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      playSound: true,
    );
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosChannelSpecifics,
    );
    // This will show notification at every hour
    await flutterLocalNotificationsPlugin.periodicallyShow(
      int.parse(randomNumeric(5)),
      'Notification at ${DateTime.now()}',
      'Local Notification Periodically',
      RepeatInterval.hourly,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
    );
  }

  Future<void> scheduleNotificationEveryMinute() async {
    // var scheduleNotificationDateTime = DateTime.now().add(Duration(minutes: 10));
    // print('scheduleNotificationDateTime: $scheduleNotificationDateTime');
    // var androidChannelSpecifics = AndroidNotificationDetails(
    //   'Demo',
    //   'Demo Channel',
    //   'Send notification for test',
    //   enableLights: true,
    //   importance: Importance.Max,
    //   priority: Priority.High,
    //   playSound: true,
    //   styleInformation: DefaultStyleInformation(true, true),
    // );
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'every_minute_id',
      'every_minute_channel',
      'Send notification for test',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      playSound: true,
    );
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosChannelSpecifics,
    );
    // This will show notification at every hour
    await flutterLocalNotificationsPlugin.periodicallyShow(
      int.parse(randomNumeric(5)),
      'Notification at ${DateTime.now()}',
      'Local Notification Periodically',
      RepeatInterval.everyMinute,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
    );
  }

  Future<void> scheduleDailyTenAMNotification() async {
    // This will show notification at 10AM daily
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'daily scheduled notification title',
      'Notification at 10:00 AM',
      _nextInstanceOfTenAM(),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_id',
          'daily_channel',
          'daily notification description',
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  tz.TZDateTime _nextInstanceOfTenAM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, 10);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  // Future<void> scheduleNotification() async {
  //   // var scheduleNotificationDateTime = DateTime.now().add(Duration(minutes: 10));
  //   // print('scheduleNotificationDateTime: $scheduleNotificationDateTime');
  //   var androidChannelSpecifics = AndroidNotificationDetails(
  //     'Demo',
  //     'Demo Channel',
  //     'Send notification for test',
  //     enableLights: true,
  //     importance: Importance.Max,
  //     priority: Priority.High,
  //     playSound: true,
  //     styleInformation: DefaultStyleInformation(true, true),
  //   );
  //   var iosChannelSpecifics = IOSNotificationDetails();
  //   var platformChannelSpecifics = NotificationDetails(
  //     androidChannelSpecifics,
  //     iosChannelSpecifics,
  //   );
  //   await flutterLocalNotificationsPlugin.schedule(
  //     0,
  //     'Demo App',
  //     'Scheduled',
  //     DateTime.now(),
  //     platformChannelSpecifics,
  //     androidAllowWhileIdle: true,
  //     // uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
  //     // payload: 'notification',
  //   );
  //   await flutterLocalNotificationsPlugin.periodicallyShow(
  //     1,
  //     'Notification at ${DateTime.now()}',
  //     'Local Notification Periodically',
  //     RepeatInterval.EveryMinute,
  //     platformChannelSpecifics,
  //   );
  //   await flutterLocalNotificationsPlugin.showDailyAtTime(
  //     2,
  //     'Notification at ${DateTime.now()}',
  //     'Local Notification showDailyAtTime',
  //     Time(14, 26, 0),
  //     platformChannelSpecifics,
  //   );
  //   print('Notification setup done');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RaisedButton(
                onPressed: () {
                  scheduleNotificationEveryMinute();
                },
                child: Text(
                  'Setup Notification Every Minute',
                ),
              ),
              RaisedButton(
                onPressed: () {
                  scheduleNotification();
                },
                child: Text(
                  'Setup Notification Every Hour',
                ),
              ),
              RaisedButton(
                onPressed: () {
                  scheduleDailyTenAMNotification();
                },
                child: Text(
                  'Setup Notification Every Day 10 AM',
                ),
              ),
              RaisedButton(
                onPressed: () {
                  cancelNotification();
                },
                child: Text(
                  'Cancel All Notification',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
