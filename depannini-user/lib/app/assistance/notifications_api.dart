import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsApi {

  NotificationsApi._();

  static Future<bool> verifyNotificationsEnabled() async {
    final plugin = FlutterLocalNotificationsPlugin()
        .resolvePlatformSpecificImplementation
    <AndroidFlutterLocalNotificationsPlugin>();
    try {
      final bool? areAlreadyEnabled = await plugin?.areNotificationsEnabled();
      if (areAlreadyEnabled == null) return false;
      if (areAlreadyEnabled == true) return true;
      final areEnabled = await plugin?.requestNotificationsPermission();
      return areEnabled ?? false;
    } catch(ex) {
      print(ex);
      return false;
    }
  }

  static Future<int?> _getNotificationId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      int? id = prefs.getInt('lastNotificationId');
      if (id == null) {
        prefs.setInt('lastNotificationId', 0);
        return prefs.getInt('lastNotificationId')!;
      }
      id += 1;
      prefs.setInt('lastNotificationId', id);
      return prefs.getInt('lastNotificationId')!;
    } catch(ex) {
      print(ex);
      return null;
    }
  }

  static Future<void> sendNotification(String title, String body) async {
    final plugin = FlutterLocalNotificationsPlugin();
    final id = await _getNotificationId();
    if (id == null) return;
    final AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      id.toString(),
      'channel_name',
      channelDescription: 'channel_description',
      importance: Importance.max,
      priority: Priority.high,
    );
    final notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
    try {
      await plugin.show(id, title, body, notificationDetails, payload: 'payload');
    } catch(ex) {
      print(ex);
    }
  }

}