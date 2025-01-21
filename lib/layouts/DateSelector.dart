import 'package:flutter/material.dart';

class DateSelector extends StatelessWidget {
  final int today;
  const DateSelector({super.key, required this.today});

  @override
  Widget build(BuildContext context) {
    final int limitOfDays = 32 - today;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(limitOfDays, (i) {
            return Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: i + today == today ? 0 : 8,
                    right: 8,
                  ),
                  child: Text(
                    i + today == today ? 'TODAY' : (i + today).toString(),
                    style: TextStyle(
                      letterSpacing: -1,
                      color: i + today == today
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.5),
                      fontSize: 35,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                if (i + 1 != limitOfDays) ...[
                  Icon(
                    Icons.circle,
                    size: 8,
                    color: Colors.pink,
                  ),
                ]
              ],
            );
          })),
    );
  }
}
