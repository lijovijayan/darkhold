import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final int id;
  final String name;
  final bool completed;
  final Function(bool) onTap;
  final Color color;
  final Duration _animationDuration = Duration(milliseconds: 200);
  TaskCard({
    @required this.id,
    @required this.name,
    @required this.completed,
    @required this.onTap,
    @required this.color,
  }) : assert(id != null &&
            name != null &&
            completed != null &&
            onTap != null &&
            color != null);
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
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: this.color,
                  shape: BoxShape.circle,
                ),
                child: AnimatedContainer(
                  duration: _animationDuration,
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: completed
                        ? Colors.transparent
                        : Theme.of(context).cardTheme.color,
                    shape: BoxShape.circle,
                  ),
                  child: AnimatedSwitcher(
                    duration: _animationDuration,
                    transitionBuilder:
                        (Widget widget, Animation<double> animation) {
                      return ScaleTransition(
                        scale: animation,
                        child: widget,
                      );
                    },
                    child: completed
                        ? Icon(
                            Icons.check,
                            size: 20,
                          )
                        : SizedBox(),
                  ),
                ),
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
