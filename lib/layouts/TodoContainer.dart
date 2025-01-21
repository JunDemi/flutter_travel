import 'package:flutter/material.dart';

class TodoContainer extends StatelessWidget {
  const TodoContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Color(0XFFFCF771),
        borderRadius: BorderRadius.circular(25),
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
            Column(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'DESIGN\nMEETING',
                  style: TextStyle(
                    fontSize: 60,
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
                    children: List.generate(3, (i) {
                      return Padding(
                        padding: EdgeInsets.only(
                          right: 30,
                        ),
                        child: Text(
                          'ALEX',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -1,
                            color:
                                Colors.black.withValues(alpha: 0.5),
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