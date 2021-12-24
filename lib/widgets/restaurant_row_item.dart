import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurants/common/styles.dart';
import 'package:restaurants/data/api/api_service.dart';
import 'package:restaurants/data/model/restaurants.dart';
import 'package:restaurants/ui/restaurants_detail_page.dart';

class RestaurantRowItem extends StatelessWidget {
  const RestaurantRowItem({
    required this.restaurant,
    required this.lastItem,
    Key? key,
  }) : super(key: key);

  final Restaurant restaurant;
  final bool lastItem;

  @override
  Widget build(BuildContext context) {
    final row = SafeArea(
      top: false,
      bottom: false,
      minimum: const EdgeInsets.only(
        left: 16,
        top: 8,
        bottom: 8,
        right: 8,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, RestaurantDetailPage.routeName,
                arguments: restaurant);
          },
          child: Row(
            children: <Widget>[
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Hero(
                    tag: restaurant.pictureId,
                    child: Image.network(
                      ApiService.imgUrl + restaurant.pictureId,
                      fit: BoxFit.fill,
                      width: 76,
                      height: 76,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        restaurant.name,
                        style: Styles.restaurantNameOnList,
                      ),
                      const Padding(padding: EdgeInsets.only(top: 2)),
                      Row(children: [
                        const Icon(
                          CupertinoIcons.location_solid,
                          size: 16,
                          color: Colors.brown,
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2)),
                        Text(
                          restaurant.city,
                          style: Styles.restaurantLocationOnList,
                        ),
                      ]),
                      const Padding(padding: EdgeInsets.only(top: 2)),
                      Row(
                        children: [
                          const Icon(
                            CupertinoIcons.star_fill,
                            size: 16,
                            color: Colors.red,
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2)),
                          Text(
                            restaurant.rating.toString(),
                            style: Styles.restaurantRatingOnList,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    if (lastItem) {
      return row;
    }

    return Column(
      children: <Widget>[
        row,
        const Padding(
          padding: EdgeInsets.only(
            right: 16,
          ),
        ),
      ],
    );
  }
}
