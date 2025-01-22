import 'package:flutter/material.dart';
import 'package:flutter_travel/screens/home_screen.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFE7626C),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            color: Color(0xFF232B55),
            fontSize: 28,
            fontWeight: FontWeight.w600,
          ),
        ),
        cardColor: Color(0xFFF4EDDB),
      ),
      home: HomeScreen(),
    );
  }
}
