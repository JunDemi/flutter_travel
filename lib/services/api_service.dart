import 'dart:convert';

import 'package:flutter_travel/models/webtoon.dart';
import 'package:flutter_travel/models/webtoon_detail_model.dart';
import 'package:flutter_travel/models/webtoon_episode_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseURL =
      'https://webtoon-crawler.nomadcoders.workers.dev/';
  static const String today = 'today';

  //함수 타입이 비동기이기 때문에 Future

  //데일리 웹툰 목록 호출
  static Future<List<Webtoon>> getTodayToons() async {
    //인스턴스 변수 초기화
    List<Webtoon> webtoonInstances = [];
    final url = Uri.parse('$baseURL$today');
    //http GET요청
    final response = await http.get(url);

    if (response.statusCode == 200) {
      //json 파싱
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        //파싱한 json값을 필터링 후 인스턴스 변수에 할당
        webtoonInstances.add(Webtoon.fromJson(webtoon));
      }
      return webtoonInstances;
    }
    throw Error();
  }

  //웹툰 상세 정보 호출
  static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse('$baseURL/$id');
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final webtoon = jsonDecode(res.body);
      return WebtoonDetailModel.fromJson(webtoon);
    }
    throw Error();
  }

  //웹툰 상세 정보의 에피소드 목록 호출
  static Future<List<WebtoonEpisodeModel>> getLatestEpisodeById(String id) async {
    List<WebtoonEpisodeModel> episodesInstances = [];
    final url = Uri.parse('$baseURL/$id/episodes');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final episodes = jsonDecode(res.body);
      for (var episode in episodes) {
        episodesInstances.add(WebtoonEpisodeModel.fromJson(episode));
      }
      return episodesInstances;
    }
    throw Error();
  }
}
