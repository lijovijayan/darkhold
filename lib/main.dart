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
    final theme = ThemeData(
      fontFamily: "circular_std",
      primaryColor: Color(0xFF246bfd),
      accentColor: MaterialColor(0xFF7398ff, {}),
      primaryColorDark: Color(0xFF0041c9),
      hintColor: Color(0xFF575b6b),
      colorScheme: Theme.of(context).colorScheme.copyWith(
            primaryVariant: Color(0xFF246bfd),
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
      unselectedWidgetColor: Color(0xFF246bfd),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle().copyWith(
          color: Color(0xFF58656c),
        ),
        hintStyle: TextStyle().copyWith(
          color: Color(0xFF58656c),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      canvasColor: Color(0xFF181a20),
      // text color - white
      textTheme: TextTheme(
        subtitle1: TextStyle(
          fontSize: 20,
        ), // input text
        bodyText1: TextStyle(),
        bodyText2: TextStyle(),
        headline3: TextStyle(),
        headline5: TextStyle(fontSize: 22, fontWeight: FontWeight.normal),
        headline6: TextStyle(
          fontSize: 18,
        ),
      ).apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),
      // text color - Color(0xFF575b6b)
      primaryTextTheme: TextTheme(
        subtitle1: TextStyle(
          fontSize: 20,
        ), // input text
        bodyText1: TextStyle(),
        bodyText2: TextStyle(),
        headline3: TextStyle(),
        headline5: TextStyle(fontSize: 22, fontWeight: FontWeight.normal),
        headline6: TextStyle(
          fontSize: 18,
        ),
      ).apply(
        bodyColor: Color(0xFF575b6b),
        displayColor: Color(0xFF575b6b),
      ),
      // text color - Color(0xFFc25fff)
      accentTextTheme: TextTheme(
        subtitle1: TextStyle(
          fontSize: 20,
        ), // input text
        bodyText1: TextStyle(),
        bodyText2: TextStyle(),
        headline3: TextStyle(),
        headline5: TextStyle(fontSize: 22, fontWeight: FontWeight.normal),
        headline6: TextStyle(
          fontSize: 18,
        ),
      ).apply(
        bodyColor: Color(0xFFc25fff),
        displayColor: Color(0xFFc25fff),
      ),
      cardTheme: CardTheme(
        color: Color(0xFF262a34),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF246bfd), foregroundColor: Colors.white),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Darkhold',
      themeMode: ThemeMode.light,
      theme: theme.copyWith(),
      darkTheme: darkTheme,
      home: HomePage(),
    );
  }
}
