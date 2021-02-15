import 'package:darkhold/sqlite.config.dart';
import 'package:darkhold/theme.dart';
import 'package:flutter/material.dart';
import 'pages/pages.dart';

void main() {
  SQLiteConfig.syncDB();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Darkhold',
      themeMode: ThemeMode.light,
      theme: ThemeData(
          fontFamily: "circular_std",
          primaryColor: Color(0xFFEA06FE),
          accentColor: MaterialColor(0xFFFFFFFF, {}),
          backgroundColor: Color(0xFF46598C),
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primaryVariant: Color(0xFF183588),
              ),
          appBarTheme: AppBarTheme(
            elevation: 0,
            color: Colors.transparent,
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          primaryIconTheme: IconThemeData(
            color: Colors.white,
          ),
          accentIconTheme: IconThemeData(
            color: Colors.white,
          ),
          canvasColor: Color(0xFF3450A1),
          textTheme: TextTheme(
            bodyText1: TextStyle(),
            bodyText2: TextStyle(),
            headline5: TextStyle(),
          ).apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
          ),
          primaryTextTheme: TextTheme(
            subtitle1: TextStyle(),
          ).apply(
            bodyColor: Color(0xFF4C5F98),
            displayColor: Color(0xFF4C5F98),
          ),
          accentTextTheme: TextTheme(
            subtitle1: TextStyle(),
          ).apply(
            bodyColor: Color(0xFF92AEFA),
            displayColor: Color(0xFF92AEFA),
          ),
          cardTheme: CardTheme(
            color: Color(0xFF041955),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Color(0xFFeb06ff),
              foregroundColor: Colors.white)),
      darkTheme: darkTheme,
      home: HomePage(),
    );
  }
}
