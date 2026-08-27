import 'dart:async';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';
import 'package:otc_mobile/models/global_controller_model.dart';

class NotificationService {
  NotificationService._();
  //인스턴스 초기화
  static final NotificationService instance = NotificationService._();

  //변수 init
  final _messaging = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();
  bool _isFlutterLocalNotificationsInitialized = false;

  //전역 상태
  final getDispatch = Get.put(GlobalControllerModel());

  // 알림 초기화
  Future<void> initNotification() async {
    // Request permission
    await _fcmRequestPermission();

    // Setup message handlers
    await _setupMessageHandlers();

    // Get FCM token
    late final String? fcmToken;
    fcmToken = Platform.isIOS
        ? await _messaging.getAPNSToken()
        : await _messaging.getToken();
    Logger().f(fcmToken);
  }

  //메시지 요청 허용
  Future<void> _fcmRequestPermission() async {
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
      announcement: false,
      carPlay: false,
      criticalAlert: false,
    );
  }

  //Flutter Local Noti 세팅
  Future<void> setupFlutterNotifications() async {
    if (_isFlutterLocalNotificationsInitialized) {
      return;
    }

    // // android setup
    // const channel = AndroidNotificationChannel(
    //   'otc_box_channel',
    //   'OTC BOX Channel',
    //   description: 'OTC BOX 알림 채널입니다.',
    //   importance: Importance.high,
    // );
    _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    // Android 초기 설정
    const initSettingsAndroid =
        AndroidInitializationSettings('ic_notification');

    // iOS 초기 설정
    const initSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    final initializationSettings = InitializationSettings(
      android: initSettingsAndroid,
      iOS: initSettingsIOS,
    );

    // flutter notification setup
    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse noti) {
        Logger().i('FOREGROUND: ${noti.payload}');
        //getDispatch.updateData('go-to-message');
      },
    );

    _isFlutterLocalNotificationsInitialized = true;
  }

  // 알림 표시
  Future<void> showNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    //Logger().e(notification.hashCode);
    if (notification != null && android != null) {
      await _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'otc_box_channel',
            'OTC BOX Channel',
            channelDescription: 'OTC BOX 알림 채널입니다.',
            importance: Importance.high,
            priority: Priority.high,
            icon: 'ic_notification',
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: message.data.toString(),
      );
    }
  }

  //메세지 핸들러
  Future<void> _setupMessageHandlers() async {
    //foreground message
    FirebaseMessaging.onMessage.listen((message) {
      showNotification(message);
    });
  }

  //백그라운드 알림 탭
  Future<void> onBackgroundNotificationResponse() async {
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await _localNotifications.getNotificationAppLaunchDetails();
    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      String payload =
          notificationAppLaunchDetails!.notificationResponse?.payload ?? "";
      Logger().i('BACKGROUND: $payload');
      getDispatch.updateData('go-to-message');
    }
  }
}
