import 'dart:convert';

import 'package:http/http.dart' as http;
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
      //응답에서 성공하면 body실행하기
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        final instance = WebtoonModel.fromJson(webtoon);
        webtoonInstances.add(instance);
      }
      return webtoonInstances;
    }
    throw Error();
  }
}
