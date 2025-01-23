import 'package:flutter/material.dart';
import 'package:flutter_travel/widgets/cardTable.dart';
import 'package:flutter_travel/widgets/interTimer.dart';

class TimerContainer extends StatelessWidget {
  final List<String> totalSeconds;
  const TimerContainer({
    super.key,
    required this.totalSeconds,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 50,
        bottom: 30,
      ),
      child: Container(
        alignment: Alignment.center,
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CardTable(),
                    Text(
                      totalSeconds[0],
                      style: TextStyle(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        fontSize: 55,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -4,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: 15,
                ),
                InterTimer(),
                SizedBox(
                  width: 15,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CardTable(),
                    Text(
                      totalSeconds[1],
                      style: TextStyle(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        fontSize: 55,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -4,
                      ),
                    )
                  ],
                ),
              ],
            ),
            // Text(
            //   widget.totalSeconds,
            //   style: TextStyle(
            //     color: Theme.of(context).scaffoldBackgroundColor,
            //     fontSize: 70,
            //     fontWeight: FontWeight.w600,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
