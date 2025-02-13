import 'package:flutter/material.dart';
import 'package:flutter_travel/models/webtoon_detail_model.dart';

class DetailDescription extends StatelessWidget {
  const DetailDescription({
    super.key,
    required this.webtoon,
  });

  final Future<WebtoonDetailModel> webtoon;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: webtoon,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  snapshot.data!.about,
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  '${snapshot.data!.genre} / ${snapshot.data!.age}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            );
          }
          return Text('...');
        });
  }
}
