import 'package:comunidadesucv/config/constants/colors.dart';
import 'package:comunidadesucv/config/routes/pages.dart';
import 'package:comunidadesucv/features/community_feed/presentation/widgets/animated_search.dart';
import 'package:comunidadesucv/features/community_forum/controllers/community_forum_controller.dart';
import 'package:comunidadesucv/features/community_forum/presentation/widgets/animated_search_forum.dart';
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
      body: Column(
        children: [
          // Widget de búsqueda
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Obx(() => AnimatedSearch(
                  onSearch: controller.updateSearchQuery,
                  isSearchActive: controller.isSearchActive.value,
                  onSearchTap: controller.toggleSearch,
                  hintText: "Buscar en el foro...",
                )),
          ),
          
          Expanded(
            child: RefreshIndicator(
              onRefresh: controller.refreshQuestions,
              child: Obx(() {
                return CustomScrollView(
                  controller: controller.scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    // Indicador de carga para cargar preguntas anteriores
                    SliverToBoxAdapter(
                      child: Obx(() => controller.isLoadingPrevious.value
                          ? Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Center(
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(petPrimary),
                                  ),
                                ),
                              ),
                            )
                          : SizedBox.shrink()),
                    ),
                    
                    // Título del foro
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16, top: 8),
                        child: Text(
                          "Lo que dice la comunidad de ${controller.space.name}",
                          style: textStyle17Bold,
                        ),
                      ),
                    ),
                    
                    // Botón para crear nuevo tema
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
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
                    ),
                    
                    // Estado de carga inicial
                    SliverToBoxAdapter(
                      child: Container(
                        height: 16,
                      ),
                    ),
                    
                    // Contenido principal
                    SliverToBoxAdapter(
                      child: _buildMainContent(controller, textSecondary),
                    ),
                    
                    // Indicador de carga para más preguntas
                    SliverToBoxAdapter(
                      child: Obx(() => controller.hasMoreQuestions.value && controller.isLoadingMore.value
                          ? Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(petPrimary),
                                ),
                              ),
                            )
                          : SizedBox.shrink()),
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent(CommunityForumController controller, Color textSecondary) {
    if (controller.isLoading.value && controller.dataQuestion.isEmpty) {
      return _buildLoadingShimmers();
    }

    if (!controller.isLoading.value && controller.dataQuestion.isEmpty) {
      // Mostrar mensaje diferente si está buscando
      if (controller.isSearchActive.value && controller.searchQuery.value.isNotEmpty) {
        return Center(
          child: Column(
            children: [
              SizedBox(height: 32),
              Icon(
                Icons.search_off,
                size: 64,
                color: textSecondary.withOpacity(0.5),
              ),
              SizedBox(height: 16),
              Text(
                'No se encontraron resultados para "${controller.searchQuery.value}"',
                style: TextStyle(
                  color: textSecondary,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }

      // Mensaje cuando no hay preguntas
      return Center(
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
      );
    }

    // Lista de preguntas
    if (controller.dataQuestion.isNotEmpty) {
      return ListView.separated(
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
      );
    }

    return SizedBox.shrink();
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
