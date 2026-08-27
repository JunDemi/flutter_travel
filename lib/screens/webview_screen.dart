import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';
import 'package:otc_mobile/models/global_controller_model.dart';
import 'package:otc_mobile/services/authentication.dart';
import 'package:otc_mobile/services/javascript_channel_manager.dart';
import 'package:otc_mobile/widgets/intro_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({
    super.key,
  });

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final GlobalControllerModel getSelect = Get.find();

  static const websiteURL = 'https://dev.otcbox.io';
  static const websiteMessageURL = 'https://dev.otcbox.io/my-page/message/';

  //flutter storage
  late SharedPreferences prefs;

  //State
  String infoState = '';
  bool introVisible = true;

  //webview Controller
  late final WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {},
        //페이지 시작 전 로그인 확인 여부
        onPageStarted: (String url) async {
          prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('userInfo');
          //로그인 토큰이 있으면 state에 저장
          setState(() {
            if (token != null) infoState = token;
          });
        },
        //페이지 마운트 후 로그인 정보를 웹뷰에 전달(로그인 유지)
        onPageFinished: (String url) async {
          await Authentication.getLoginMaintain(
            controller,
            infoState,
            () {
              setState(() {
                introVisible = false;
              });
            },
          );
        },
        onHttpError: (HttpResponseError error) {
          Logger().e(error);
        },
        onWebResourceError: (WebResourceError error) {
          Logger().e(error.description);
        },
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://otcbox.io')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    );

  //빌드 이전에 동작
  @override
  void initState() {
    //기본 실행 URL
    if (getSelect.data == RxString('go-to-message')) {
      controller.loadRequest(Uri.parse(websiteMessageURL));
    } else {
      controller.loadRequest(Uri.parse(websiteURL));
    }

    // //백그라운드 메세지 - 앱 실행 화면 밖에서 메세지 수신
    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
    //   if (message != null) {
    //     if (message.notification != null) {
    //       //메세지 페이지 URL
    //       controller.loadRequest(Uri.parse(websiteMessageURL));
    //     }
    //   }
    // });

    // //백그라운드 메세지 - 앱 종료 상태에서 메세지 수신
    // FirebaseMessaging.instance
    //     .getInitialMessage()
    //     .then((RemoteMessage? message) {
    //   if (message != null) {
    //     if (message.notification != null) {
    //       //메세지 페이지 URL
    //       controller.loadRequest(Uri.parse(websiteMessageURL));
    //     }
    //   }
    // });
    super.initState();
  }

  //state 변경 시 동작
  @override
  void didChangeDependencies() {
    //addJavaScriptChannels 메소드
    JavaScriptChannelManager(controller, () {
      setState(() {
        infoState = '';
      });
    });
    super.didChangeDependencies();
  }

  //build
  @override
  Widget build(BuildContext context) {
    //배경색
    Color getBgColor() {
      return Platform.isAndroid ? Colors.black : Colors.white;
    }

    return Scaffold(
      backgroundColor: getBgColor(),
      body: Stack(
        children: [
          SafeArea(
            bottom: false,
            child: WebViewWidget(controller: controller),
          ),
          IntroWidget(introVisible: introVisible),
        ],
      ),
    );
  }
}
