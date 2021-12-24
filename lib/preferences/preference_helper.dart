import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferenceHelper({required this.sharedPreferences});

  static const dailyReminder = 'DAILY_REMINDER';

  Future<bool> get isDailyReminderActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(dailyReminder) ?? false;
  }

  void setDailyReminder(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(dailyReminder, value);
  }
}
