import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewContainer extends StatefulWidget {
  const WebViewContainer({
    super.key,
  });

  @override
  State<WebViewContainer> createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewContainer> {
  late final WebViewController controller;
  String infoState = '';

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
        NavigationDelegate(onPageFinished: (String url) async {
          final result = await controller.runJavaScriptReturningResult(
              "JSON.parse(localStorage.getItem('userInfo'));") as String;
          setState(() {
            infoState = result;
          });
        }),
      )
      ..loadRequest(
        Uri.parse('https://otcbox.io'),
      );
  }

  @override
  Widget build(BuildContext context) {
    print(infoState);
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
