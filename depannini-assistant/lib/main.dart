import 'package:depannini_assistant/app/assistance/repair_request_details_view.dart';
import 'package:depannini_assistant/app/main/enable_location_view.dart';
import 'package:depannini_assistant/core/theme_controller.dart';
import 'app/main/welcome_view.dart';
import 'core/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
const androidInitializationSettings =
AndroidInitializationSettings('@mipmap/ic_launcher');
final initializationSettings = InitializationSettings(
  android: androidInitializationSettings,
  iOS: DarwinInitializationSettings(),
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeApp();
  runApp(MyApp());
}

Future<void> _initializeApp() async {
  //  await Firebase.initializeApp(
  //    options: DefaultFirebaseOptions.currentPlatform,
  //  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        if (response.payload != null) {
          print('Notification payload: ${response.payload}');
          Get.to(() => RepairRequestDetailsV());
        }
  });
  Get.put(ThemeCtrl());
}

class MyApp extends StatelessWidget {

  MyApp({super.key});

  final themeCtrl = Get.find<ThemeCtrl>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      themeMode: themeCtrl.isDark ? ThemeMode.dark : ThemeMode.light,
      home: EnableLocationV(),
    );
  }

}