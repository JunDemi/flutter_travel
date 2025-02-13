import 'package:flutter/material.dart';
import 'package:flutter_travel/screens/detail_screen.dart';

class WebtoonWiget extends StatelessWidget {
  final String title, thumb, id;

  const WebtoonWiget({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              title: title,
              thumb: thumb,
              id: id,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Hero(
            tag: id,
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 15,
                    offset: Offset(6, 6),
                    color: Colors.black.withValues(alpha: 0.5),
                  ),
                ],
              ),
              width: 250,
              child: Image.network(thumb),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
