import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, ThemeData>((ref) {
  return ThemeNotifier();
});

class Pallete {
  static const blueColor = Colors.blue;
  static const whiteColor = Colors.white;
  static const blackColor = Colors.black;
  //themes
  static var darkMode = ThemeData.dark();
  static var lightMode = ThemeData.light();
}

class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeMode _mode;
  ThemeNotifier({ThemeMode mode = ThemeMode.dark})
      : _mode = mode,
        super(Pallete.darkMode) {
    getTheme();
  }

  ThemeMode get mode => _mode;
  void getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString('theme');

    if (theme == 'light') {
      _mode = ThemeMode.light;
      state = Pallete.lightMode;
    } else {
      _mode = ThemeMode.dark;
      state = Pallete.darkMode;
    }
  }

  void toogleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_mode == ThemeMode.dark) {
      state = Pallete.lightMode;
      prefs.setString('theme', 'light');
    } else {
      _mode = ThemeMode.dark;
      state = Pallete.darkMode;
      prefs.setString('theme', 'dark');
    }
  }
}
