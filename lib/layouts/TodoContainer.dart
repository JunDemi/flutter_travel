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
      children: List.generate(todo_data.length, (index) {
        return Padding(
            padding: EdgeInsets.symmetric(
              vertical: 5,
            ),
            child: todoCard(
              cardColor: todo_data[index]['cardColor'],
              titleTop: todo_data[index]['title-top'],
              titleBottom: todo_data[index]['title-bottom'],
              startTimeHour: todo_data[index]['startTime-h'],
              startTimeMinute: todo_data[index]['startTime-m'],
              endTimeHour: todo_data[index]['endTime-h'],
              endTimeMinute: todo_data[index]['endTime-m'],
              members: todo_data[index]['members'],
            ));
      }),
    );
  }
}
