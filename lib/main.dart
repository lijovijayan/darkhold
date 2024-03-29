import 'package:darkhold/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/pages.dart';
import 'provider/provider.dart';
import 'config/sqlite.config.dart';
import 'theme.dart';

void main() {
  SQLiteConfig.syncDB();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<CoreProvider>(create: (_) => CoreProvider()),
      ChangeNotifierProvider<FilterProvider>(create: (_) => FilterProvider()),
      ProxyProvider2<CoreProvider, FilterProvider, CategoryProvider>(
        update: (BuildContext _, CoreProvider coreProvider,
                FilterProvider filter, CategoryProvider __) =>
            CategoryProvider(coreProvider.categories, filter.searchKey),
      ),
      ProxyProvider2<CoreProvider, FilterProvider, TaskProvider>(
          update: (BuildContext _, CoreProvider coreProvider,
                  FilterProvider filter, TaskProvider __) =>
              TaskProvider(coreProvider.tasks, filter.filter,
                  filter.filterValue, filter.searchKey))
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      fontFamily: "circular_std",
      primaryColor: ThemeColors.primary,
      accentColor: MaterialColor(0xFF7398ff, {}),
      hintColor: ThemeColors.text1,
      colorScheme: Theme.of(context).colorScheme.copyWith(
            primaryVariant: ThemeColors.primary,
          ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        color: ThemeColors.appbar,
      ),
      iconTheme: IconThemeData(
        color: ThemeColors.icon,
      ),
      primaryIconTheme: IconThemeData(
        color: ThemeColors.icon,
      ),
      accentIconTheme: IconThemeData(
        color: ThemeColors.icon,
      ),
      unselectedWidgetColor: ThemeColors.primary,
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle().copyWith(
          color: ThemeColors.inputHint,
        ),
        hintStyle: TextStyle().copyWith(
          color: ThemeColors.inputHint,
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: ThemeColors.input),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ThemeColors.input),
        ),
      ),
      canvasColor: ThemeColors.background,
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
        bodyColor: ThemeColors.text,
        displayColor: ThemeColors.text,
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
        bodyColor: ThemeColors.text1,
        displayColor: ThemeColors.text1,
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
        bodyColor: ThemeColors.text2,
        displayColor: ThemeColors.text2,
      ),
      cardTheme: CardTheme(
        color: ThemeColors.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: ThemeColors.primary,
          foregroundColor: ThemeColors.input),
    );
    return MaterialApp(
      title: 'Darkhold',
      debugShowCheckedModeBanner: false,
      theme: theme.copyWith(),
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      onGenerateRoute: Routes.generateRoute,
      initialRoute: 'home-page',
    );
  }
}

class ThemeColors {
  static Color primary = Color(0xFF246bfd);

  static Color background = Color(0xFF181a20);

  static Color card = Color(0xFF262a34);

  static Color icon = Colors.white;

  static Color appbar = Colors.transparent;

  static Color input = Colors.white;
  static Color inputHint = Color(0xFF58656c);

  static Color text = Colors.white;
  static Color text1 = Color(0xFF575b6b);
  static Color text2 = Color(0xFFc25fff);
}
