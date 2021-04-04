import 'package:flutter/material.dart';

import 'widgets.dart';

class TaskCard extends StatelessWidget {
  final Key key;
  final int id;
  final String name;
  final bool completed;
  final Function(bool) onTap;
  final Color color;
  TaskCard({
    this.key,
    @required this.id,
    @required this.name,
    @required this.completed,
    @required this.onTap,
    @required this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          this.onTap(!this.completed);
        },
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedCheckBox(
                checked: this.completed,
                color: this.color,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  this.name,
                  style: Theme.of(context).primaryTextTheme.subtitle1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
