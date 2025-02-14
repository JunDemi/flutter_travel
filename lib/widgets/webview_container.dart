import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_travel/models/user_info_model.dart';
import 'package:flutter_travel/services/decode_json.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewContainer extends StatefulWidget {
  const WebViewContainer({
    super.key,
  });

  @override
  State<WebViewContainer> createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewContainer> {
  //webview Controller
  late final WebViewController controller;
  //flutter storage
  late SharedPreferences prefs;
  //유저 정보를 저장할 상태
  String infoState = '';

  //로컬 저장소
  Future initPrefs(Future<UserInfoModel> decoded) async {
    prefs = await SharedPreferences.getInstance();
    prefs.getString('userInfo');

    print(decoded);
  }

  //빌드 이전에 동작
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      // ..addJavaScriptChannel('FlutterUserInfo',
      //     onMessageReceived: (JavaScriptMessage message) {
      //   print(message.message);
      // })
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) async {
            await getInitUserInfo();
          },
        ),
      )
      ..loadRequest(
        Uri.parse('https://otcbox.io'),
      );
  }

  //웹뷰 내의 로컬스토리지 호출 후 상태에 저장
  Future<void> getInitUserInfo() async {
    final result = await controller.runJavaScriptReturningResult(
        "localStorage.getItem('userInfo');") as String;
    var decoded = DecodeJson.getParseUserInfo(result);
    setState(() {
      infoState = result;
    });
    print(decoded);
    //initPrefs(decoded);
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
      body: SafeArea(
        child: WebViewWidget(
          controller: controller,
        ),
      ),
    );
  }
}
