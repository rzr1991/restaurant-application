import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurants/common/styles.dart';
import 'package:restaurants/data/api/api_service.dart';
import 'package:restaurants/data/model/restaurants.dart';
import 'package:restaurants/provider/restaurants_detail_provider.dart';
import 'package:restaurants/utils/enum.dart';
import 'package:restaurants/widgets/restaurant_detail.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final Restaurant restaurant;

  const RestaurantDetailPage({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RestaurantDetailProvider provider;

    return ChangeNotifierProvider<RestaurantDetailProvider>(
      create: (_) =>
          RestaurantDetailProvider(apiService: ApiService(), id: restaurant.id),
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(restaurant.name, style: Styles.restaurantHomeText),
          backgroundColor: Styles.backgroundColor,
        ),
        child: Material(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Hero(
                  tag: restaurant.pictureId,
                  child: Image.network(
                    ApiService.imgUrl + restaurant.pictureId,
                  ),
                ),
                Consumer<RestaurantDetailProvider>(
                  builder: (context, state, _) {
                    provider = state;
                    if (state.state == ResultState.loading) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 4,
                            ),
                            const CupertinoActivityIndicator(),
                          ],
                        ),
                      );
                    } else if (state.state == ResultState.hasData) {
                      final restaurants = state.result;
                      return RestaurantDetail(
                        restaurant: restaurants,
                        providers: provider,
                        restaurants: restaurant,
                      );
                    } else if (state.state == ResultState.noData) {
                      return Center(child: Text(state.message));
                    } else if (state.state == ResultState.error) {
                      return Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/connection_lost.png", width: 100),
                          const SizedBox(height: 10),
                          const Text(
                            "Connection lost",
                            style: Styles.restaurantDescription,
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            child: const Text("Refresh"),
                            onPressed: () {
                              provider.restaurantDetail(restaurant.id);
                            },
                          ),
                        ],
                      ));
                    } else {
                      return const Center(child: Text('Error'));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
