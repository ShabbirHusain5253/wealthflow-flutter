import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RotatingLoader extends StatefulWidget {
  final double size;
  const RotatingLoader({super.key, this.size = 24});

  @override
  State<RotatingLoader> createState() => _RotatingLoaderState();
}

class _RotatingLoaderState extends State<RotatingLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: SvgPicture.asset(
        'assets/svgs/loader.svg',
        width: widget.size,
        height: widget.size,
      ),
    );
  }
}
