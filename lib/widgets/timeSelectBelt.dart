import 'package:flutter/material.dart';

class TimeSelectBelt extends StatefulWidget {
  final Function(int) updateTime;
  final int selectedTime;
  const TimeSelectBelt({
    super.key,
    required this.updateTime,
    required this.selectedTime,
  });

  @override
  State<TimeSelectBelt> createState() => _TimeSelectBeltState();
}

class _TimeSelectBeltState extends State<TimeSelectBelt> {
  final List<int> timeOptions = [2, 15, 20, 25, 30, 35];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(timeOptions.length, (i) {
          return TextButton(
            onPressed: () {
              //setState()를 호출하는 시점을 조정
              Future.delayed(Duration.zero, () {
                widget.updateTime(timeOptions[i]);
              });
            },
            child: Container(
              width: 70,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).cardColor,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(30),
                color: widget.selectedTime == timeOptions[i]
                    ? Theme.of(context).cardColor
                    : Theme.of(context).scaffoldBackgroundColor,
              ),
              child: Text(
                '${timeOptions[i]}',
                style: TextStyle(
                  color: widget.selectedTime == timeOptions[i]
                      ? Theme.of(context).scaffoldBackgroundColor
                      : Theme.of(context).cardColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -1,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
