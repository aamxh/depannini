import 'package:depannini_user/app/auth/common/auth_wrapper_view.dart';
import 'package:depannini_user/core/theme_controller.dart';
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
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Handle notification tap
        if (response.payload != null) {

        }
  });
  Get.put(ThemeCtrl());
}

class MyApp extends StatelessWidget {

  MyApp({super.key});

  final theme = Get.find<ThemeCtrl>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: MyTheme.lightTheme,
        darkTheme: MyTheme.darkTheme,
        themeMode: theme.isDark ? ThemeMode.dark : ThemeMode.light,
        home: AuthWrapperV(),
      ),
    );
  }

}