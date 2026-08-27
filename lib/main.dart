import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otc_mobile/firebase_options.dart';
import 'package:otc_mobile/models/global_controller_model.dart';
import 'package:otc_mobile/screens/webview_screen.dart';
import 'package:otc_mobile/services/notification_service.dart';

//백그라운드 메세지 핸들러
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await NotificationService.instance.setupFlutterNotifications();
  await NotificationService.instance.showNotification(message);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(GlobalControllerModel());
  //firebase 초기화
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //firebase 백그라운드 메세징
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  //flutter local notification 초기화
  await NotificationService.instance.initNotification();
  await NotificationService.instance.setupFlutterNotifications();
  await NotificationService.instance.onBackgroundNotificationResponse();

  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: WebViewScreen(),
    );
  }
}
