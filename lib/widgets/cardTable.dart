import 'package:flutter/material.dart';

class CardTable extends StatelessWidget {
  const CardTable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: Alignment.center,
        children: List.generate(3, (i) {
          return Transform.translate(
            offset: Offset(0, -10 + (i * 5)),
            child: Container(
              width: 86 + (i * 7),
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: Theme.of(context)
                    .cardColor
                    .withValues(alpha: 0.4 + (i * 0.3)),
              ),
            ),
          );
        }));
  }
}
