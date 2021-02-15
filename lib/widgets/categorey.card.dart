import 'package:flutter/material.dart';

class CategoreyCard extends StatelessWidget {
  final int totalTaskCount;
  final String categorey;
  final int completedTasks;
  final Color progressColor;
  CategoreyCard(
      {@required this.totalTaskCount,
      @required this.categorey,
      @required this.completedTasks,
      @required this.progressColor,
      });
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
                style: Theme.of(context).primaryTextTheme.subtitle2,
              ),
              SizedBox(height: 10),
              Text(
                this.categorey,
                style: Theme.of(context).textTheme.headline5,
              ),
              Expanded(
                child: SizedBox(),
              ),
              LinearProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(this.progressColor),
                value: this.completedTasks / this.totalTaskCount,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
