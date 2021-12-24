import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurants/common/styles.dart';
import 'package:restaurants/provider/preference_provider.dart';
import 'package:restaurants/provider/scheduling_provider.dart';

class Settings extends StatelessWidget {
  static const routeName = '/settings';

  const Settings({Key? key}) : super(key: key);

  Widget _buildList(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Settings", style: Styles.restaurantHomeText),
        backgroundColor: Styles.backgroundColor,
      ),
      child: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return ListView(
            children: [
              Material(
                child: ListTile(
                  title: const Text('Daily Reminder (11 A.M)'),
                  trailing: Consumer<SchedulingProvider>(
                    builder: (context, scheduled, _) {
                      return Switch.adaptive(
                        activeColor: Colors.brown,
                        value: provider.isDailyReminderActive,
                        onChanged: (value) async {
                          scheduled.scheduledRestaurant(value);
                          provider.enableDailyReminder(value);
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }
}
