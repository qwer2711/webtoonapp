import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nomadcoder_four_app/models/webtoon_detail_model.dart';
import 'package:nomadcoder_four_app/models/webtoon_episode_model.dart';
import 'package:nomadcoder_four_app/models/webtoon_model.dart';

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  static Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];
    //API 서버에 요청하기 await 서버응답 기다리기
    final url = Uri.parse('$baseUrl/$today');
    //>> 응답을 reponse변수에 저장
    final response = await http.get(url);
    //상태코드가 200인지 체크하기
    if (response.statusCode == 200) {
      //응답에서 성공하면 body실행하기 데이터 구조화 Map = webtoons
      final List<dynamic> webtoons = jsonDecode(response.body);

      List.generate(
        webtoons.length,
        (index) => {
          //List에 추가
          webtoonInstances.add(WebtoonModel.fromJson(webtoons[index]))
        },
      );
      webtoonInstances[0].title;
      webtoonInstances[0].thumb;
      webtoonInstances[0].id;
      // for (var webtoon in webtoons) {
      //   //값: webtoons[webtoon]
      //   //인스턴스 모델 가져오기
      //   final instance = WebtoonModel.fromJson(webtoon);
      //   //List에 추가
      //   webtoonInstances.add(instance);
      // }
      return webtoonInstances;
    }
    throw Error();
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse('$baseUrl/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response.body); //String 으로 받아온 값을 구조화 decode
      return WebtoonDetailModel.fromJson(
          webtoon); //받아온 Json을 WebtoonDetailModel constructor로 보냄
    }
    return throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getLatestEpisodesById(
      String id) async {
    List<WebtoonEpisodeModel> episodesInstances = [];
    final url = Uri.parse('$baseUrl/$id/episodes');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final episodes = jsonDecode(response.body); //String 으로 받아온 값을 Json으로 변경
      for (var episode in episodes) {
        episodesInstances.add(WebtoonEpisodeModel.fromJson(episodes));
      }
      return episodesInstances;
    }
    return throw Error();
  }
}
