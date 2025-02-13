class Webtoon {
  final String title, thumb, id;

  //named 생성자
  Webtoon.fromJson(Map<String, dynamic> parsedJson)
      : title = parsedJson['title'],
        thumb = parsedJson['thumb'],
        id = parsedJson['id'];
}
