import 'dart:convert';
import 'dart:developer';
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
  static const websiteURL = 'http://localhost:3000';

  //webview Controller
  late final WebViewController controller;
  //flutter storage
  late SharedPreferences prefs;
  //유저 정보를 저장할 상태
  String infoState = '';

  //로컬 스토리지
  Future initPrefs(UserInfoModel decoded) async {
    //Flutter 로컬스토리지 불러오기
    prefs = await SharedPreferences.getInstance();
    final getUserStoage = prefs.getString('userInfo');
    //웹뷰 -> 로그인이 되어 있을 경우
    if (decoded.accessToken != null) {
      //스토리지 생성
      await prefs.setString('userInfo', jsonEncode(decoded));
      inspect(decoded);
      //state 할당
      setState(() {
        infoState = '$decoded';
      });
    } else {
      //Flutter 로그인 값
      if (getUserStoage != null) {
        //로컬스토리지 문자열 -> jsonDecode
        final decodeStorage = jsonDecode(getUserStoage);
        if (decodeStorage is Map<String, dynamic>) {
          //형식에 맞게 파싱
          final parseStorage = UserInfoModel.fromJson(decodeStorage);
          inspect(parseStorage);
          //로그인 정보값을 웹뷰 로컬스토리지에 전달
          await controller.runJavaScript("쿠키 및 전역상태 + 로컬스토리지 토큰 등록 함수 입력");
          //state 할당
          setState(() {
            infoState = '$parseStorage';
          });
        }
      }
    }
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
        Uri.parse(websiteURL),
      );
  }

  //웹뷰 내의 로컬스토리지 호출 후 상태에 저장
  Future<void> getInitUserInfo() async {
    final result = await controller.runJavaScriptReturningResult(
        "localStorage.getItem('userInfo');") as String;
    var decoded = DecodeJson.getParseUserState(result);
    initPrefs(decoded);
    //inspect(decoded);
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
