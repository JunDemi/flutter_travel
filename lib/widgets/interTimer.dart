import 'package:flutter/material.dart';

class InterTimer extends StatelessWidget {
  const InterTimer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.circle,
          color: Colors.white.withValues(alpha: 0.5),
          size: 10,
        ),
        SizedBox(
          height: 15,
        ),
        Icon(
          Icons.circle,
          color: Colors.white.withValues(alpha: 0.5),
          size: 10,
        ),
      ],
    );
  }
}
