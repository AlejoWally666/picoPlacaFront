import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

getAppTheme() {
  return ThemeData(
    fontFamily: 'Roboto',
    primaryColor: Colors.green,
    scaffoldBackgroundColor: Colors.white,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.green,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.green,
      elevation: 0.0,
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light, // For Android (dark icons)
        statusBarBrightness: Brightness.dark, // For iOS (dark icons)
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: Colors.green,
        elevation: 0.0,
        shadowColor: Colors.black12,
      ),
    ),
  );
}