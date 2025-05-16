import 'package:comunidadesucv/core/models/question.dart';
import 'package:comunidadesucv/features/communities/data/dto/space_dto.dart';
import 'package:comunidadesucv/features/community_feed/data/repository/community_feed_repository.dart';
import 'package:comunidadesucv/features/community_forum/data/repository/community_forum_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommunityForumController extends GetxController {
  final Space space = Get.arguments;
  final Rx<IconData> spaceIcon = Rx<IconData>(Icons.group);
  final RxList<Question> dataQuestion = <Question>[].obs;
  CommunityForumRepository communityForumRepository =
      CommunityForumRepository();
  CommunityFeedRepository communityFeedRepository = CommunityFeedRepository();

  int currentPage = 1;
  var isLoading = false.obs;
  var isLoadingMore = false.obs;
  var isLoadingPrevious = false.obs;
  var hasMoreQuestions = true.obs;
  final int questionsLimit = 20;

  // Variables para la búsqueda
  final RxString searchQuery = ''.obs;
  final RxBool isSearchActive = false.obs;
  final RxMap<int, bool> userLikes = <int, bool>{}.obs;

  // Controlador para el scroll
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    _setSpaceIcon();
    loadInitialQuestions();

    // Agrega un listener al scrollController
    scrollController.addListener(_scrollListener);

    // Agrega un listener al searchQuery para actualizar los resultados cuando cambie
    debounce(
      searchQuery,
      (_) => loadInitialQuestions(),
      time: Duration(milliseconds: 500),
    );
  }

  @override
  void onClose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.onClose();
  }

  void _scrollListener() {
    // Cargar más preguntas cuando se llega al final
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200 &&
        !isLoading.value &&
        !isLoadingMore.value &&
        hasMoreQuestions.value) {
      loadMoreQuestions();
    }

    // Cargar preguntas anteriores cuando se llega al principio
    if (scrollController.position.pixels <= 100 &&
        !isLoading.value &&
        !isLoadingPrevious.value &&
        currentPage > 1) {
      loadPreviousQuestions();
    }
  }

  void _setSpaceIcon() {
    // Código actual sin cambios
    switch (space.name) {
      case "UCV Connect":
        spaceIcon.value = Icons.link;
        break;
      case "UCV Pet Lovers":
        spaceIcon.value = Icons.pets;
        break;
      case "Comunidad Literaria UCV":
        spaceIcon.value = Icons.book;
        break;
      case "Eco UCV":
        spaceIcon.value = Icons.eco;
        break;
      case "Kpop Squad UCV":
        spaceIcon.value = Icons.music_note;
        break;
      case "Emprendedores UCV":
        spaceIcon.value = Icons.lightbulb_outline;
        break;
      default:
        spaceIcon.value = Icons.group;
        break;
    }
  }

  // Función para alternar la búsqueda
  void toggleSearch() {
    isSearchActive.value = !isSearchActive.value;
    if (!isSearchActive.value) {
      searchQuery.value = '';
      loadInitialQuestions();
    }
  }

  // Función para actualizar la consulta de búsqueda
  void updateSearchQuery(String query) async {
    searchQuery.value = query;
    currentPage = 1;
    hasMoreQuestions.value = true;
    isLoading.value = true;

    try {
      final response = await communityForumRepository.questionsContainerSpace(
          space.contentContainerId,
          questionsLimit,
          currentPage,
          searchQuery.value);

      if (response.results.isEmpty) {
        dataQuestion.clear();
        hasMoreQuestions.value = false;
      } else {
        final filteredQuestionArchived = response.results
            .where((item) => item.content.metadata.archived == false)
            .toList();
        dataQuestion.assignAll(filteredQuestionArchived);
        hasMoreQuestions.value = response.results.length >= questionsLimit;
      }
    } catch (e) {
      print('Error searching questions: ${e.toString()}');
    } finally {
      isLoading.value = false;
      if (scrollController.hasClients) {
        scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    }
  }

  Future<void> loadInitialQuestions() async {
    if (isLoading.value) return;

    isLoading.value = true;
    currentPage = 1;

    try {
      final response = await communityForumRepository.questionsContainerSpace(
          space.contentContainerId,
          questionsLimit,
          currentPage,
          searchQuery.value);

      if (response.results.isEmpty) {
        hasMoreQuestions.value = false;
      } else {
        final filteredQuestionArchived = response.results
            .where((item) => item.content.metadata.archived == false)
            .toList();
        dataQuestion.assignAll(filteredQuestionArchived);
        hasMoreQuestions.value = response.results.length >= questionsLimit;
      }
    } catch (e) {
      print('Error loading initial questions: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMoreQuestions() async {
    if (isLoadingMore.value || !hasMoreQuestions.value) return;

    isLoadingMore.value = true;
    final nextPage = currentPage + 1;

    try {
      final response = await communityForumRepository.questionsContainerSpace(
          space.contentContainerId,
          questionsLimit,
          nextPage,
          searchQuery.value);

      if (response.results.isEmpty) {
        hasMoreQuestions.value = false;
      } else {
        final filteredQuestionArchived = response.results
            .where((item) => item.content.metadata.archived == false)
            .toList();
        dataQuestion.addAll(filteredQuestionArchived);
        hasMoreQuestions.value = response.results.length >= questionsLimit;
        currentPage = nextPage; // Solo actualiza currentPage si es exitoso
      }
    } catch (e) {
      print('Error loading more questions: ${e.toString()}');
    } finally {
      isLoadingMore.value = false;
    }
  }

  Future<void> loadPreviousQuestions() async {
    if (isLoadingPrevious.value || currentPage <= 1) return;

    isLoadingPrevious.value = true;
    final previousPage = currentPage - 1;

    try {
      final response = await communityForumRepository.questionsContainerSpace(
          space.contentContainerId,
          questionsLimit,
          previousPage,
          searchQuery.value);

      if (response.results.isNotEmpty) {
        final filteredQuestionArchived = response.results
            .where((item) => item.content.metadata.archived == false)
            .toList();
        dataQuestion.insertAll(0, filteredQuestionArchived);
        currentPage = previousPage;
      }
    } catch (e) {
      print('Error loading previous questions: ${e.toString()}');
    } finally {
      isLoadingPrevious.value = false;
    }
  }

  // Función para refrescar los posts (usado con RefreshIndicator)
  Future<void> refreshQuestions() async {
    return loadInitialQuestions();
  }

  // El resto de tu código...
  String getRelativeTime(DateTime dateTime) {
    // Código actual sin cambios
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} año${(difference.inDays / 365).floor() > 1 ? 's' : ''}';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} mes${(difference.inDays / 30).floor() > 1 ? 'es' : ''}';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} día${difference.inDays > 1 ? 's' : ''}';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hora${difference.inHours > 1 ? 's' : ''}';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minuto${difference.inMinutes > 1 ? 's' : ''}';
    } else {
      return 'Ahora';
    }
  }

  void toggleLikePost(int questionId) async {
    // Código actual sin cambios
    if (userLikes.containsKey(questionId)) {
      return;
    } else {
      userLikes[questionId] = true;
    }

    final questionIndex =
        dataQuestion.indexWhere((question) => question.id == questionId);

    if (questionIndex != -1) {
      if (userLikes[questionId]!) {
        try {
          final question = dataQuestion[questionIndex];
          question.content.likes.total++;
          dataQuestion[questionIndex] = question;
          await communityFeedRepository.addLike(
              "humhub\\modules\\questions\\models\\Question",
              dataQuestion[questionIndex].id);
        } catch (e) {
          final question = dataQuestion[questionIndex];
          question.content.likes.total--;
          dataQuestion[questionIndex] = question;
        }
      } else {
        try {
          final question = dataQuestion[questionIndex];
          question.content.likes.total++;
          dataQuestion[questionIndex] = question;
          await communityFeedRepository.addLike(
              "humhub\\modules\\questions\\models\\Question",
              dataQuestion[questionIndex].id);
        } catch (e) {
          final question = dataQuestion[questionIndex];
          question.content.likes.total++;
          dataQuestion[questionIndex] = question;
        }
      }
    }
  }
}
