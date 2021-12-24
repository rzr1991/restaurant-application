import 'package:flutter_test/flutter_test.dart';
import 'package:restaurants/data/model/restaurants.dart';

void main() {
  test('memparsing json ke restaurant model', () {
    const id = "abcdefghijklmnopqrs";
    const name = "Mama Mia";
    const description =
        "Ini adalah restoran milik Mama Mia";
    const pictureId = "12";
    const city = "Bekasi";
    const double rating = 4.8;

    final json = {
      "id": "abcdefghijklmnopqrs",
      "name": "Mama Mia",
      "description":
      "Ini adalah restoran milik Mama Mia",
      "pictureId": "12",
      "city": "Bekasi",
      "rating": 4.8
    };

    Restaurant result = Restaurant.fromJson(json);
    expect(result.id, id);
    expect(result.name, name);
    expect(result.description, description);
    expect(result.pictureId, pictureId);
    expect(result.city, city);
    expect(result.rating, rating);
  });
}
