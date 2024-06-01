import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notifikasi {
  static Future initialize(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async{
    var androidInitialize = new AndroidInitializationSettings('mipmap/ic_launcher');
    var initializationSettings = new InitializationSettings(android: androidInitialize);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future tampilkanNotifikasi(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidDetails = new AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker'
    );
    var generalNotificationDetails = new NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Judul Notifikasi',
      'Isi Notifikasi',
      generalNotificationDetails,
      payload: 'payload data'
    );
  }
}
