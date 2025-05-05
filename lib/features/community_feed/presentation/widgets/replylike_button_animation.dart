import 'package:comunidadesucv/features/community_detail/data/dto/content_space_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Primero, vamos a crear un widget para el botón de like en respuestas
class ReplyLikeButtonAnimation extends StatefulWidget {
  final int commentId;
  final bool isLiked;
  final Function(CommentItem) onToggle;
  final CommentItem comment;

  const ReplyLikeButtonAnimation({
    super.key,
    required this.commentId,
    required this.isLiked,
    required this.comment,
    required this.onToggle,
  });

  @override
  State<ReplyLikeButtonAnimation> createState() => _ReplyLikeButtonAnimationState();
}

class _ReplyLikeButtonAnimationState extends State<ReplyLikeButtonAnimation>
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
  void didUpdateWidget(ReplyLikeButtonAnimation oldWidget) {
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
        widget.onToggle(widget.comment);
        HapticFeedback.lightImpact();
      },
      child: AnimatedBuilder(
        animation: _bounceAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: widget.isLiked ? _bounceAnimation.value : 1.0,
            child: Row(
              children: [
                Icon(
                  widget.isLiked ? Icons.favorite : Icons.favorite_border,
                  size: 14, // Tamaño más pequeño para respuestas
                  color: widget.isLiked ? Colors.red : Colors.grey,
                  key: ValueKey<bool>(widget.isLiked),
                ),
                const SizedBox(width: 3),
                Text(
                  '${widget.comment.likes.total}',
                  style: TextStyle(
                    color: widget.isLiked ? Colors.red : Colors.grey,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
