import 'package:flutter/material.dart';
import 'package:flutter_travel/models/webtoon_episode_model.dart';
import 'package:flutter_travel/widgets/episode_widget.dart';

class EpisodeTitleList extends StatelessWidget {
  const EpisodeTitleList({
    super.key,
    required this.episodes,
    required this.webtoonId,
  });

  final Future<List<WebtoonEpisodeModel>> episodes;
  final String webtoonId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: episodes,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //ListView ListBuiler는 많은 양의 리스트를 쓸 때
          //최적화용으로 쓰기 때문에 그냥 Column
          return Column(
            children: [
              for (var episode in snapshot.data!)
                Episode(episode: episode, webtoonId: webtoonId),
            ],
          );
        }
        return Container();
      },
    );
  }
}
