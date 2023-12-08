import 'package:flutter/material.dart';

import '../locals/cache.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void initDarkMode() async {
    var value = await Cache.getBoolFromCache(Cache.darkMode, Cache.darkModeTimeStamp);
    if (value != null) {
      _isDarkMode = value;
    }
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    Cache.setBoolInCache(Cache.darkMode, Cache.darkModeTimeStamp, _isDarkMode);
    notifyListeners();
  }
}
