import 'package:flutter/material.dart';

class ControlledProgressIndicator extends StatefulWidget {
  final int total;
  final int completed;
  final Color color;
  ControlledProgressIndicator({
    @required this.total,
    @required this.completed,
    @required this.color,
  }) : assert(total != null && completed != null && color != null);
  @override
  _ControlledProgressIndicatorState createState() =>
      _ControlledProgressIndicatorState();
}

class _ControlledProgressIndicatorState
    extends State<ControlledProgressIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..addListener(() {
        setState(() {});
      });
    _controller.animateTo(this.widget.total > 0
        ? (this.widget.completed / this.widget.total)
        : 0.0);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ControlledProgressIndicator oldWidget) {
    final double value = this.widget.total > 0
        ? (this.widget.completed / this.widget.total)
        : 0.0;
    if (value != _controller.value) {
      _controller.animateTo(value);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      valueColor: new AlwaysStoppedAnimation<Color>(this.widget.color),
      value: _controller.value,
    );
  }
}
