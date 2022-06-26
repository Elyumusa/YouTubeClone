import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

class AppTheme {
  const AppTheme._();
  static Color lightBackgroundColor = const Color(0xfff2f2f2);
  static Color lightPrimaryColor = const Color(0xfff2f2f2);
  static Color darkBackgroundColor = Colors.black;
  static final lightTheme = ThemeData(
    appBarTheme: AppBarTheme(color: Colors.white),
    brightness: Brightness.light,
    primaryColor: Colors.orangeAccent[100],
    iconTheme: IconThemeData(color: Colors.black),
    textTheme: TextTheme(caption: TextStyle(color: Colors.black)),
    backgroundColor: Colors.orangeAccent[100],
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    bottomNavigationBarTheme:
        const BottomNavigationBarThemeData(selectedItemColor: Colors.white),
    primaryColor: darkBackgroundColor,
    backgroundColor: darkBackgroundColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
  static Brightness get currentSystemBrightness =>
      SchedulerBinding.instance!.window.platformBrightness;
  static setStatusBarAndNavigationBarColors(ThemeMode themeMode) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
          themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
      systemNavigationBarIconBrightness:
          themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: themeMode == ThemeMode.light
          ? lightBackgroundColor
          : darkBackgroundColor,
      systemNavigationBarDividerColor: Colors.transparent,
    ));
  }
}
