import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurants/data/model/restaurants.dart';
import 'package:restaurants/data/model/restaurants_detail.dart' as details;
import 'package:restaurants/data/model/restaurants_reviews.dart';
import 'package:restaurants/data/model/restaurants_search.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String _list = 'list';
  static const String _detail = 'detail/';
  static const String _search = 'search?q=';
  static const String imgUrl = '${_baseUrl}images/medium/';
  static const String _postReview = 'review';

  Future<Restaurants> listRestaurants() async {
    final response = await http.get(Uri.parse(_baseUrl + _list));
    if (response.statusCode == 200) {
      return Restaurants.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant list');
    }
  }

  Future<details.RestaurantDetails> restaurantDetails(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + _detail + id));
    if (response.statusCode == 200) {
      return details.RestaurantDetails.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant\'s detail');
    }
  }

  Future<RestaurantSearch> restaurantSearch(String query) async {
    final response = await http.get(Uri.parse(_baseUrl + _search + query));
    if (response.statusCode == 200) {
      return RestaurantSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load search item');
    }
  }

  Future<RestaurantReview> postReview(CustomerReview review) async {
    var _review = jsonEncode(review.toJson());
    final response = await http.post(
      Uri.parse(_baseUrl + _postReview),
      body: _review,
      headers: <String, String>{
        "Content-Type": "application/json",
      },
    );
    return RestaurantReview.fromJson(json.decode(response.body));
  }
}
