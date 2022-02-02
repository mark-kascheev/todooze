import 'package:flutter/material.dart';

class TodooozeTheme extends ChangeNotifier {
  bool _isLightTheme = true;

  bool get isLightTheme => _isLightTheme;

  void switchMode() {
    _isLightTheme = !_isLightTheme;
    notifyListeners();
  }

  static lightTheme() => ThemeData(
      unselectedWidgetColor: const Color.fromRGBO(132, 165, 234, 1),
      scaffoldBackgroundColor: const Color.fromRGBO(245, 245, 248, 1),
      colorScheme: const ColorScheme.light(
          background: Color.fromRGBO(245, 245, 248, 1),
          primary: Color.fromRGBO(253, 252, 252, 1),
          onPrimary: Color.fromRGBO(23, 23, 26, 1),
          secondary: Color.fromRGBO(223, 224, 226, 1),
          primaryVariant: Color.fromRGBO(49, 100, 211, 1),
          secondaryVariant: Color.fromRGBO(251, 115, 71, 1),
          surface: Color.fromRGBO(100, 244, 247, 1),
          onSurface: Color.fromRGBO(194, 57, 88, 1),
          onSecondary: Color.fromRGBO(132, 165, 234, 1),
          onBackground: Color.fromRGBO(191, 194, 197, 1)));

  static darkTheme() => ThemeData(
      unselectedWidgetColor: const Color.fromRGBO(132, 165, 234, 1),
      scaffoldBackgroundColor: const Color.fromRGBO(23, 23, 26, 1),
      colorScheme: const ColorScheme.dark(
          background: Color.fromRGBO(23, 23, 26, 1),
          primary: Color.fromRGBO(34, 34, 40, 1),
          onPrimary: Color.fromRGBO(253, 252, 252, 1),
          secondary: Color.fromRGBO(223, 224, 226, 1),
          primaryVariant: Color.fromRGBO(49, 100, 211, 1),
          secondaryVariant: Color.fromRGBO(251, 115, 71, 1),
          onSurface: Color.fromRGBO(194, 57, 88, 1),
          surface: Color.fromRGBO(100, 244, 247, 1),
          onSecondary: Color.fromRGBO(132, 165, 234, 1),
          onBackground: Color.fromRGBO(91, 92, 98, 1)));
}
