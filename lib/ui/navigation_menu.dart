import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurants/ui/restaurant_favorite_page.dart';
import 'package:restaurants/ui/restaurants_list_page.dart';
import 'package:restaurants/ui/search_tab.dart';
import 'package:restaurants/ui/settings_page.dart';
import 'package:restaurants/utils/background_service.dart';
import 'package:restaurants/widgets/platform_widget.dart';

class NavigationMenu extends StatefulWidget {
  static const routeName = '/navigation_menu';

  const NavigationMenu({Key? key}) : super(key: key);

  @override
  _NavigationMenuState createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  final BackgroundService _service = BackgroundService();

  int _bottomNavIndex = 1;
  static const String _home = 'Home';
  static const String _search = 'Search';
  static const String _favorite = 'Favorite';
  static const String _settings = 'Settings';

  final List<Widget> _listWidget = [
    const SearchTab(),
    const RestaurantListTab(),
    const RestaurantFavoriteTab(),
    const Settings(),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.search : Icons.search,
          color: Colors.brown),
      label: _search,
    ),
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.home : Icons.home,
          color: Colors.brown),
      label: _home,
    ),
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.heart : Icons.favorite,
          color: Colors.brown),
      label: _favorite,
    ),
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.settings : Icons.settings,
          color: Colors.brown),
      label: _settings,
    ),
  ];

  Future<dynamic> exitDialog() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Quit'),
        content: const Text('Are you sure?'),
        actions: [
          TextButton(
            child: const Text("NO"),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          TextButton(
            child: const Text("YES"),
            onPressed: () {
              SystemNavigator.pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    _controller = TabController(
      length: 2,
      vsync: this,
      initialIndex: 1,
    );
    super.initState();
    port.listen((_) async => await _service.someTask());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(items: _bottomNavBarItems),
      tabBuilder: (context, index) {
        return _listWidget[index];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        exitDialog();
        return Future.value(false);
      },
      child: PlatformWidget(
        androidBuilder: _buildAndroid,
        iosBuilder: _buildIos,
      ),
    );
  }
}
