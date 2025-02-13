import 'package:flutter/material.dart';
import 'package:flutter_travel/models/webtoon_episode_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Episode extends StatelessWidget {
  const Episode({
    super.key,
    required this.episode,
    required this.webtoonId,
  });

  final WebtoonEpisodeModel episode;
  final String webtoonId;

  onButtonTap() async {
    await launchUrlString(
        "https://comic.naver.com/webtoon/detail?titleId=$webtoonId&no=${episode.id}");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onButtonTap,
      child: Container(
        margin: EdgeInsets.only(
          bottom: 10,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.green.shade300,
            width: 2,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: Text(
                  episode.title,
                  softWrap: false,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: Colors.green.shade300,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
