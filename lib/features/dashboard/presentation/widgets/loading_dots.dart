import 'package:flutter/material.dart';

class LoadingDots extends StatefulWidget {
  final TextStyle style;
  const LoadingDots({super.key, required this.style});

  @override
  State<LoadingDots> createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<LoadingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _dotCount = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..addListener(() {
        final newCount = (_controller.value * 4).floor() % 4;
        if (newCount != _dotCount) {
          setState(() {
            _dotCount = newCount;
          });
        }
      });
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        '.' * _dotCount,
        style: widget.style,
      ),
    );
  }
}
