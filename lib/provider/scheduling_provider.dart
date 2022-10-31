import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/date_time_helper.dart';
import 'package:restaurant_app/utils/shared_preferences_helper.dart';

class SchedulingProvider with ChangeNotifier {
  final String key = 'scheduling';
  bool? _isScheduled = false;

  bool? get isScheduled => _isScheduled;

  void getDataScheduling() async {
    _isScheduled = await SharedPreferencesHelper.readBooleanData(key) ?? false;
    notifyListeners();
  }

  Future<bool> scheduledRestaurants(bool value) async {
    SharedPreferencesHelper.writeBooleanData(key, value);
    _isScheduled = await SharedPreferencesHelper.readBooleanData(key) ?? false;

    notifyListeners();

    if (_isScheduled!) {
      debugPrint('Scheduling Restaurants Activated');
      debugPrint('DateTimeHelper.format(): ${DateTimeHelper.format()}');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      debugPrint('Scheduling Restaurants Canceled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
