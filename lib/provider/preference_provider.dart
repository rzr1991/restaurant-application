import 'package:flutter/material.dart';
import 'package:restaurants/preferences/preference_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferenceHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getDailyReminderPreferences();
  }

  bool _isDailyReminderActive = false;

  bool get isDailyReminderActive => _isDailyReminderActive;

  void _getDailyReminderPreferences() async {
    _isDailyReminderActive = await preferencesHelper.isDailyReminderActive;
    notifyListeners();
  }

  void enableDailyReminder(bool value) {
    preferencesHelper.setDailyReminder(value);
    _getDailyReminderPreferences();
  }
}
