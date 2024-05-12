import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  static late SharedPreferences _prefs;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveData(String key, dynamic value) async {
    await _prefs.setString(key, json.encode(value));
  }

  static Future<dynamic> getData(String key) async {
    final data = _prefs.getString(key);
    return data != null ? json.decode(data) : null;
  }

  static Future<void> removeData(String key) async {
    await _prefs.remove(key);
  }

  static Future<void> clearData() async {
    await _prefs.clear();
  }

  static Future<void> saveMapData(Map<String, dynamic> data, String key) async {
    await _prefs.setString(key, json.encode(data));
  }

  static Future<Map<String, dynamic>?> getMapData(String key) async {
    final data = _prefs.getString(key);
    return data != null ? json.decode(data) : null;
  }
}
