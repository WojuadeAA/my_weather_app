import 'package:flutter/material.dart';
import 'package:my_weather_app/src/core/constants/constants.dart';

ThemeData appTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF5700)),
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
        fontSize: 24,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w600,
        color: Colors.black,
        fontFamily: kFuturaCondensed),
    titleMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: Colors.black,
      fontFamily: kCircularStd,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.black,
      fontFamily: kCircularStd,
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
  useMaterial3: true,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      minimumSize: WidgetStateProperty.all(const Size(double.maxFinite, 50)),
      foregroundColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          // Default button color
          return Colors.white;
        },
      ),
      backgroundColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          // Default button color
          return const Color(0xFFFF5700);
        },
      ),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      elevation: WidgetStateProperty.all(2),
      padding: WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(vertical: 14, horizontal: 24)),
      textStyle: WidgetStateProperty.all(
        const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          fontFamily: kCircularStd,
        ),
      ),
    ),
  ),
);
