import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurants/common/styles.dart';
import 'package:restaurants/provider/database_provider.dart';
import 'package:restaurants/utils/enum.dart';
import 'package:restaurants/widgets/restaurant_row_item.dart';

class RestaurantFavoriteTab extends StatefulWidget {
  const RestaurantFavoriteTab({Key? key}) : super(key: key);

  @override
  State<RestaurantFavoriteTab> createState() => _RestaurantFavoriteTabState();
}

class _RestaurantFavoriteTabState extends State<RestaurantFavoriteTab> {
  Widget _buildList(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.loading) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        } else if (provider.state == ResultState.hasData) {
          return CustomScrollView(
            semanticChildCount: provider.favorites.length,
            slivers: <Widget>[
              const CupertinoSliverNavigationBar(
                largeTitle: Text('Favorite', style: Styles.restaurantHomeText),
                backgroundColor: Styles.backgroundColor,
              ),
              SliverSafeArea(
                top: false,
                minimum: const EdgeInsets.only(top: 8),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      if (index < provider.favorites.length) {
                        return RestaurantRowItem(
                          restaurant: provider.favorites[index],
                          lastItem: index == provider.favorites.length - 1,
                        );
                      }
                      return null;
                    },
                  ),
                ),
              )
            ],
          );
        } else if (provider.state == ResultState.noData) {
          return Center(
            child: Text(provider.message),
          );
        } else if (provider.state == ResultState.error) {
          return const Center(
            child: Text("Error 404"),
          );
        } else {
          return const Center(
            child: Text("Error 404"),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }
}
