import 'package:flutter/material.dart';

class ProfileHead extends StatelessWidget {
  const ProfileHead({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.asset(
            'assets/giga-chad.webp',
            width: 50,
            height: 50,
          ),
        ),
        Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ],
    );
  }
}
