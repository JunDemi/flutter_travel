import 'package:flutter/material.dart';
import 'package:flutter_travel/widgets/webview_container.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const WebViewApp(),
    ),
  );
}

class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key});

  @override
  State<WebViewApp> createState() => _AppState();
}

class _AppState extends State<WebViewApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WebViewContainer(),
    );
  }
}
