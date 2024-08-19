import 'package:flutter/material.dart';
import 'package:spotify/core/config/app_colors.dart';

class AppTheme {

  ///light
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    brightness: Brightness.light,
    fontFamily: 'Satoshi',
    /// i used hover color for shimmer effect
    hoverColor: AppColors.grey,
    focusColor: Colors.transparent,
    highlightColor: Colors.transparent,
    splashFactory: NoSplash.splashFactory,
    scaffoldBackgroundColor: AppColors.lightBackGround,
    inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.transparent,
        contentPadding: const EdgeInsets.all(30),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.white)
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.grey.shade700,width: 0.4),
        ),
       focusedErrorBorder: OutlineInputBorder(
         borderRadius: BorderRadius.circular(30),
         borderSide: BorderSide(color: Colors.green.shade700,width: 2),
       ),
       errorStyle: const TextStyle(color: Colors.green),
       suffixIconColor: Colors.grey.shade800,
       errorBorder: OutlineInputBorder(
         borderRadius: BorderRadius.circular(30),
         borderSide: const BorderSide(color: Colors.green,width: 1),
       ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        textStyle: const TextStyle(fontSize: 18 ,fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)
        )
      )
    ),
  );


  ///dark
  static final ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primary,
    brightness: Brightness.dark,
    fontFamily: 'Satoshi',
    splashFactory: NoSplash.splashFactory,
    /// i used hover color for shimmer effect
    hoverColor: AppColors.cardColor,
    splashColor: Colors.transparent,
    focusColor: Colors.transparent,
    scaffoldBackgroundColor: AppColors.darkBackGround,
    appBarTheme: AppBarTheme(

    ),
    inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.transparent,
        contentPadding: const EdgeInsets.all(30),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.white)
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.green.shade700,width: 2),
        ),
        errorStyle: const TextStyle(color: Colors.green),
        suffixIconColor: Colors.grey.shade800,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.green,width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.grey.shade700,width: 0.4),
      )
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        textStyle: const TextStyle(fontSize: 18 ,fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)
        )
      )
    ),

  );
}