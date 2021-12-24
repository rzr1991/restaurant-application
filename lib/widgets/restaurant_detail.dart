import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurants/common/styles.dart';
import 'package:restaurants/data/model/restaurants.dart' as resto;
import 'package:restaurants/data/model/restaurants_detail.dart';
import 'package:restaurants/provider/database_provider.dart';
import 'package:restaurants/provider/restaurants_detail_provider.dart';
import 'package:restaurants/widgets/review_dialog.dart';

class RestaurantDetail extends StatelessWidget {
  final Restaurant restaurant;
  final RestaurantDetailProvider providers;
  final resto.Restaurant restaurants;

  const RestaurantDetail({
    Key? key,
    required this.providers,
    required this.restaurant,
    required this.restaurants,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> foodsSliders = restaurant.menus.foods
        .map((item) => Container(
              margin: const EdgeInsets.all(1.0),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.asset("assets/food_logo.png",
                          fit: BoxFit.contain, width: 400.0),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Text(
                            item.name,
                            style: Styles.menuName,
                          ),
                        ),
                      ),
                      TextButton(
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                            ),
                          ),
                          onPressed: () {}),
                    ],
                  )),
            ))
        .toList();

    final List<Widget> drinksSliders = restaurant.menus.drinks
        .map((item) => Container(
              margin: const EdgeInsets.all(1.0),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.asset("assets/drink_logo.png",
                          fit: BoxFit.contain, width: 400.0),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Text(
                            item.name,
                            style: Styles.menuName,
                          ),
                        ),
                      ),
                      TextButton(
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                            ),
                          ),
                          onPressed: () {}),
                    ],
                  )),
            ))
        .toList();

    return Consumer<DatabaseProvider>(builder: (context, provider, child) {
      return FutureBuilder<bool>(
        future: provider.isFavorited(restaurant.id),
        builder: (context, snapshot) {
          var isFavorited = snapshot.data ?? false;
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(restaurant.name,
                          style: Styles.restaurantNameOnDetail),
                      isFavorited
                          ? IconButton(
                              icon: const Icon(
                                Icons.favorite,
                                color: Colors.brown,
                              ),
                              onPressed: () {
                                provider.removeFavorites(restaurant.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Favorite has been removed')));
                              })
                          : IconButton(
                              icon: const Icon(
                                Icons.favorite_border,
                                color: Colors.brown,
                              ),
                              onPressed: () {
                                provider.addFavorite(restaurants);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Favorite has been added')));
                              }),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(top: 2)),
                  Row(children: [
                    const Icon(
                      CupertinoIcons.location_solid,
                      size: 13,
                      color: Colors.brown,
                    ),
                    const Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
                    Text(
                      restaurant.city,
                      style: Styles.restaurantLocationOnDetail,
                    ),
                  ]),
                  const Padding(padding: EdgeInsets.only(top: 2)),
                  Row(
                    children: [
                      const Icon(
                        CupertinoIcons.star_fill,
                        size: 13,
                        color: Colors.red,
                      ),
                      const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2)),
                      Text(
                        restaurant.rating.toString(),
                        style: Styles.restaurantRatingOnDetail,
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Divider(color: Colors.grey),
                  const Text(
                    "Description",
                    style: Styles.detailSegment,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 8)),
                  Text(
                    restaurant.description,
                    textAlign: TextAlign.justify,
                    style: Styles.restaurantDescription,
                  ),
                  const SizedBox(height: 5),
                  const Divider(color: Colors.grey),
                  const Text(
                    "Menu",
                    style: Styles.detailSegment,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 5)),
                  const Text(
                    "Foods",
                    style: Styles.productsSegment,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 5)),
                  CarouselSlider(
                    options: CarouselOptions(
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      initialPage: 2,
                      autoPlay: true,
                    ),
                    items: foodsSliders,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 5)),
                  const Text(
                    "Drinks",
                    style: Styles.productsSegment,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 5)),
                  CarouselSlider(
                    options: CarouselOptions(
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      initialPage: 2,
                      autoPlay: true,
                    ),
                    items: drinksSliders,
                  ),
                  const Divider(color: Colors.grey),
                  const Text(
                    "Review",
                    style: Styles.detailSegment,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 5)),
                  SizedBox(
                    height: 130,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: restaurant.customerReviews.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(2),
                          child: SizedBox(
                            width: 200,
                            child: Card(
                              elevation: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        restaurant.customerReviews[index].name,
                                        style: Styles.reviewName,
                                      ),
                                      Text(
                                          restaurant
                                              .customerReviews[index].date,
                                          style: Styles.reviewDate),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '"' +
                                            restaurant
                                                .customerReviews[index].review +
                                            '"',
                                        style: Styles.reviewDesc,
                                        textAlign: TextAlign.center,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 5)),
                  TextButton(
                    child: const Text(
                      "Add a review...",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => ReviewDialog(
                            provider: providers, id: restaurant.id),
                      );
                    },
                  ),
                ],
              )
            ]),
          );
        },
      );
    });
  }
}
