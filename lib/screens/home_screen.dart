import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_travel/widgets/timeSelectBelt.dart';
import 'package:flutter_travel/widgets/timerContainer.dart';

const int initialSeconds = 900;
const int totalRound = 3;
const int totalGoal = 10;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int totalSeconds = initialSeconds;
  int selectedTime = 15;
  bool isRunning = false;
  int totalPomodoros = 0;
  int roundAmount = 0;
  bool isBreakTime = false;
  late Timer timer;

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      if (totalPomodoros == totalRound) {
        setState(() {
          isBreakTime = true;
          totalPomodoros = 0;
          roundAmount++;
          isRunning = true;
          totalSeconds = 300;
        });
      } else {
        setState(() {
          isBreakTime = false;
          totalPomodoros++;
          isRunning = false;
          totalSeconds = selectedTime;
        });
        timer.cancel();
      }
    } else {
      setState(() {
        totalSeconds--;
      });
    }
  }

  //시간 변경
  void onUpdateTimePressed(int second) {
    setState(() {
      totalSeconds = second == 2 ? second : second * 60;
      selectedTime = second;
      isRunning = false;
    });

    timer.cancel();
  }

  void onStartPressed() {
    timer = Timer.periodic(
      Duration(seconds: 1),
      onTick,
    );
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onResetPressed() {
    timer.cancel();
    setState(() {
      totalSeconds = selectedTime == 2 ? selectedTime : selectedTime * 60;
      isBreakTime = false;
      isRunning = false;
      totalPomodoros = 0;
      roundAmount = 0;
    });
  }

  List<String> formatTime(int seconds) {
    var duration = Duration(seconds: seconds);
    String splitTime = duration.toString().split('.').first.substring(2, 7);

    String splitMitutes = splitTime.split(':')[0];
    String splitSeconds = splitTime.split(':')[1];
    return [splitMitutes, splitSeconds];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          SizedBox(
            height: 70,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  Text(
                    'POMOTIMER',
                    style: TextStyle(
                      color: Theme.of(context).cardColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.8,
                    ),
                  ),
                  IconButton(
                    onPressed: onResetPressed,
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          TimerContainer(
            totalSeconds: formatTime(totalSeconds),
          ),
          if (isBreakTime) ...[
            Text(
              'Break Time!',
              style: TextStyle(
                color: Theme.of(context).cardColor,
                fontSize: 18,
              ),
            ),
          ],
          TimeSelectBelt(
            updateTime: onUpdateTimePressed,
            selectedTime: selectedTime,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 80,
            ),
            child: Center(
              child: IconButton(
                onPressed: isRunning ? onPausePressed : onStartPressed,
                icon: Icon(
                  isRunning
                      ? Icons.pause_circle_outline
                      : Icons.play_circle_outline,
                ),
                iconSize: 90,
                color: Theme.of(context).cardColor,
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 80,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 70,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$totalPomodoros/$totalRound',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Theme.of(context).cardColor.withValues(
                                  alpha: 0.5,
                                ),
                          ),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          'ROUND',
                          style: TextStyle(
                            fontSize: 15,
                            letterSpacing: -1,
                            fontWeight: FontWeight.w800,
                            color: Theme.of(context).cardColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 70,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$roundAmount/$totalGoal',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Theme.of(context).cardColor.withValues(
                                  alpha: 0.5,
                                ),
                          ),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          'GOAL',
                          style: TextStyle(
                            fontSize: 15,
                            letterSpacing: -1,
                            fontWeight: FontWeight.w800,
                            color: Theme.of(context).cardColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
