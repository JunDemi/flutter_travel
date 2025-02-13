import 'package:flutter/material.dart';
import 'package:flutter_travel/models/webtoon_detail_model.dart';
import 'package:flutter_travel/models/webtoon_episode_model.dart';
import 'package:flutter_travel/widgets/episode_title_list.dart';
import 'package:flutter_travel/services/api_service.dart';
import 'package:flutter_travel/widgets/detail_description.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailScreen extends StatefulWidget {
  final String title, thumb, id;

  const DetailScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;
  late SharedPreferences prefs;
  bool isLiked = false;

  //비어있는 로컬 저장소 생성 or 기존 저장소 추가 저장
  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    final likedToons = prefs.getStringList('likedToons');
    if (likedToons != null) {
      if (likedToons.contains(widget.id) == true) {
        setState(() {
          isLiked = true;
        });
      }
    } else {
      await prefs.setStringList('likedToons', []);
    }
  }

  @override
  void initState() {
    super.initState();
    webtoon = ApiService.getToonById(widget.id);
    episodes = ApiService.getLatestEpisodeById(widget.id);
    initPrefs();
  }

  //좋아요 터치
  onHeartTap() async {
    final likedToons = prefs.getStringList('likedToons');
    if (likedToons != null) {
      if (isLiked) {
        likedToons.remove(widget.id);
      } else {
        likedToons.add(widget.id);
      }
      await prefs.setStringList('likedToons', likedToons);
      setState(() {
        isLiked = !isLiked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.green,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: onHeartTap,
            icon: Icon(
              isLiked ? Icons.favorite : Icons.favorite_outline_outlined,
              color: Colors.green,
            ),
          ),
        ],
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            letterSpacing: -1,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 50,
            horizontal: 50,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: widget.id,
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
                      child: Image.network(widget.thumb),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              DetailDescription(webtoon: webtoon),
              SizedBox(
                height: 25,
              ),
              EpisodeTitleList(episodes: episodes, webtoonId: widget.id),
            ],
          ),
        ),
      ),
    );
  }
}
