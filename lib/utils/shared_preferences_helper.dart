import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  // NOTE: Shared Preference String
  static void writeListStringData(String key, List<String> value) async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, value).then((bool success) {
      debugPrint('Sucess write list string data');
    }, onError: (e) {
      debugPrint('e in writeListStringData: $e');
    });
  }

  static Future<List<String>?> readListStringData(String key) async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    final List<String>? data = prefs.getStringList(key);
    return data;
  }

  // NOTE: Shared Preference Boolean
  static void writeBooleanData(String key, bool value) async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value).then((bool success) {
      debugPrint('Sucess write bool data');
    }, onError: (e) {
      debugPrint('e in writeBooleanData: $e');
    });
  }

  static Future<bool?> readBooleanData(String key) async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    final bool? data = prefs.getBool(key);
    return data;
  }

  static void removeData(String key) async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key).then((bool success) {
      debugPrint('Sucess write data');
    }, onError: (e) {
      debugPrint('e in removeData: $e');
    });
  }
}
