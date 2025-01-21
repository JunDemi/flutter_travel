import 'package:flutter/material.dart';
import 'package:flutter_travel/widgets/timeTextSpan.dart';

class todoCard extends StatelessWidget {
  final int cardColor;
  final String titleTop;
  final String titleBottom;
  final String startTimeHour;
  final String startTimeMinute;
  final String endTimeHour;
  final String endTimeMinute;
  final List<String> members;

  const todoCard({
    super.key,
    required this.cardColor,
    required this.titleTop,
    required this.titleBottom,
    required this.startTimeHour,
    required this.startTimeMinute,
    required this.endTimeHour,
    required this.endTimeMinute,
    required this.members,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Color(cardColor),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 40,
          bottom: 20,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    TimeTextSpan(
                      hour: startTimeHour,
                      minute: startTimeMinute,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                      child: Container(
                        width: 1,
                        height: 20,
                        color: Colors.black.withValues(alpha: 0.8),
                      ),
                    ),
                    TimeTextSpan(
                      hour: endTimeHour,
                      minute: endTimeMinute,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$titleTop\n$titleBottom',
                  style: TextStyle(
                    fontSize: 55,
                    letterSpacing: -2.5,
                    fontWeight: FontWeight.w500,
                    height: 0.85,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(members.length, (i) {
                      return Padding(
                        padding: EdgeInsets.only(
                          right: 30,
                        ),
                        child: Text(
                          members[i],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -1,
                            color: members[i] == 'ME'
                                ? Colors.black
                                : Colors.black.withValues(alpha: 0.5),
                          ),
                        ),
                      );
                    })),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
