import 'package:flutter/material.dart';

class TimeTextSpan extends StatelessWidget {
  final String hour;
  final String minute;

  const TimeTextSpan({
    super.key,
    required this.hour,
    required this.minute,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$hour\n',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              letterSpacing: -1,
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: minute,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: -1,
              color: Colors.black,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
