import 'package:flutter/material.dart';

import 'widgets.dart';

class CategoryCard extends StatelessWidget {
  final Key key;
  final int totalTaskCount;
  final String category;
  final int completedTasks;
  final Color progressColor;
  CategoryCard({
    this.key,
    @required this.totalTaskCount,
    @required this.category,
    @required this.completedTasks,
    @required this.progressColor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$totalTaskCount TASKS',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 10),
              Text(
                this.category,
                style: Theme.of(context).textTheme.headline5,
              ),
              Expanded(
                child: SizedBox(),
              ),
              ControlledProgressIndicator(
                  total: this.totalTaskCount,
                  completed: this.completedTasks,
                  color: this.progressColor),
            ],
          ),
        ),
      ),
    );
  }
}
