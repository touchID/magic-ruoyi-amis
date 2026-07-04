import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class CircularCountdown extends StatefulWidget {
  final int durationSeconds;
  final double radius;
  final Color strokeColor;
  final double strokeWidth;
  final VoidCallback? onComplete;
  final Widget? child;
  final Function(void Function(double))? onControllerReady;

  const CircularCountdown({
    super.key,
    required this.durationSeconds,
    this.radius = 50.0,
    this.strokeColor = Colors.blue,
    this.strokeWidth = 4.0,
    this.onComplete,
    this.child,
    this.onControllerReady,
  });

  @override
  State<CircularCountdown> createState() => _CircularCountdownState();
}

class _CircularCountdownState extends State<CircularCountdown> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _remainingSeconds = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.durationSeconds),
    );

    _animation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );

    _controller.addListener(() {
      setState(() {
        _remainingSeconds = (widget.durationSeconds * _controller.value).round();
      });
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onComplete?.call();
      }
    });

    SchedulerBinding.instance.addPostFrameCallback((_) {
      widget.onControllerReady?.call((double value) {
        if (_controller.value != value) {
          final double difference = (_controller.value - value).abs();
          final Duration animationDuration = Duration(milliseconds: (widget.durationSeconds * 1000 * difference).round());

          _controller.animateTo(
            value,
            duration: animationDuration,
            curve: Curves.linear,
          );
        }
      });
      _remainingSeconds = widget.durationSeconds;
    });

    _remainingSeconds = widget.durationSeconds;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void restart() {
    if (_controller.isAnimating) {
      _controller.stop();
    }
    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: widget.radius * 2,
          height: widget.radius * 2,
          child: CircularProgressIndicator(
            value: _animation.value,
            strokeWidth: widget.strokeWidth,
            valueColor: AlwaysStoppedAnimation<Color>(widget.strokeColor),
            backgroundColor: const Color(0xFFEEEEEE),
          ),
        ),
        widget.child ?? const SizedBox.shrink(),
      ],
    );
  }
}