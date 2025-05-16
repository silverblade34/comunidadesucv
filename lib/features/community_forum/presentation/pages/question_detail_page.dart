import 'package:comunidadesucv/config/constants/colors.dart';
import 'package:comunidadesucv/core/widgets/avatar_image.dart';
import 'package:comunidadesucv/features/community_forum/controllers/question_detail_controller.dart';
import 'package:comunidadesucv/features/community_forum/data/dto/answers_response_dto.dart';
import 'package:comunidadesucv/features/community_forum/presentation/widgets/question_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class QuestionDetailPage extends GetView<QuestionDetailController> {
  const QuestionDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Ionicons.chevron_back,
            color: Colors.white,
          ),
          onPressed: () => Get.back(result: true),
        ),
        backgroundColor: AppColors.backgroundDarkIntense,
        title: Text(
          'Detalle de pregunta',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
        ),
        elevation: 0,
      ),
      body: Obx(() => controller.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _buildQuestionDetail(context)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implementar funcionalidad para agregar una respuesta
          _showAddAnswerSheet(context);
        },
        child: const Icon(Icons.question_answer),
      ),
    );
  }

  Widget _buildQuestionDetail(BuildContext context) {
    return RefreshIndicator(
      onRefresh: controller.getAnswers,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => QuestionCard(
                  question: controller.question,
                  likes: controller.likes.value,
                  statusComment: false,
                  onLike: () {
                    controller.toggleLikePost();
                  },
                  onComment: () {
                    // Mostrar comentarios
                    _showCommentsSheet(
                        context, "question", controller.question.id);
                  }),
            ),
            const SizedBox(height: 16),
            _buildAnswersHeader(),
            _buildAnswersList(),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswersHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            'Respuestas (${controller.answers.length})',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          DropdownButton<String>(
            value: controller.sortOrder.value,
            onChanged: (value) {
              if (value != null) {
                controller.changeSortOrder(value);
              }
            },
            items: const [
              DropdownMenuItem(
                value: "recent",
                child: Text(
                  "Más recientes",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              DropdownMenuItem(
                value: "votes",
                child: Text(
                  "Más votadas",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ],
            underline: Container(),
            icon: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: const Icon(Icons.sort, size: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnswersList() {
    if (controller.answers.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            children: [
              Icon(Icons.question_answer_outlined,
                  size: 64, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                "Todavía no hay respuestas",
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
              SizedBox(height: 8),
              Text(
                "¡Sé el primero en responder!",
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: controller.answers.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final answer = controller.answers[index];
        final bool isBestAnswer = controller.question.bestAnswer == answer.id;

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 2,
          color: AppColors.backgroundDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: isBestAnswer
                ? const BorderSide(color: Colors.green, width: 2)
                : BorderSide.none,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isBestAnswer)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "✓ MEJOR RESPUESTA",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  answer.answer,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    _buildVoteButtons(answer),
                  ],
                ),
              ),
              const Divider(),
              ListTile(
                leading: ClipOval(
                  child: AvatarImage(
                    avatar: 'https://trilce.ucv.edu.pe/Fotos/Mediana/${answer.createdBy.codigo}.jpg',
                    avatarError: answer.createdBy.imageUrl,
                    width: 35,
                    height: 35,
                  ),
                ),
                title: Text(
                  answer.createdBy.displayName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 12),
                ),
                subtitle: Text(
                  answer.createdBy.carrera,
                  style: const TextStyle(fontSize: 12),
                ),
                trailing: Wrap(
                  spacing: 16,
                  children: [
                    // _buildActionIcon(
                    //   Icons.thumb_up_outlined,
                    //   answer.likes.total.toString(),
                    //   () {
                    //     // Implementar funcionalidad de likes
                    //   },
                    // ),
                    if (!isBestAnswer && controller.isQuestionAuthor())
                      _buildActionIcon(
                        Icons.check_circle_outline,
                        "",
                        () {
                          // Marcar como mejor respuesta
                          controller.markAsBestAnswer(answer.id);
                        },
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildVoteButtons(Answer answer) {
    return Row(
      children: [
        InkWell(
          onTap: () => controller.voteUpAnswer(answer.id),
          borderRadius: BorderRadius.circular(4),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.arrow_upward),
          ),
        ),
        Text(
          answer.votesSummary.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        InkWell(
          onTap: () => controller.voteDownAnswer(answer.id),
          borderRadius: BorderRadius.circular(4),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.arrow_downward),
          ),
        ),
      ],
    );
  }

  Widget _buildActionIcon(IconData icon, String count, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18),
            if (count.isNotEmpty) ...[
              const SizedBox(width: 4),
              Text(count),
            ],
          ],
        ),
      ),
    );
  }

  void _showCommentsSheet(BuildContext context, String type, int id) {
    // Mostrar los comentarios en un bottom sheet
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (_, scrollController) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Text(
                    "Comentarios",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            const Divider(),
            Expanded(
              child: ListView(
                controller: scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  // Aquí iría la lista de comentarios según el tipo y el ID
                  // que se debería cargar usando el controlador
                ],
              ),
            ),
            _buildCommentInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildCommentInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Escribe un comentario...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
              maxLines: null,
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.backgroundDarkLigth,
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () {
                // Enviar comentario
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showAddAnswerSheet(BuildContext context) {
    final TextEditingController answerController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.backgroundDarkIntense,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Tu respuesta",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: answerController,
                decoration: const InputDecoration(
                  hintText: "Escribe tu respuesta aquí...",
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all(AppColors.backgroundDarkLigth),
                  ),
                  onPressed: () {
                    if (answerController.text.isNotEmpty) {
                      // Publicar respuesta
                      controller.postAnswer(answerController.text);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    "Publicar respuesta",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
