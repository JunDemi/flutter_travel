import 'package:flutter/material.dart';
import 'package:flutter_travel/screens/home_screen.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 49, 174, 145),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            color: Color(0xFF232B55),
            fontSize: 28,
            fontWeight: FontWeight.w600,
          ),
        ),
        cardColor: Colors.white,
      ),
      home: HomeScreen(),
    );
  }
}
