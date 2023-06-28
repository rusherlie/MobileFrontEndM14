import 'package:flutter/material.dart';

class DarkThemeProvider with ChangeNotifier {
  final ThemeData light = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
  );

  final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.grey,
  );

  bool _darkTheme = false;
  bool get darkTheme => _darkTheme;

  set darkMode(bool value) {
    _darkTheme = value;
    notifyListeners();
  }
}
