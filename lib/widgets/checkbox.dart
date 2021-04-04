import 'package:flutter/material.dart';

class AnimatedCheckBox extends StatelessWidget {
  final Color color;
  final bool checked;
  final Duration animationDuration;
  final Function(bool) onChanged;
  AnimatedCheckBox({
    @required this.checked,
    this.color = Colors.blue,
    this.animationDuration = const Duration(milliseconds: 200),
    this.onChanged,
  }) : assert(checked != null);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(1000),
      onTap: this.onChanged != null
          ? () {
              this.onChanged(!this.checked);
            }
          : null,
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: this.color,
          shape: BoxShape.circle,
        ),
        child: AnimatedContainer(
          duration: animationDuration,
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: checked
                ? Colors.transparent
                : Theme.of(context).cardTheme.color,
            shape: BoxShape.circle,
          ),
          child: AnimatedSwitcher(
            duration: animationDuration,
            transitionBuilder: (Widget widget, Animation<double> animation) {
              return ScaleTransition(
                scale: animation,
                child: widget,
              );
            },
            child: checked
                ? Icon(
                    Icons.check,
                    key: Key('animated-checkbox-icon'),
                    size: 20,
                  )
                : SizedBox(
                    key: Key('animated-checkbox-spacer'),
                  ),
          ),
        ),
      ),
    );
  }
}
