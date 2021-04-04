import 'package:darkhold/pages/add.note.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'pages/pages.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'home-page':
        return MaterialPageRoute(
          builder: (context) => HomePage(),
        );
        break;
      case '/add-task':
        return PageTransition(
          type: PageTransitionType.bottomToTop,
          child: AddTaskPage(),
        );
        break;
      case '/add-notes':
        return PageTransition(
          type: PageTransitionType.bottomToTop,
          child: AddNotesPage(),
        );
        break;
      default:
        return MaterialPageRoute(
          builder: (context) => DefaultPage(
            name: settings.name,
          ),
        );
    }
  }
}
