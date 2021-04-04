import 'package:flutter/material.dart';

class DefaultPage extends StatelessWidget {
  final String name;
  const DefaultPage({Key key, this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text('Route for $name is not defined'),
        ),
      ),
    );
  }
}
