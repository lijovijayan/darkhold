import 'package:flutter/material.dart';

final lightTheme = ThemeData(
        fontFamily: "circular_std",
        primaryColor: Color(0xFFEA06FE),
        appBarTheme: AppBarTheme(
          elevation: 0,
          color: Colors.transparent,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        canvasColor: Colors.black,
      );
final darkTheme = ThemeData.dark();