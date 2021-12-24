import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurants/common/styles.dart';
import 'package:restaurants/data/api/api_service.dart';
import 'package:restaurants/data/model/restaurants.dart';
import 'package:restaurants/provider/restaurants_list_provider.dart';
import 'package:restaurants/utils/enum.dart';
import 'package:restaurants/widgets/restaurant_row_item.dart';
import 'package:restaurants/widgets/search_bar.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({Key? key}) : super(key: key);

  @override
  _SearchTabState createState() {
    return _SearchTabState();
  }
}

class _SearchTabState extends State<SearchTab> {
  late RestaurantProvider _provider;
  late final FocusNode _focusNode;
  List<Restaurant> _restaurant = [];

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Styles.backgroundColor,
      ),
      child: SafeArea(
        child: Column(
          children: [_buildSearchBox(), _buildList()],
        ),
      ),
    );
  }

  Widget _buildList() {
    return ChangeNotifierProvider.value(
      value: _provider,
      child: Consumer<RestaurantProvider>(builder: (context, state, _) {
        _provider = state;
        if (state.state == ResultState.loading) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                ),
                const CupertinoActivityIndicator(),
              ],
            ),
          );
        } else if (state.state == ResultState.hasData) {
          _restaurant = state.result;
          return _buildItem(_restaurant);
        } else if (state.state == ResultState.noData) {
          return Center(child: Text(state.message));
        } else if (state.state == ResultState.error) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Center(
                  child: Text(
                "Type something...",
                style: Styles.productsSegment,
              )),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                child: const Text("Refresh", style: TextStyle(fontSize: 16)),
                onPressed: () {
                  _provider.listRestaurant();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.brown,
                ),
              ),
            ],
          ));
        } else {
          return const Center(
            child: Text("Error"),
          );
        }
      }),
    );
  }

  Widget _buildSearchBox() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SearchBar(
        focusNode: _focusNode,
        onChanged: searchData,
      ),
    );
  }

  Widget _buildItem(results) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) => RestaurantRowItem(
          restaurant: results[index],
          lastItem: index == results.length - 1,
        ),
        itemCount: results.length,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _provider = RestaurantProvider(apiService: ApiService(), id: '');
    init();
  }

  Future init() async {
    final restaurants = await _provider.listRestaurant();

    if (!mounted) {
      return;
    } else {
      setState(() => _restaurant = restaurants);
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void searchData(String _query) async {
    final result = await _provider.restaurantSearch(_query);

    if (!mounted) {
      return;
    } else {
      setState(() {
        if (result == String) _restaurant = result;
      });
    }
  }
}
