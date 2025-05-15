import 'package:comunidadesucv/config/constants/colors.dart';
import 'package:comunidadesucv/config/routes/pages.dart';
import 'package:comunidadesucv/features/community_forum/controllers/community_forum_controller.dart';
import 'package:comunidadesucv/features/community_forum/presentation/widgets/question_card.dart';
import 'package:comunidadesucv/features/community_forum/presentation/widgets/question_card_shimmer.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class CommunityForumPage extends GetView<CommunityForumController> {
  const CommunityForumPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Get.isDarkMode;
    final textSecondary = isDarkMode ? Colors.white70 : Colors.black54;
    final petPrimary = AppColors.backgroundDarkIntense;
    final textStyle17Bold = TextStyle(
      fontSize: 15,
      color: textSecondary,
    );

    // Create a scroll controller to detect scroll positions
    final ScrollController scrollController = ScrollController();
    
    // Add scroll listener when the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.addListener(() {
        // Load more questions when reaching the bottom
        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200 &&
            !controller.isLoading.value &&
            controller.hasMoreQuestions.value) {
          controller.loadMoreQuestions();
        }
        
        // Load previous questions when scrolling to the top
        if (scrollController.position.pixels <= 100 &&
            !controller.isLoading.value &&
            controller.currentPage > 1) {
          controller.loadPreviousQuestions();
        }
      });
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: petPrimary,
        leading: IconButton(
          icon: Icon(Ionicons.chevron_back, color: Colors.white),
          onPressed: () => Get.back(result: true),
        ),
        title: Row(
          children: [
            Obx(() => Icon(
                  controller.spaceIcon.value,
                  color: Colors.white,
                  size: 24,
                )),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Foro ${controller.space.name}',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: RefreshIndicator(
        onRefresh: controller.loadInitialQuestions,
        child: Obx(() {
          return ListView(
            controller: scrollController, // Add the scroll controller here
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16),
                child: Text(
                  "Lo que dice la comunidad de ${controller.space.name}",
                  style: textStyle17Bold,
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16),
                child: InkWell(
                  onTap: () async {
                    final response = await Get.toNamed('/create_forum',
                        arguments: controller.space.contentContainerId);
                    if (response) {
                      await controller.loadInitialQuestions();
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        "CREAR NUEVO TEMA",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              if (controller.isLoading.value && controller.dataQuestion.isEmpty)
                _buildLoadingShimmers(),
              if (!controller.isLoading.value &&
                  controller.dataQuestion.isEmpty)
                Center(
                  child: Column(
                    children: [
                      SizedBox(height: 32),
                      Icon(
                        Icons.question_answer_outlined,
                        size: 64,
                        color: textSecondary.withOpacity(0.5),
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Aún no hay preguntas en este foro",
                        style: TextStyle(
                          color: textSecondary,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "¡Sé el primero en publicar!",
                        style: TextStyle(
                          color: textSecondary.withOpacity(0.7),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              if (controller.dataQuestion.isNotEmpty)
                ListView.separated(
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 0);
                  },
                  itemCount: controller.dataQuestion.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    final question = controller.dataQuestion[index];

                    return GestureDetector(
                      onTap: () async {
                        final result = await Get.toNamed(Routes.questionDetail,
                            arguments: question);
                        if (result) {
                          await controller.loadInitialQuestions();
                        }
                      },
                      child: QuestionCard(
                          question: question,
                          likes: question.content.likes.total,
                          titleFontSize: 14,
                          descriptionFontSize: 12,
                          descriptionName: 11,
                          onLike: () {
                            controller.toggleLikePost(question.id);
                          },
                          onComment: () async {
                            final result = await Get.toNamed(
                                Routes.questionDetail,
                                arguments: question);
                            if (result) {
                              await controller.loadInitialQuestions();
                            }
                          }),
                    );
                  },
                ),
              // Loading indicator at the bottom for pagination
              if (controller.hasMoreQuestions.value)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Center(
                    child: controller.isLoadingMore.value
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(petPrimary),
                          )
                        : SizedBox.shrink(),
                  ),
                ),
              // Loading indicator at the top for loading previous pages
              if (controller.isLoadingPrevious.value && controller.currentPage > 1)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(petPrimary),
                    ),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildLoadingShimmers() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5, // Mostrar 5 shimmers de carga
      itemBuilder: (context, index) {
        return QuestionCardShimmer();
      },
    );
  }
}