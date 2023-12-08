import 'package:shared_preferences/shared_preferences.dart';

class Cache {
  static const String studentId = "studentId";
  static const String studentIdTimeStamp = "studentIdTimeStamp";

  static const String name = "name";
  static const String nameTimeStamp = "nameTimeStamp";

  static const String language = "language";
  static const String languageTimeStamp = "languageTimeStamp";

  static const String startDay = "startDay"; //int
  static const String startDayTimeStamp = "startDayTimeStamp";

  static const String darkMode = "darkMode"; //int
  static const String darkModeTimeStamp = "darkModeTimeStamp";

  static const int cacheDurationInMinutes = 60 * 60000;

  static Future<String?> getStringFromCache(String key, String keyTimeStamp) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? res = prefs.getString(key);
    final int? timestamp = prefs.getInt(keyTimeStamp);

    if (res != null && timestamp != null) {
      final int currentTimestamp = DateTime.now().millisecondsSinceEpoch;
      final int expirationTimestamp = timestamp + (cacheDurationInMinutes);

      if (currentTimestamp < expirationTimestamp) {
        return res;
      }
    }
    return null;
  }

  static Future<void> setStringInCache(String key, String keyTimeStamp, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int currentTimestamp = DateTime.now().millisecondsSinceEpoch;

    prefs.setString(key, value);
    prefs.setInt(keyTimeStamp, currentTimestamp);
  }

  static Future<int?> getIntFromCache(String key, String keyTimeStamp) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? res = prefs.getInt(key);
    final int? timestamp = prefs.getInt(keyTimeStamp);

    if (res != null && timestamp != null) {
      final int currentTimestamp = DateTime.now().millisecondsSinceEpoch;
      final int expirationTimestamp = timestamp + (cacheDurationInMinutes);

      if (currentTimestamp < expirationTimestamp) {
        return res;
      }
    }
    return null;
  }

  static Future<void> setIntInCache(String key, String keyTimeStamp, int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int currentTimestamp = DateTime.now().millisecondsSinceEpoch;

    prefs.setInt(key, value);
    prefs.setInt(keyTimeStamp, currentTimestamp);
  }

  static Future<bool?> getBoolFromCache(String key, String keyTimeStamp) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? res = prefs.getBool(key);
    final int? timestamp = prefs.getInt(keyTimeStamp);

    if (res != null && timestamp != null) {
      final int currentTimestamp = DateTime.now().millisecondsSinceEpoch;
      final int expirationTimestamp = timestamp + (cacheDurationInMinutes);

      if (currentTimestamp < expirationTimestamp) {
        return res;
      }
    }
    return null;
  }

  static Future<void> setBoolInCache(String key, String keyTimeStamp, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int currentTimestamp = DateTime.now().millisecondsSinceEpoch;

    prefs.setBool(key, value);
    prefs.setInt(keyTimeStamp, currentTimestamp);
  }

}