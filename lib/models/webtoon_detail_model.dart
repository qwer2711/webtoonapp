//Constructor 받아온 값을 할당함

class WebtoonDetailModel {
  final String title, about, genre, age;

  WebtoonDetailModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        about = json['about'],
        genre = json['igenred'],
        age = json['age'];
}
