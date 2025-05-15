import 'package:comunidadesucv/config/constants/colors.dart';
import 'package:comunidadesucv/core/models/question.dart';
import 'package:comunidadesucv/core/widgets/avatar_image.dart';
import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  final Question question;
  final VoidCallback onLike;
  final VoidCallback onComment;
  final int likes;
  final double titleFontSize;
  final double descriptionFontSize;
  final double descriptionName;
  final bool statusComment;

  const QuestionCard({
    super.key,
    required this.question,
    required this.likes,
    required this.onLike,
    required this.onComment,
    this.titleFontSize = 16,
    this.descriptionFontSize = 14,
    this.descriptionName = 12,
    this.statusComment = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      elevation: 2,
      color: AppColors.backgroundDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título de la pregunta
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              question.question,
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Descripción
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
            child: Text(
              question.description,
              style: TextStyle(fontSize: descriptionFontSize),
            ),
          ),

          const Divider(
            height: 1,
          ),

          // Autor
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 17, vertical: 1),
            leading: ClipOval(
              child: AvatarImage(
                avatar: question.createdBy.imageUrl,
                avatarError:
                    'https://trilce.ucv.edu.pe/Fotos/Mediana/${question.createdBy.codigo}.jpg',
                width: 40,
                height: 40,
              ),
            ),
            title: Text(
              question.createdBy.displayName,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: descriptionName),
            ),
            subtitle: Text(
              "${question.createdBy.carrera} - ${question.createdBy.filial}",
              style: TextStyle(fontSize: descriptionName),
            ),
            trailing: Wrap(
              spacing: 16,
              children: [
                _buildActionIcon(
                  Icons.thumb_up_outlined,
                  likes.toString(),
                  onLike,
                ),
                if (statusComment) ...[
                  _buildActionIcon(
                    Icons.comment_outlined,
                    question.answerCount.toString(),
                    onComment,
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionIcon(IconData icon, String count, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20, color: Colors.white),
          const SizedBox(width: 4),
          Text(count, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
