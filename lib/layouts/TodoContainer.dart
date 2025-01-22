import 'package:flutter/material.dart';
import 'package:flutter_travel/widgets/todoCard.dart';
import '../api/todo_data.dart';

// ignore: use_key_in_widget_constructors
class TodoContainer extends StatelessWidget {
  const TodoContainer({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(todoData.length, (index) {
        return Padding(
            padding: EdgeInsets.symmetric(
              vertical: 5,
            ),
            child: todoCard(
              cardColor: todoData[index]['cardColor'],
              titleTop: todoData[index]['title-top'],
              titleBottom: todoData[index]['title-bottom'],
              startTimeHour: todoData[index]['startTime-h'],
              startTimeMinute: todoData[index]['startTime-m'],
              endTimeHour: todoData[index]['endTime-h'],
              endTimeMinute: todoData[index]['endTime-m'],
              members: todoData[index]['members'],
            ));
      }),
    );
  }
}
