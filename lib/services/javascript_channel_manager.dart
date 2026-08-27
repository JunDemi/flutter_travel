import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:logger/web.dart';
import 'package:otc_mobile/services/authentication.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webview_flutter/webview_flutter.dart';

class JavaScriptChannelManager {
  final WebViewController controller;
  final void Function() setState;

  //안드로이드 - 이미지 첨부
  final ImagePicker _picker = ImagePicker();
  bool isPickerActive = false;

  //생성자
  JavaScriptChannelManager(this.controller, this.setState) {
    getChannelContainer();
  }

  //웹뷰 로그인 시 토큰 발행 후 shared preference 저장
  void _addLoginTokenChannel() {
    controller.addJavaScriptChannel(
      'FLUTTER_LOGIN_TOKEN',
      onMessageReceived: (JavaScriptMessage loginToken) async {
        await Authentication.getLoginPref(loginToken.message);
      },
    );
  }

  //로그아웃하면 shared preference, state 지우기
  void _addLogoutChannel() {
    controller.addJavaScriptChannel(
      'FLUTTER_LOGOUT',
      onMessageReceived: (JavaScriptMessage logout) async {
        await Authentication.getLogOut(() {
          setState();
        });
      },
    );
  }

  //고객 센터 페이지 이동
  void _addHelpCenterChannel() {
    controller.addJavaScriptChannel(
      'FLUTTER_HELP_CENTER',
      onMessageReceived: (JavaScriptMessage helpCenterURL) async {
        await launchUrlString(helpCenterURL.message);
      },
    );
  }

  //Android 파일 첨부
  void _addAndroidFileUpload() {
    if (Platform.isAndroid) {
      controller.addJavaScriptChannel(
        'FLUTTER_FILE_UPLOAD',
        onMessageReceived: (JavaScriptMessage fileUpload) async {
          //앨범 창이 이미 호출되어있을 경우
          if (isPickerActive) {
            return;
          } else {
            try {
              isPickerActive = true;
              //Image picker
              final XFile? image =
                  await _picker.pickImage(source: ImageSource.gallery);

              //이미지 선택
              if (image != null) {
                //이미지 파일을 base64 형 변환
                final Uint8List bytes = await image.readAsBytes();
                final String base64 = base64Encode(bytes);
                controller
                    .runJavaScript("flutterAndroidUploadImage('$base64')");
              }
            } catch (error) {
              Logger().e(error);
            } finally {
              //앨범 창을 닫으면
              isPickerActive = false;
            }
          }
        },
      );
    }
  }

  //addJavaScriptChannels 메소드 묶음
  void getChannelContainer() {
    _addLoginTokenChannel();
    _addLogoutChannel();
    _addHelpCenterChannel();
    _addAndroidFileUpload();
  }
}
