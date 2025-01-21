import 'package:flutter/material.dart';
import 'package:flutter_travel/layouts/DateSelector.dart';
import 'package:flutter_travel/layouts/ProfileHead.dart';
import 'package:flutter_travel/layouts/TodoContainer.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final today = 16;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          titleLarge: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      home: Scaffold(
        backgroundColor: Color(0xFF181818),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 80,
                ),
                ProfileHead(),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'MONDAY $today',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                DateSelector(today: today),
                SizedBox(
                  height: 15,
                ),
                TodoContainer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
