import 'package:flutter/material.dart';

class Statewidget extends StatefulWidget {
  const Statewidget({super.key});

  @override
  State<Statewidget> createState() => _Statewidget();
}

class _Statewidget extends State<Statewidget> {
  //변화해야하는 값이므로 일반 변수
  int counter = 0;

  // setState 클릭 이벤트
  void addCount() {
    setState(() {
      counter = counter + 1;
    });
  }

  // setState 클릭 이벤트
  void resetCount() {
    setState(() {
      counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 120,
          ),
          Text(
            'Click count',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          Text(
            '$counter',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: addCount,
                icon: Icon(
                  Icons.add_box_rounded,
                ),
              ),
              IconButton(
                onPressed: resetCount,
                icon: Icon(
                  Icons.restore_page_rounded,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 120,
          ),
        ],
      ),
    );
  }
}
