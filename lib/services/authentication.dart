import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:otc_mobile/models/user_info_model.dart';
import 'package:otc_mobile/services/decode_json.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Authentication {
  /*자동 로그인*/
  static Future<void> getLoginMaintain(
    WebViewController controller,
    String infoState,
    void Function() setState,
  ) async {
    //flutter storage
    late SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('userInfo');

    //infoState JSON파싱
    UserInfoModel userInfo = DecodeJson.getParseUserState(infoState);

    //데이터 확인용
    inspect(userInfo);
    //1초 딜레이 후 자동 로그인 실행
    Future.delayed(Duration(seconds: 1), () async {
      if (infoState != '' && token != null) {
        await controller.runJavaScript("flutterAutoLogin('$infoState')");
      }
    }).then((_) {
      //FCM 유저 토큰 구독
      if (userInfo.accessToken != '') {
        FirebaseMessaging.instance.subscribeToTopic(userInfo.accessToken!);
      }
      setState();
    });
  }

  /* 로그인 스토리지 저장 */
  static Future<void> getLoginPref(String loginToken) async {
    //flutter storage
    late SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    prefs.setString('userInfo', loginToken);
  }

  /* 로그아웃 */
  static Future<void> getLogOut(void Function() setState) async {
    //flutter storage
    late SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    prefs.remove('userInfo');
    setState();
  }
}
