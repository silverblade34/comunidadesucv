import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SimpleLikeButtonAnimation extends StatefulWidget {
  final int postId;
  final bool isLiked;
  final Function(int) onToggle;

  const SimpleLikeButtonAnimation({
    super.key,
    required this.postId,
    required this.isLiked,
    required this.onToggle,
  });

  @override
  State<SimpleLikeButtonAnimation> createState() => _SimpleLikeButtonAnimationState();
}

class _SimpleLikeButtonAnimationState extends State<SimpleLikeButtonAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;
  bool _wasLiked = false;

  @override
  void initState() {
    super.initState();
    _wasLiked = widget.isLiked;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _bounceAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.5),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.5, end: 0.8),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.8, end: 1.0),
        weight: 40,
      ),
    ]).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void didUpdateWidget(SimpleLikeButtonAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_wasLiked && widget.isLiked) {
      _controller.reset();
      _controller.forward();
    }
    _wasLiked = widget.isLiked;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onToggle(widget.postId);
        HapticFeedback.lightImpact();
      },
      child: AnimatedBuilder(
        animation: _bounceAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: widget.isLiked ? _bounceAnimation.value : 1.0,
            child: Icon(
              widget.isLiked ? Icons.favorite : Icons.favorite_border_outlined,
              color: widget.isLiked ? Colors.red : Colors.pink,
              size: 23,
              key: ValueKey<bool>(widget.isLiked),
            ),
          );
        },
      ),
    );
  }
}