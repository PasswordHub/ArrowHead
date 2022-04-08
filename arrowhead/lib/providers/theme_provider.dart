import 'package:flutter/material.dart';

enum ThemeType {
  light,
  dark,
}

const Map<int, Color> color = {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};

class ThemeProvider with ChangeNotifier {
  ThemeData? _lightThemeData;
  ThemeData? _darkThemeData;

  ThemeType _currTheme = ThemeType.light;

  ThemeProvider() {
    _lightThemeData = ThemeData(
      primarySwatch: Colors.blueGrey,
      appBarTheme: const AppBarTheme(color: Colors.blueGrey),
      iconTheme: const IconThemeData(color: Colors.black),
      canvasColor: const MaterialColor(0xFFFFFFFF, color),
      colorScheme: ColorScheme(
          primary: Colors.blue,
          onPrimary: Colors.lightBlue,
          surface: Colors.cyan,
          onSurface: Colors.blueAccent,
          secondary: Colors.grey.shade400,
          brightness: Brightness.dark,
          onError: Colors.red,
          error: Colors.red,
          onSecondary: Colors.amber,
          background: Colors.deepPurple,
          onBackground: Colors.lightBlue),
      fontFamily: 'Rajdhani',
      textTheme: ThemeData.light().textTheme.copyWith(
          headline1: const TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          headline2: const TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          headline3: const TextStyle(
            fontSize: 36,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          headline4: const TextStyle(
            fontSize: 48,
          ),
          headline5: const TextStyle(
            fontSize: 150,
          ),
          bodyText1:
              const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
          bodyText2: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.normal, letterSpacing: 0.5)),
    );
    _darkThemeData = ThemeData(
      primarySwatch: Colors.blueGrey,
      appBarTheme: const AppBarTheme(color: Colors.blueGrey),
      iconTheme: const IconThemeData(color: Colors.black),
      canvasColor: const MaterialColor(0xFFFFFFFF, color),
      colorScheme: ColorScheme(
          primary: Colors.blue,
          onPrimary: Colors.lightBlue,
          surface: Colors.cyan,
          onSurface: Colors.blueAccent,
          secondary: Colors.grey.shade400,
          brightness: Brightness.dark,
          onError: Colors.red,
          error: Colors.red,
          onSecondary: Colors.amber,
          background: Colors.deepPurple,
          onBackground: Colors.lightBlue),
      fontFamily: 'Rajdhani',
      textTheme: ThemeData.dark().textTheme.copyWith(
          headline1: const TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          headline2: const TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          headline3: const TextStyle(
            fontSize: 36,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          headline4: const TextStyle(
            fontSize: 48,
          ),
          headline5: const TextStyle(
            fontSize: 150,
          ),
          bodyText1:
              const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
          bodyText2: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.normal, letterSpacing: 0.5)),
    );
    notifyListeners();
  }

  ThemeData get themeData {
    if (_currTheme == ThemeType.dark) {
      return _darkThemeData ?? ThemeData();
    }
    return _lightThemeData ?? ThemeData();
  }

  ThemeType get currTheme {
    return _currTheme;
  }

  setTheme(ThemeType theme) {
    _currTheme = theme;
    notifyListeners();
  }
}
