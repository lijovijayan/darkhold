import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final int id;
  final String name;
  final bool completed;
  TaskCard({
    @required this.id,
    @required this.name,
    @required this.completed,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                transitionBuilder:
                    (Widget widget, Animation<double> animation) {
                  return ScaleTransition(
                    scale: animation,
                    child: widget,
                  );
                },
                child: completed
                    ? Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                      )
                    : Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                        ),
                      ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  this.name,
                  style: Theme.of(context).primaryTextTheme.subtitle2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
