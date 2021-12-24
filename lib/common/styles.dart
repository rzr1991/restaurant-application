import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class Styles {
  static const TextStyle restaurantHomeText = TextStyle(
    color: Colors.white,
    fontSize: 22,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle splashScreenText = TextStyle(
    color: Colors.brown,
    fontSize: 28,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle restaurantNameOnList = TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle restaurantNameOnDetail = TextStyle(
    color: Colors.black,
    fontSize: 22,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle restaurantLocationOnList = TextStyle(
    color: Colors.brown,
    fontSize: 16,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle restaurantRatingOnList = TextStyle(
    color: Colors.red,
    fontSize: 16,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle restaurantLocationOnDetail = TextStyle(
    color: Colors.brown,
    fontSize: 18,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle restaurantRatingOnDetail = TextStyle(
    color: Colors.red,
    fontSize: 18,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle restaurantDescription = TextStyle(
    color: Colors.black,
    fontSize: 18,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle detailSegment = TextStyle(
    color: Colors.brown,
    fontSize: 20,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle menuText = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle productsSegment = TextStyle(
    color: Colors.black,
    fontSize: 18,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle searchText = TextStyle(
    color: Color.fromRGBO(115, 61, 0, 1.0),
    fontSize: 18,
    fontStyle: FontStyle.normal,
  );

  static const TextStyle menuName = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle reviewName = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle reviewDate = TextStyle(
    color: Colors.black,
    fontSize: 12,
    fontStyle: FontStyle.normal,
  );

  static const TextStyle reviewDesc = TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontStyle: FontStyle.normal,
  );

  static const Color searchBackground = Color.fromRGBO(255, 255, 255, 1.0);

  static const Color searchCursorColor = Colors.black;

  static const Color searchIconColor = Color.fromRGBO(84, 48, 0, 1.0);

  static const Color backgroundColor = Color.fromRGBO(177, 106, 63, 1.0);
}
