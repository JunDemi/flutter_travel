import 'package:flutter/material.dart';
import 'package:flutter_travel/models/webtoon.dart';
import 'package:flutter_travel/services/api_service.dart';
import 'package:flutter_travel/widgets/webtoon_wiget.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  Future<List<Webtoon>> webtoons = ApiService.getTodayToons();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.green,
        backgroundColor: Colors.white,
        title: Text(
          'Daily WebToons',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            letterSpacing: -1,
          ),
        ),
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Expanded(
                  child: makeList(snapshot),
                ),
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<Webtoon>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      separatorBuilder: (context, index) {
        return SizedBox(
          width: 30,
        );
      },
      itemBuilder: (context, index) {
        var webtoon = snapshot.data![index];
        return WebtoonWiget(
          title: webtoon.title,
          thumb: webtoon.thumb,
          id: webtoon.id,
        );
      },
    );
  }
}
