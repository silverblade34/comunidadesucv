import 'package:flutter/material.dart';

class AnimatedCounter extends StatelessWidget {
  final int count;
  final TextStyle style;
  
  const AnimatedCounter({
    super.key,
    required this.count,
    required this.style,
  });
  
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 300),
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.8 + (value * 0.2), // Scale from 0.8 to 1.0
          child: Opacity(
            opacity: value,
            child: Text(
              '$count',
              style: style,
              key: ValueKey<int>(count),
            ),
          ),
        );
      },
    );
  }
}