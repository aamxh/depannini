import 'package:depannini_assistant/app/assistance/views/repair_request_details_view.dart';
import 'package:depannini_assistant/app/assistance/views/towing_request_details_view.dart';
import 'package:depannini_assistant/app/auth/common/auth_wrapper_view.dart';
import 'package:depannini_assistant/core/theme_controller.dart';
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
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      final payload = response.payload;
      if (payload != null) {
        if (payload == 'repair') {
          Get.to(() => RepairRequestDetailsV());
        } else if (payload == 'towing') {
          Get.to(() => TowingRequestDetailsV());
        }
      }
    },
  );
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
      home: AuthWrapperV(),
    );
  }

}