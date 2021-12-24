import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurants/data/database/database_helper.dart';
import 'package:restaurants/preferences/preference_helper.dart';
import 'package:restaurants/provider/database_provider.dart';
import 'package:restaurants/provider/preference_provider.dart';
import 'package:restaurants/provider/restaurants_list_provider.dart';
import 'package:restaurants/provider/scheduling_provider.dart';
import 'package:restaurants/ui/navigation_menu.dart';
import 'package:restaurants/ui/restaurants_detail_page.dart';
import 'package:restaurants/ui/settings_page.dart';
import 'package:restaurants/ui/splashscreen.dart';
import 'package:restaurants/utils/background_service.dart';
import 'package:restaurants/utils/notification_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/api/api_service.dart';
import 'data/model/restaurants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final BackgroundService _service = BackgroundService();
  final NotificationHelper _notificationHelper = NotificationHelper();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RestaurantProvider(apiService: ApiService(), id: ''),
        ),
        ChangeNotifierProvider(create: (_) => SchedulingProvider()),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferenceHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Restaurant Application',
        theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity),
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (context) => const SplashScreen(),
          NavigationMenu.routeName: (context) => const NavigationMenu(),
          RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments as Restaurant),
          Settings.routeName: (context) => const Settings(),
        },
      ),
    );
  }
}
